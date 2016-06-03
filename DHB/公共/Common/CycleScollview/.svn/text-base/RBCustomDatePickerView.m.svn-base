//
//  RBCustomDatePickerView.m
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#define BUTTON_HEIGHT 30.0f
#import "RBCustomDatePickerView.h"

@interface RBCustomDatePickerView()
@property (nonatomic, strong) UIView *pickerMainView;
@property (nonatomic, strong) UIDatePicker *mainDatePicker;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation RBCustomDatePickerView
#pragma mark - getters and setters
- (UIView *)pickerMainView{
    if(!_pickerMainView){
        _pickerMainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, self.height - BUTTON_HEIGHT - 10.0f)];
        [_pickerMainView setBackgroundColor: [UIColor whiteColor]];
        [_pickerMainView.layer setMasksToBounds: YES];
    }
    return _pickerMainView;
}

- (UIDatePicker *)mainDatePicker{
    if(!_mainDatePicker){
        _mainDatePicker = [[UIDatePicker alloc] init];
        [_mainDatePicker setFrame: CGRectMake(0.0f, 0.0f, self.pickerMainView.width, self.pickerMainView.height)];
        [_mainDatePicker setBackgroundColor: [UIColor whiteColor]];
        [_mainDatePicker setDatePickerMode: UIDatePickerModeDate];
    }
    return _mainDatePicker;
}

- (UIButton *)confirmButton{
    if(!_confirmButton){
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setTitle: @"确定" forState: UIControlStateNormal];
        [_confirmButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_confirmButton setTitleColor: [UIColor TextRed_Color] forState: UIControlStateNormal];
        [_confirmButton addTarget: self action: @selector(confirmButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle: @"取消" forState: UIControlStateNormal];
        [_cancelButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_cancelButton setTitleColor: HEX_RGB(0x666666) forState: UIControlStateNormal];
        [_cancelButton addTarget: self action: @selector(cancelButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: self.pickerMainView];
        ///加载DatePicker
        [self.pickerMainView addSubview: self.mainDatePicker];
        
        ///加载操作按钮
        [self.cancelButton setFrame: CGRectMake(0.0f, (frame.size.height - BUTTON_HEIGHT), frame.size.width / 2.0f, BUTTON_HEIGHT)];
        [self addSubview: self.cancelButton];
        [self.confirmButton setFrame: CGRectMake( frame.size.width / 2.0f, (frame.size.height - BUTTON_HEIGHT), frame.size.width / 2.0f, BUTTON_HEIGHT)];
        [self addSubview: self.confirmButton];
    }
    return self;
}

#pragma mark - 确认按钮
-(void)confirmButtonClick:(UIButton*)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *selectDate = [self.mainDatePicker date];
    if(selectDate){
        if([_delegate respondsToSelector: @selector(RBCustomDatePickerView:selectOkAction:)]){
            [self.delegate RBCustomDatePickerView:self selectOkAction: [dateFormatter stringFromDate: selectDate]];
        }
    }
}

#pragma mark - 取消按钮
-(void)cancelButtonClick:(UIButton*)sender{
    if([_delegate respondsToSelector: @selector(selectNOAction)]){
        [self.delegate selectNOAction];
    }
}
@end
