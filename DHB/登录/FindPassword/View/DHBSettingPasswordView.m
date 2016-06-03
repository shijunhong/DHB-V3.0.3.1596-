//
//  DHBSettingPasswordView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define INPUTVIEW_HEIGHT 55.0F
#define MARGIN_LEFT 10.0F
#define MARGIN_TOP 10.0F
#define TITLE_WIDTH 70.0F
#import "DHBSettingPasswordView.h"

@implementation DHBSettingPasswordView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addPasswordInputView];
        [self addConfirmPasswordInputView];
        [self addSubmitButton];
        ///
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hiddenKeyBoard)];
        [self addGestureRecognizer: tap];
    }
    return self;
}

#pragma mark - 密码输入框
- (void)addPasswordInputView{
    if(!_passwordMainView){
        _passwordMainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, INPUTVIEW_HEIGHT)];
    }
    [self addSubview: _passwordMainView];
    ///标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, INPUTVIEW_HEIGHT)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [titleLabel setText: @"设置密码"];
    [_passwordMainView addSubview: titleLabel];
    //输入框
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    if(!_passwordTextField){
        _passwordTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, _passwordMainView.frame.size.width - origin_x -  MARGIN_LEFT, INPUTVIEW_HEIGHT - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_passwordTextField showCancelButton: NO];
        [_passwordTextField setDHB_Delegate: self];
        [_passwordTextField setPlaceholder: @"6-16位数字、字母"];
        [_passwordTextField setFont: [UIFont systemFontOfSize: 12.0f]];
        [_passwordTextField setTag: 0];
        [_passwordTextField setKeyboardType: UIKeyboardTypeNamePhonePad];
        [_passwordTextField setSecureTextEntry: YES];
    }
    [_passwordMainView addSubview: _passwordTextField];
}

#pragma mark - 确认输入框
- (void)addConfirmPasswordInputView{
    ///分割线
    CGFloat origin_y = _passwordMainView.frame.origin.y + INPUTVIEW_HEIGHT;
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xe7e7e7)];
    [self addSubview: lineView];
    if(!_confirmPasswordMainView){
        origin_y += lineView.frame.size.height;
        _confirmPasswordMainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.size.width, INPUTVIEW_HEIGHT)];
    }
    [self addSubview: _confirmPasswordMainView];
    ///标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, INPUTVIEW_HEIGHT)];
    [titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [titleLabel setText: @"密码确认"];
    [_confirmPasswordMainView addSubview: titleLabel];
    //输入框
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    if(!_confirmPasswordTextField){
        _confirmPasswordTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, _confirmPasswordMainView.frame.size.width - origin_x - MARGIN_LEFT, INPUTVIEW_HEIGHT - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_confirmPasswordTextField showCancelButton: NO];
        [_confirmPasswordTextField setSecureTextEntry: YES];
        [_confirmPasswordTextField setDHB_Delegate: self];
        [_confirmPasswordTextField setTag: 1];
        [_confirmPasswordTextField setFont: [UIFont systemFontOfSize: 12.0f]];
        [_confirmPasswordTextField setPlaceholder: @"请再次输入密码"];
        [_confirmPasswordTextField setKeyboardType: UIKeyboardTypeNamePhonePad];
    }
    [_confirmPasswordMainView addSubview: _confirmPasswordTextField];
    ///分割线
    origin_y = _confirmPasswordMainView.frame.origin.y + INPUTVIEW_HEIGHT;
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xe7e7e7)];
    [self addSubview: lineView];
}

#pragma mark - 确定按钮
- (void)addSubmitButton{
    CGFloat origin_y = _confirmPasswordMainView.frame.origin.y + INPUTVIEW_HEIGHT + 2 * MARGIN_LEFT;
    if(!_submitButton){
        _submitButton = [[UIButton alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, INPUTVIEW_HEIGHT - 10.0f)];
        [_submitButton setTitle: @"确定" forState: UIControlStateNormal];
        [_submitButton setBackgroundColor: HEX_RGB(0xc3c3c3)]; ///默认背景色
        [_submitButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_submitButton setEnabled: NO];
        [_submitButton.layer setCornerRadius: 2.5f];
        [_submitButton addTarget: self action: @selector(submitButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: _submitButton];
}

#pragma mark - DHBTextField_Delegate
-(void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    firstResposer = textField;
}

- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([[_passwordTextField text] length] > 0 && [[_confirmPasswordTextField text] length] > 0){
        [_submitButton setBackgroundColor: [UIColor TextRed_Color]];
        [_submitButton setEnabled: YES];
    }
    return YES;
}

#pragma mark - 隐藏键盘
- (void)hiddenKeyBoard{
    [firstResposer resignFirstResponder];
}

#pragma mark - 验证按钮点击事件
- (void)submitButtonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(settingPasswordView_DidSubmitButton:)]){
        [_delegate settingPasswordView_DidSubmitButton: sender];
    }
}
@end
