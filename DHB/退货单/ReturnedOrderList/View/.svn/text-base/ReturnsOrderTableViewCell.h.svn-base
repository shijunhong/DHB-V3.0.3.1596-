//
//  ReturnsGoodsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBReturnedOrderModuleDTO.h"

@class ReturnsOrderTableViewCell;
@protocol ReturnsOrderTableViewCell_Delegate <NSObject>
- (void)retrunsGoodsTableViewCell_DidOperateButtonClick:(ReturnsOrderTableViewCell *) cell;
@end

@interface ReturnsOrderTableViewCell : UITableViewCell
/**
 *  退货单代理对象
 */
@property(nonatomic, assign) id<ReturnsOrderTableViewCell_Delegate> delegate;
/**
 *  自定义背景视图
 */
@property(nonatomic, strong) UIView *bgView;
/**
 *  cell的bannar图片
 */
@property(nonatomic, strong) UIImageView *bannerImageView;
/**
 *  分割线
 */
@property(nonatomic, strong) UIView *lineView;
/**
 *  订单编号
 */
@property(nonatomic, strong) UILabel *orderIDLabel;
/**
 *  订单状态
 */
@property(nonatomic, strong) UILabel *statusLabel;
/**
 *  商品数量
 */
@property(nonatomic, strong) UILabel *goodsNumLabel;
/**
 *  下单时间
 */
@property(nonatomic, strong) UILabel *orderTimeLabel;
/**
 *  退单金额
 */
@property(nonatomic, strong) UILabel *priceLabel;
/**
 *  操作按钮
 */
@property(nonatomic, strong) DHBButton *operateButton;
/**
 *  退货单数据模型
 */
@property(nonatomic, strong) DHBReturnedOrderModuleDTO *returnedOrder;

/**
 *  public method
 */
- (void)updateViewWithOrderDTO:(DHBReturnedOrderModuleDTO *)dto;
@end
