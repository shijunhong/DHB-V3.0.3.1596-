//
//  DeliveryBaseTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "DHBDeliveryMethodMoudleDTO.h"
#import "RBCustomDatePickerView.h"

@class DeliveryBaseTableViewCell;
@protocol DeliveryBaseTableViewCell_Delegate <NSObject>
//- (void)baseTableViewCell_textBeginEidt:(DeliveryBaseTableViewCell *)cell textFiled:(UITextField *)textFiled;
- (void)baseTableViewCell_textEndEidt:(DeliveryBaseTableViewCell *)cell textFiled:(UITextField *)textFiled;
- (void)baseTableViewCell_openDatePicker:(DeliveryBaseTableViewCell *)cell;
- (void)baseTableViewCell_closeDatePicker;
- (void)baseTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *)button selectTime:(NSString *)selectTime;
@end

@interface DeliveryBaseTableViewCell : UITableViewCell<UITextFieldDelegate,RBCustomDatePickerViewDelegate, DHBTextField_Delegate>
/**
 *  输入框
 */
@property(nonatomic, strong) DHBTextField *contentTextFiled;
@property(nonatomic, assign) id<DeliveryBaseTableViewCell_Delegate, DHBTableCellDelegate> delegate;
@property(nonatomic, strong) HomeFloorDTO *floorDTO;


- (void)updateViewWithDTO:(HomeFloorDTO *)dto pickerHeight: (CGFloat) pickerHeight;
@end
