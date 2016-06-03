//
//  DHBSendCodeView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define INPUTVIEW_HEIGHT 55.0F
#define MARGIN_LEFT 10.0F
#define MARGIN_TOP 10.0F
#define TITLE_WIDTH 70.0F
#define SENDBUTTON_WIDTH 80.0f
#import "DHBSendCodeView.h"

@implementation DHBSendCodeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addPhoneInputView];
        [self addSMSCodeInputView];
        [self addValidateButton];
        ///
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hiddenKeyBoard)];
        [self addGestureRecognizer: tap];
    }
    return self;
}

#pragma mark - 手机号输入框
- (void)addPhoneInputView{
    if(!_phoneMainView){
        _phoneMainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, INPUTVIEW_HEIGHT)];
    }
    [self addSubview: _phoneMainView];
    ///标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, INPUTVIEW_HEIGHT)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [titleLabel setText: @"手机号码"];
    [_phoneMainView addSubview: titleLabel];
    //输入框
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    if(!_phoneTextField){
        _phoneTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, _phoneMainView.frame.size.width - origin_x - 2 * MARGIN_LEFT - SENDBUTTON_WIDTH, INPUTVIEW_HEIGHT - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_phoneTextField showCancelButton: NO];
        [_phoneTextField setDHB_Delegate: self];
        [_phoneTextField setKeyboardType: UIKeyboardTypeNumberPad];
        [_phoneTextField setPlaceholder: @"请输入手机号"];
        [_phoneTextField setFont: [UIFont systemFontOfSize: 12.0f]];
        [_phoneTextField setTag: 0];
    }
    [_phoneMainView addSubview: _phoneTextField];
    //发送验证码按钮
    origin_x = _phoneTextField.frame.size.width + _phoneTextField.frame.origin.x + MARGIN_LEFT;
    if(!_sendCodeButton){
        _sendCodeButton = [[UIButton alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, SENDBUTTON_WIDTH, INPUTVIEW_HEIGHT - 2 * MARGIN_TOP)];
        [_sendCodeButton setTitle: @"发送验证码" forState: UIControlStateNormal];
        [_sendCodeButton.titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_sendCodeButton setTag: 60];
        [_sendCodeButton.layer setCornerRadius: 2.5f];
        [_sendCodeButton setBackgroundColor: HEX_RGB(0xc3c3c3)];//默认背景
        [_sendCodeButton setEnabled: NO];
        [_sendCodeButton addTarget: self action: @selector(sendCodeButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [_phoneMainView addSubview: _sendCodeButton];
}

#pragma mark - 短信验证码
- (void)addSMSCodeInputView{
    ///分割线
    CGFloat origin_y = _phoneMainView.frame.origin.y + INPUTVIEW_HEIGHT;
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xe7e7e7)];
    [self addSubview: lineView];
    if(!_smsCodeMainView){
        origin_y += lineView.frame.size.height;
        _smsCodeMainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.size.width, INPUTVIEW_HEIGHT)];
    }
    [self addSubview: _smsCodeMainView];
    ///标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, INPUTVIEW_HEIGHT)];
    [titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [titleLabel setText: @"验证码"];
    [_smsCodeMainView addSubview: titleLabel];
    //输入框
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    if(!_smsCodeTextField){
        _smsCodeTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, _smsCodeMainView.frame.size.width - origin_x - MARGIN_LEFT, INPUTVIEW_HEIGHT - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_smsCodeTextField showCancelButton: NO];
        [_smsCodeTextField setDHB_Delegate: self];
        [_smsCodeTextField setTag: 1];
        [_smsCodeTextField setFont: [UIFont systemFontOfSize: 12.0f]];
        [_smsCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_smsCodeTextField setPlaceholder: @"请输入您收到的验证码"];
    }
    [_smsCodeMainView addSubview: _smsCodeTextField];
    ///分割线
    origin_y = _smsCodeMainView.frame.origin.y + INPUTVIEW_HEIGHT;
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xe7e7e7)];
    [self addSubview: lineView];
}

