//
//  DHBProductImgEightBannerView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsFloorDTO.h"
@interface DHBGoodsImgEightBannerView : UIView <UIScrollViewDelegate>{
    UIScrollView    *imageScrollView;
    
    //dto数据源
    NSMutableArray         *dtoArray;
    
    NSTimer         *imageScrollTimer;
    
    //当前
    int             selectedImageIndex;
    
    //scroll需要展示的3个dto
    NSMutableArray         *scrollDataArray;
    
    //此楼层在首页中得楼层顺序
    NSString  *floorOrderNO;
    
}

//view 模型block
typedef UIView*(^MyBlock)(NSObject *obj,int index);
@property(nonatomic,copy)MyBlock myBlock;

@property (nonatomic, strong) UIPageControl  *pageControl;

/**
 *  依据数据源，更新界面
 *
 *  @param array dto数组
 */
- (void)updateViewWithDTO:(GoodsFloorDTO *)dto UseingViewBlock:(UIView*(^)(NSObject *obj,int index))block;

- (void)invalidTimer;


@end
