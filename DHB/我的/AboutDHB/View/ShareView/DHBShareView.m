//
//  DHBShareView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MAINVIEW_HEIGHT 300.0f
#define MARGIN 20.0F
#import "DHBShareView.h"

@implementation DHBShareView
#pragma mark - init
- (NSArray *)shareDataArray{
    if(!_shareDataArray){
        _shareDataArray = [NSMutableArray arrayWithCapacity: 5];
        for(NSInteger i = 0; i < 5; i++){
            DHBShareModuleDTO *dto = [[DHBShareModuleDTO alloc] init];
            switch (i) {
                case 0:{
                    [dto setName: @"微信好友"];
                    [dto setIcon: @"wechat"];
                    break;
                }
                case 1:{
                    [dto setName: @"朋友圈"];
                    [dto setIcon: @"wechat2"];
                    break;
                }
                case 2:{
                    [dto setName: @"微博"];
                    [dto setIcon: @"weibo"];
                    break;
                }
                case 3:{
                    [dto setName: @"QQ好友"];
                    [dto setIcon: @"qq"];
                    break;
                }
                case 4:{
                    [dto setName: @"QQ空间"];
                    [dto setIcon: @"qzone"];
                    break;
                }
                default:
                    break;
            }
            [_shareDataArray addObject: dto];
        }
    }
    return _shareDataArray;
}

- (UIView *)mainView{
    if(!_mainView){
        _mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, MAINVIEW_HEIGHT)];
        [_mainView setBackgroundColor: [UIColor whiteColor]];
    }
    return _mainView;
}

- (UICollectionView *)shareView{
    if(!_shareView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat size_w = (SCREEN_WIDTH - 4 * MARGIN) / 3.0f;
        CGFloat size_h = (MAINVIEW_HEIGHT * 2.0F / 3.0F - 3 * MARGIN) / 2.0f;
        [flowLayout setSectionInset: UIEdgeInsetsMake(MARGIN, MARGIN, 0.0f, MARGIN)];
        [flowLayout setMinimumLineSpacing: 0.0f];
        [flowLayout setItemSize: CGSizeMake(size_w, size_h)];
        _shareView = [[UICollectionView alloc] initWithFrame: CGRectMake(0.0f, MARGIN, SCREEN_WIDTH, MAINVIEW_HEIGHT * 2.0F / 3.0F) collectionViewLayout: flowLayout];
        [_shareView setDataSource: self];
        [_shareView setBackgroundColor: [UIColor whiteColor]];
        [_shareView registerClass: [DHBShareCollectionViewCell class] forCellWithReuseIdentifier: @"ListCell"];
        [_shareView setDelegate: self];
    }
    return _shareView;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        CGFloat origin_y = self.shareView.frame.size.height + self.shareView.frame.origin.y + MARGIN;
        _cancelButton = [[DHBButton alloc] initWithFrame: CGRectMake(MARGIN, origin_y, SCREEN_WIDTH - 2 * MARGIN, MAINVIEW_HEIGHT - origin_y - MARGIN) style: kDHBButton_StyleValue2];
        [_cancelButton setTitle: @"取消" forState: UIControlStateNormal];
        [_cancelButton addTarget: self action: @selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark -
- (id)init{
    self = [super init];
    if(self){
        [self setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self setBackgroundColor: [[UIColor alloc] initWithWhite: 0.2f alpha: 0.5f]];
        [self addShareMainView];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview: self];
    return self;
}

#pragma mark - 分享主视图
- (void)addShareMainView{
    [self addSubview: self.mainView];
    [self.mainView addSubview: self.shareView];
    [self.mainView addSubview: self.cancelButton];
}

#pragma mark - UICollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return ([self.shareDataArray count] % 3 > 0 ? [self.shareDataArray count] / 3 + 1 : [self.shareDataArray count] / 3);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((section + 1) * 3 < [self.shareDataArray count] ? 3 : [self.shareDataArray count] - section * 3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DHBShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ListCell" forIndexPath: indexPath];
    if(!cell){
        cell = [[DHBShareCollectionViewCell alloc] init];
    }
    DHBShareModuleDTO *dto = [self.shareDataArray objectAtIndex: [indexPath section] * 3 + [indexPath row]];
    [cell updateViewWithDTO: dto];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismiss];
    DHBShareModuleDTO *dto = [self.shareDataArray objectAtIndex: [indexPath section] * 3 + [indexPath row]];
    if([_delegate respondsToSelector: @selector(shareView_DidSelectShareDTO:)]){
        [_delegate shareView_DidSelectShareDTO: dto];
    }
}

#pragma mark - 
-(void)show{
    [self setHidden: NO];
    [UIView animateWithDuration: 0.5f delay: 0 usingSpringWithDamping: 0.7f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainView.top = SCREEN_HEIGHT - MAINVIEW_HEIGHT;
    } completion:^(BOOL finished) {}];
}

- (void)dismiss{
    [UIView animateWithDuration: 0.5f delay: 0 usingSpringWithDamping: 0.7f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) { [self setHidden: YES]; }];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