#pragma mark - 验证按钮
- (void)addValidateButton{
    CGFloat origin_y = _smsCodeMainView.frame.origin.y + INPUTVIEW_HEIGHT + 2 * MARGIN_LEFT;
    if(!_validateButton){
        _validateButton = [[UIButton alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, INPUTVIEW_HEIGHT - 10.0f)];
        [_validateButton setTitle: @"验证" forState: UIControlStateNormal];
        [_validateButton setBackgroundColor: HEX_RGB(0xc3c3c3)]; ///默认背景色
        [_validateButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_validateButton setEnabled: NO];
        [_validateButton.layer setCornerRadius: 2.5f];
        [_validateButton addTarget: self action: @selector(validateButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: _validateButton];
}

#pragma mark - DHBTextField_Delegate
-(void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    firstResposer = textField;
}

- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL isEnable = YES;
//    if([[_smsCodeTextField text] length] == 0 || [[_phoneTextField text] length] == 0){
//        ///当验证码或者账号输入框中内容为空时，验证按钮不可用
//        isEnable = NO;
//    }
    ////监听当前输入框的状态
    if([textField tag] == 0)
    {
        ///手机号码输入框
        if(![string isEqualToString: @""]){
            switch ([[textField text] length]) {
                case 3: case 8:{
                    [textField setText: [NSString stringWithFormat: @"%@ ", [textField text]]];
                    break;
                }
                case 13:{
                    if(![string isEqualToString: @""]){
                        return NO;
                    }
                }
                default:
                    break;
            }
        }
        if([[textField text] length] == 12 && ![string isEqualToString: @""]){
            [_sendCodeButton setEnabled: YES];
            [_sendCodeButton setBackgroundColor: [UIColor TextRed_Color]];
            ///当账号输入框满足要求通过时，再检验是否可以点击验证按钮
            isEnable = ([[_smsCodeTextField text] length] > 0 ? YES : NO);
        }
        else{
            [_sendCodeButton setEnabled: NO];
            [_sendCodeButton setBackgroundColor: HEX_RGB(0xc3c3c3)];
            isEnable = NO;
        }
    }
    else if([textField tag] == 1)
    {
        ///验证码输入框
        if(([string isEqualToString: @""] && [[textField text] length] == 1)){
            //当输入框内容长度为1，并且当前输入的删除按钮，则表示输入框内容为空
            isEnable = NO;
        }
        else{
            ///当验证码输入框满足要求通过时，再检验是否可以点击验证按钮
            isEnable = ([[_phoneTextField text] length] == 13 ? YES : NO);
        }
    }
    ///验证按钮是否可用
    if(isEnable){
        [_validateButton setBackgroundColor: [UIColor TextRed_Color]];
        [_validateButton setEnabled: YES];
    }
    else{
        [_validateButton setBackgroundColor: HEX_RGB(0xc3c3c3)];
        [_validateButton setEnabled: NO];
    }
    return YES;
}

#pragma mark - 隐藏键盘
- (void)hiddenKeyBoard{
    [firstResposer resignFirstResponder];
}

#pragma mark - 验证按钮点击事件
- (void)validateButtonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(sendCodeView_DidValidateButton:)]){
        [_delegate sendCodeView_DidValidateButton: sender];
    }
}

#pragma mark - 发送验证码
- (void)sendCodeButtonClick:(UIButton *) sender{
    [self hiddenKeyBoard];
    if([_delegate respondsToSelector: @selector(sendCodeView_DidSendCodeButtonClick:)]){
        [_delegate sendCodeView_DidSendCodeButtonClick: sender];
    }
}

#pragma mark 开启倒计时
- (void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0f target: self selector: @selector(updateSendCodeStatus) userInfo: nil repeats: YES];
    [_sendCodeButton setEnabled: NO];
    [_sendCodeButton setBackgroundColor: HEX_RGB(0xc3c3c3)];
    [_sendCodeButton setTitle: [NSString stringWithFormat: @"%lds", (long)[_sendCodeButton tag]] forState: UIControlStateNormal];
}

- (void)updateSendCodeStatus{
    if([_sendCodeButton tag] == 0){
        [_sendCodeButton setEnabled: YES];
        [timer setFireDate: [NSDate distantFuture]];
        [_sendCodeButton setTag: 60];
        [_sendCodeButton setBackgroundColor: [UIColor NavBack_Red_Color]];
        [_sendCodeButton setTitle: @"重新发送" forState: UIControlStateNormal];
    }
    else{
        [_sendCodeButton setTag: [_sendCodeButton tag] - 1];
        [_sendCodeButton setTitle: [NSString stringWithFormat: @"%lds", (long)[_sendCodeButton tag]] forState: UIControlStateNormal];
    }
}
@end
