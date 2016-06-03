//
//  DHBEightBannerView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "HomeFloorDTO.h"
#import "ActivityModuleDTO.h"
#import "UIImageView+WebCache.h"

@protocol DHBEightBannerViewDelegate <NSObject>
@optional
/**
 *  点击后返回点击模型
 *
 *  @param DTO
 */
- (void)eightBannerSelectedDTO:(ActivityModuleDTO *)activity;

@end

@interface DHBEightBannerView : UIView <UIScrollViewDelegate>{
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

@property (nonatomic, assign) id <DHBEightBannerViewDelegate>  delegate;
@property (nonatomic, strong) UIPageControl  *pageControl;

/**
 *  依据数据源，更新界面
 *
 *  @param array dto数组
 */
- (void)updateViewWithDTO:(HomeFloorDTO *)dto UseingViewBlock:(UIView*(^)(NSObject *obj,int index))block;

- (void)invalidTimer;
@end
