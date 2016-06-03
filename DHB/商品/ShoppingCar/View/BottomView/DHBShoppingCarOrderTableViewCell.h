//
//  DHBShoppingCarOrderTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBCustomDatePickerView.h"
#import "HomeFloorDTO.h"
#import "UserInformationModuleDTO.h"

#define DATEPICKER_HEIGHT 200.0f
@class DHBShoppingCarOrderTableViewCell;
@protocol DHBShoppingCarOrderTableViewCell_Delegate <NSObject>
@optional
- (void)shoppingCarOrderTableViewCell_DidCancelButtonClick;
- (void)shoppingCarOrderTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *) button selectTime:(NSString*)selectTime;
- (void)shoppingCarOrderTableViewCell_textViewDidBeginEditing:(UITextView *)textView cell: (DHBShoppingCarOrderTableViewCell *)cell;
- (void)shoppingCarOrderTableViewCell_textViewDidEndEditing:(UITextView *)textView cell: (DHBShoppingCarOrderTableViewCell *)cell;
@end

@interface DHBShoppingCarOrderTableViewCell : UITableViewCell<RBCustomDatePickerViewDelegate, UITextViewDelegate, DHBTextField_Delegate>
/**
 *  标题视图
 */
@property(nonatomic, retain) UILabel *titleLabel;
/**
 *  商品金额
 */
@property(nonatomic, retain) UILabel *priceLabel;
/**
 *  发票类型
 */
@property(nonatomic, retain) UILabel *invoiceTypeLabel;
/**
 *  发货时间
 */
@property(nonatomic, retain) UILabel *sendTimeLabel;
/**
 *  配送方式
 */
@property(nonatomic, retain) DHBTextField *deliveryTextField;
/**
 *  收货人姓名
 */
@property(nonatomic, retain) UILabel *receiveNameLabel;
/**
 *  收货人联系方式
 */
@property(nonatomic, retain) UILabel *phoneLabel;
/**
 *  收货地址
 */
@property(nonatomic, retain) UILabel *addressLabel;
/**
 *  备注
 */
@property(nonatomic, retain) DHBTextView *remarksTextView;
/**
 *  时间选择器
 */
@property(nonatomic, retain) RBCustomDatePickerView * datepicker;
/**
 *  代理对象
 */
@property(nonatomic, assign) id<DHBShoppingCarOrderTableViewCell_Delegate> delegate;
/**
 *  当前数据楼层
 */
@property(nonatomic, strong) HomeFloorDTO * floor;

/**
 *  public method 根据数据模型更新视图数据
 *
 *  @param dto 楼层数据模型
 */
- (void)updateViewWithDTO: (HomeFloorDTO *) dto;
@end
