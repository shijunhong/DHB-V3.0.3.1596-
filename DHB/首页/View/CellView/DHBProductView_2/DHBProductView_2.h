//
//  DHBProductView_2.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/27.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModuleDTO.h"
@protocol DHBProductView_2Delegate <NSObject>
@optional
- (void)productSelected_2DTO:(GoodsModuleDTO*)product;
@end


@interface DHBProductView_2 : UIView

@property (nonatomic, assign) id<DHBProductView_2Delegate> delegate;
/**
 *  依据数据源，更新界面
 *
 *  @param array dto两个商品
 */
- (void)updateViewWithDTO:(NSMutableArray *)products;
@end
