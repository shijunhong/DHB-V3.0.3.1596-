//
//  DeliveryDateTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#define CUR_DATEPICKER_HEIGHT 160.0F
#import <UIKit/UIKit.h>
#import "RBCustomDatePickerView.h"

@protocol DeliveryDateTableViewCell_Delegate <NSObject>
- (void)deliveryDateTableViewCell_DidCancelButtonClick;
- (void)deliveryDateTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *) button selectTime:(NSString*)selectTime;
@end

@interface DeliveryDateTableViewCell : UITableViewCell<RBCustomDatePickerViewDelegate>
@property(nonatomic, retain) RBCustomDatePickerView * datepicker;
@property(nonatomic, assign) id<DeliveryDateTableViewCell_Delegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size;
@end
