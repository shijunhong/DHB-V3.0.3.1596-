//
//  DHBShoppingCarOrderView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBShoppingCarOrderTableViewCell.h"
#import "DHBSubmitOrderService.h"

@protocol DHBShoppingCarOrderView_Delegate <NSObject>
@optional
/**
 *  点击发票的cell
 *
 *  @param cell 当前cell
 */
- (void)shoppingCarOrderView_DidInvoiceAction:(DHBShoppingCarOrderTableViewCell *)cell;
/**
 *  点击收货地址的cell
 *
 *  @param cell 当前cell
 */
- (void)shoppingCarOrderView_DidAddressAction:(DHBShoppingCarOrderTableViewCell *)cell;
@end

@interface DHBShoppingCarOrderView : UIView<UITableViewDataSource, UITableViewDelegate, DHBShoppingCarOrderTableViewCell_Delegate, DHBSubmitOrderService_Delegate>
{
    /**
     *  默认的TextView的y坐标
     */
    CGFloat defaultViewTop;
}
/**
 *  主数据视图
 */
@property(nonatomic, retain) UITableView *mainTableView;
/**
 *  代理对象
 */
@property(nonatomic, assign) id<DHBShoppingCarOrderView_Delegate> delegate;
/**
 *  用户提交订单数据模型
 */
@property(nonatomic, strong) UserInformationModuleDTO *userInfoDTO;
/**
 *  提交订单服务类
 */
@property(nonatomic, strong) DHBSubmitOrderService *mainService;

/**
 *  public method
 */
- (void)reloadData;
@end
