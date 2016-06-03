//
//  DHBProductMaiZhengContentView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/9.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsImgScrollModelView.h"
#import "GoodsModuleDTO.h"
#define KBannerViewFrame            CGRectMake(43, 0, SCREEN_WIDTH, self.frame.size.height)
@implementation DHBGoodsImgScrollModelView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //当前显示的是第几个图片，初始化-1
        imageScrollView = [[UIScrollView alloc] initWithFrame:KBannerViewFrame];
        imageScrollView.backgroundColor = [UIColor whiteColor];
        imageScrollView.showsHorizontalScrollIndicator = YES;
        imageScrollView.showsVerticalScrollIndicator = NO;
        imageScrollView.pagingEnabled = NO;
        [self addSubview:imageScrollView];
        
    }
    return self;
}


- (void)updateViewWithDTO:(GoodsFloorDTO *)dto withJiaHao:(BOOL)flag{
    imageScrollView.contentSize = CGSizeMake((70+33) * [dto.moduleList count]+10, self.frame.size.height);
    for (int i = 0; i< [dto.moduleList count]; i++)
    {
        //bt_jia_normal
        GoodsModuleDTO *product = [dto.moduleList objectAtIndex:i];
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(70 * i + 33 * i, 0, 70, 70)];
        imageView.userInteractionEnabled = YES;
        imageView.placeholderImage = nil;
//        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", product.image]];
        imageView.tag = product.goods_id;
        imageView.layer.borderColor = HEX_RGB(0xdcdcdc).CGColor;
        imageView.layer.borderWidth = 0.5;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        if (flag)
        {
            if (i < [dto.moduleList count]-1)
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+11, imageView.center.y-11/2, 11, 11)];
                [image setImage:[UIImage imageNamed:@"bt_jia_normal"]];
                [imageScrollView addSubview:image];
                TT_RELEASE_SAFELY(image);
            }
        }
        [imageScrollView addSubview:imageView];
        TT_RELEASE_SAFELY(imageView);
    }
}


- (void)handleTap:(UITapGestureRecognizer *)sender
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"商品 %ld",[singleTap view].tag);
}

@end
