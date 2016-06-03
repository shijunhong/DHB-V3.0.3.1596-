//
//  DHBEightBannerView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBEightBannerView.h"

#define KBannerViewFrame            CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)
#define kBannerPageControlFrame     CGRectMake(0, self.frame.size.height-15, SCREEN_WIDTH, 3)

@implementation DHBEightBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //接口返回的八连版总数，最大8个
        dtoArray = [[NSMutableArray alloc] init];
        
        //scroll上显示的3个DTO
        scrollDataArray = [[NSMutableArray alloc] init];
        
        //当前显示的是第几个图片，初始化-1
        selectedImageIndex = -1;
        imageScrollView = [[UIScrollView alloc] initWithFrame:KBannerViewFrame];
        imageScrollView.backgroundColor = [UIColor colorWithRGBHex:0xcbcaca];
        imageScrollView.showsHorizontalScrollIndicator = NO;
        imageScrollView.showsVerticalScrollIndicator = NO;
        imageScrollView.pagingEnabled = YES;
        imageScrollView.delegate = self;
        [self addSubview:imageScrollView];
        
        //圆点指示符
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)dealloc {
    [imageScrollTimer invalidate];
    imageScrollTimer = nil;
    
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:kBannerPageControlFrame];
        if (IOS6_OR_LATER) {
            _pageControl.pageIndicatorTintColor = [UIColor colorWithRGBHex:0xd3d3d3];
            _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGBHex:0xf14600];
        }
        _pageControl.numberOfPages = 1;
    }
    return _pageControl;
}

- (void)updateViewWithDTO:(HomeFloorDTO *)dto UseingViewBlock:(UIView*(^)(NSObject *obj,int index))block{
    if (!IsArrEmpty(dto.moduleList))
    {
        //失效定时器
        [self invalidTimer];
        
        floorOrderNO = dto.orderNO;
        
        //更新时，从0开始轮播
        selectedImageIndex = 0;
        
        //移除旧的图片
        [dtoArray removeAllObjects];
        
        //最多只展示8个
        if ([dto.moduleList count] > 8)
        {
            [dtoArray addObjectsFromArray:[dto.moduleList subarrayWithRange:NSMakeRange(0, 8)]];
        }
        else {
            [dtoArray addObjectsFromArray:dto.moduleList];
        }
        
        //block赋值
        self.myBlock = block;
        
        //更新scrollView的内容
        [self refreshScrollView];
        
        //更新pageControl总数
        self.pageControl.numberOfPages = [dtoArray count];
        if ([dtoArray count] == 0) {
            self.pageControl.hidden = YES;
        }
        else {
            self.pageControl.hidden = NO;
        }
        
        //更新八连版页面时，页面从第一个开始播放
        self.pageControl.currentPage = selectedImageIndex;
        
        //开启定时器
        [self startTimer];
    }
    else
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:KBannerViewFrame];
        [imgView setImage:[UIImage imageNamed:@"invalid"]];
        [self addSubview:imgView];
    }
}


- (void)refreshScrollView{
    
    NSArray *temp = [imageScrollView subviews];
    [temp makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    
    //scroll只加载3个图片
    //配置当前需要显示的3个DTO,若有8个dto，则应该显示第7、0、1这三个dto
    [scrollDataArray removeAllObjects];
    [scrollDataArray addObject:[dtoArray objectAtIndex:[self getPrePage]]];
    [scrollDataArray addObject:[dtoArray objectAtIndex:selectedImageIndex]];
    [scrollDataArray addObject:[dtoArray objectAtIndex:[self getNextPage]]];
    
    
    imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [scrollDataArray count], self.frame.size.height);
    for (int i = 0; i < [scrollDataArray count]; i++)
    {
        UIView *view  = self.myBlock([scrollDataArray objectAtIndex:i],i);
//
        //图片的点击事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:singleTap];
//
        [imageScrollView addSubview:view];
        TT_RELEASE_SAFELY(view);
    }
    
    
    //让scroll偏移KScreenWidth
    [imageScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    
}

- (int )getPrePage {
    int result = 0;
    if (selectedImageIndex == 0) {
        result = (int)[dtoArray count] - 1;
    }
    else {
        result = selectedImageIndex - 1;
    }
    return result;
}

- (int )getNextPage {
    int result = 0;
    if ((selectedImageIndex+1) >= [dtoArray count]) {
        result = 0;
    }
    else {
        result = selectedImageIndex + 1;
    }
    return result;
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int xOffset = scrollView.contentOffset.x;
    if ((xOffset % (int)SCREEN_WIDTH == 0))
    {
        self.pageControl.currentPage = selectedImageIndex;
    }
    
    // 水平滚动
    // 往下翻一张
    if(xOffset >= (2*SCREEN_WIDTH)) {
        //向右
        selectedImageIndex++;
        selectedImageIndex = selectedImageIndex % [dtoArray count];
        [self refreshScrollView];
    }
    if(xOffset <= 0) {
        //向左
        if (selectedImageIndex == 0) {
            selectedImageIndex = (int)[dtoArray count] - 1;
        }
        else {
            selectedImageIndex--;
        }
        [self refreshScrollView];
    }
}
//拖动开始，停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    [imageScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)startTimer {
    imageScrollTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:imageScrollTimer forMode:NSRunLoopCommonModes];
}

- (void)invalidTimer {
    [imageScrollTimer invalidate];
    imageScrollTimer = nil;
}

- (void)changeImage {
    selectedImageIndex++;
    selectedImageIndex = selectedImageIndex % [dtoArray count];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [imageScrollView.layer addAnimation:animation forKey:nil];
    
    //移除所有的ui，重新加入3个dto和3个图片
    [self refreshScrollView];
    
    self.pageControl.currentPage = selectedImageIndex;
}


- (void)handleTap:(UITapGestureRecognizer *)tap
{
    //八连版添加点击
    if ([_delegate respondsToSelector:@selector(eightBannerSelectedDTO:)]){
        [_delegate eightBannerSelectedDTO:[dtoArray objectAtIndex:selectedImageIndex]];
    }
    
}
@end
