//
//  DHBPaymentsSiftingTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELLHEIGHT 50.0F
#define DATEPICKER_HEIGHT 140.0f
#import <Foundation/Foundation.h>
#import "RBCustomDatePickerView.h"

@protocol DHBPaymentsSiftingTableViewCell_Delegate <NSObject>
- (void)paymentsSiftingTableViewCell_TextFieldDidBeginEditing:(UITextField *)textField;
- (void)paymentsSiftingTableViewCell_DidCancelButtonClick;
- (void)paymentsSiftingTableViewCell_DidOkButtonClick: pickerView selectTime: selectTime;
@end

@interface DHBPaymentsSiftingTableViewCell : UITableViewCell<DHBTextField_Delegate,RBCustomDatePickerViewDelegate>
{
    CGFloat textFiledWidth;
}
@property(nonatomic, assign) NSInteger curOperateIndex;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UILabel *depositTypeLabel; //付款方式
@property(nonatomic, retain) UILabel *payTypeLabel; //支付类型
@property(nonatomic, retain) DHBTextField *startTimeTextFiled; //开始时间
@property(nonatomic, retain) UIView *lineView; //时间连接线
@property(nonatomic, retain) UIView *separatorView; //分割线
@property(nonatomic, retain) DHBTextField *endTimeTextField; //结束时间
@property(nonatomic, retain) RBCustomDatePickerView * datepicker;

@property(nonatomic, assign) id<DHBPaymentsSiftingTableViewCell_Delegate> delegate;

- (void)updateViewWithIndexpath: (NSIndexPath *) indexPath size:(CGSize) size;
@end
