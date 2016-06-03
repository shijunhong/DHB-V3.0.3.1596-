//
//  DHBInputTextField.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define ICON_MARGIN 13.0f
#define ICON_WIDTHANDHEIGHT 19.0f
#define TEXTFILED_MARGIN_LEFT 13.0f
#define FONT_SIZE 14.0f
#import "DHBInputView.h"
#import "DHBKeyboardManager.h"

@implementation DHBInputView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame InputType:(Login_Input_Type) type
{
    self = [super initWithFrame: frame];
    if(self){
        if(!inputType)
            inputType = type;
        [self.layer setCornerRadius: 2.5f];
        [self.layer setMasksToBounds: YES];
        self.layer.borderColor = [UIColor TextRed_Color].CGColor;
        self.layer.borderWidth = 0.5f;
//        [self setBackgroundColor: [[UIColor alloc] initWithWhite: 0.1f  alpha: 0.55f]];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addLeftIcon];
        [self addTextFiled];
        if(type == kAccount_Input_Type)
            [self addRightIcon];
    }
    return self;
}

#pragma mark 输入框左侧的图标
- (void)addLeftIcon
{
    if(!self.leftIconImageView){
        self.leftIconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(ICON_MARGIN, ICON_MARGIN, ICON_WIDTHANDHEIGHT, ICON_WIDTHANDHEIGHT)];
        [self setContentMode: UIViewContentModeScaleAspectFit];
        NSString *imageName = (inputType == kAccount_Input_Type ? @"login_user" : @"Password");
        [self.leftIconImageView setImage: [UIImage imageNamed:imageName]];
    }
    [self addSubview: self.leftIconImageView];
}

#pragma mark 输入框
- (void)addTextFiled
{
    CGFloat textFile_width = self.frame.size.width -(ICON_WIDTHANDHEIGHT + 2 * ICON_MARGIN) - self.frame.size.height;
    if(!self.mainTextFiled){
        self.mainTextFiled = [[UITextField alloc] initWithFrame: CGRectMake(ICON_MARGIN+ICON_WIDTHANDHEIGHT+TEXTFILED_MARGIN_LEFT, 0.0f, textFile_width, self.frame.size.height)];
        [self.mainTextFiled setFont: [UIFont systemFontOfSize: FONT_SIZE]];
        [self.mainTextFiled setTextColor: [UIColor TextBlack_Color]];
        [self.mainTextFiled setDelegate: self];
        [self.mainTextFiled setTintColor: HEX_RGB(0x999999)];
    }
    [self addSubview: self.mainTextFiled];
}

#pragma mark 输入框右侧图标
- (void)addRightIcon
{
    CGFloat origin_x = self.mainTextFiled.frame.size.width + self.mainTextFiled.origin.x;
    if(!self.rightIconImageView){
        self.rightIconImageView = [[UIButton alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.frame.size.height, self.frame.size.height)];
        [self.rightIconImageView setImage: [UIImage imageNamed: @"xia"] forState: UIControlStateNormal];
        [self.rightIconImageView setContentMode: UIViewContentModeScaleAspectFit];
        [self.rightIconImageView addTarget: self action: @selector(rightIconImageVIewClick) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: self.rightIconImageView];
}

#pragma mark TextFiled delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector: @selector(inputView_DidTextFieldBeginEdit:)]){
        [_delegate inputView_DidTextFieldBeginEdit: textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString: @""])
    {
        switch (inputType)
        {
            case kAccount_Input_Type://账号
                switch ([[textField text] length])
            {
                case 3: case 8: // 第3位和第8位数字后面加空格
                    [textField setText: [NSString stringWithFormat: @"%@ ", [textField text]]];
                    break;
                case 13: // 不超过13位
                    return NO;
                default:
                    break;
            }
                return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"] evaluateWithObject:string];//只能输入是0-9数字
                break;
            case kPassWord_Input_Type://密码 6-18位数字、字母
                if (range.location >= 18) return NO; //只能输入是18位以内
                return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[a-zA-Z0-9]"] evaluateWithObject:string];//只能输入 数字、字母
                break;
            default:
                break;
        }
    }
    
    return YES;
}

#pragma mark -
- (void)setText:(NSString *) string
{
    [self.mainTextFiled setText: string];
}

- (NSString *)text
{
    return [self.mainTextFiled text];
}

- (void)setPlaceholder:(NSString *) string
{
    [self.mainTextFiled setAttributedPlaceholder: [[NSAttributedString alloc] initWithString: string attributes: [NSDictionary dictionaryWithObject: HEX_RGB(0x999999) forKey: NSForegroundColorAttributeName]]];
}

- (void)textFiledBecomeFirstResponder
{
    [self.mainTextFiled becomeFirstResponder];
}

- (void)setKeyboardType:(UIKeyboardType) type
{
    [self.mainTextFiled setKeyboardType: type];
}

- (void)setSecureTextEntry:(BOOL) isEntry
{
    [self.mainTextFiled setSecureTextEntry: isEntry];
}

#pragma mark -
- (void)rightIconImageVIewClick
{
    if([_delegate respondsToSelector: @selector(inputView_DidSelectOnClick)]){
        [_delegate inputView_DidSelectOnClick];
    }
}

- (void)setHeightLight{
    NSString *imageName = (inputType == kAccount_Input_Type ? @"login_user2" : @"Password2");
    [self.leftIconImageView setImage: [UIImage imageNamed: imageName]];
}

- (void)setLowLight{
    NSString *imageName = (inputType == kAccount_Input_Type ? @"login_user" : @"Password");
    [self.leftIconImageView setImage: [UIImage imageNamed:imageName]];
}
@end
