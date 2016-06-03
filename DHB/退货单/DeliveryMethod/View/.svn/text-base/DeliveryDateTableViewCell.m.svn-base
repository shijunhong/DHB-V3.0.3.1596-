//
//  DeliveryDateTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#import "DeliveryDateTableViewCell.h"

@implementation DeliveryDateTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSize: size];
        [self setBackgroundColor: [UIColor clearColor]];
        [self.layer setMasksToBounds: YES];
        [self addDatePicker];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)addDatePicker{
    if(!_datepicker){
        _datepicker = [[RBCustomDatePickerView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, CUR_DATEPICKER_HEIGHT)];
        [_datepicker setDelegate: self];
    }
    [self addSubview: _datepicker];
}

#pragma mark - RBCustomDatePickerView delegate
-(void)selectNOAction{
    if([_delegate respondsToSelector: @selector(deliveryDateTableViewCell_DidCancelButtonClick)]){
        [_delegate deliveryDateTableViewCell_DidCancelButtonClick];
    }
}

- (void)RBCustomDatePickerView:(RBCustomDatePickerView *)pickerView selectOkAction:(NSString *)selectTime
{
    if([_delegate respondsToSelector: @selector(deliveryDateTableViewCell_DidOkButtonClick:selectTime:)]){
        [_delegate deliveryDateTableViewCell_DidOkButtonClick: pickerView selectTime: selectTime];
    }
}
@end
