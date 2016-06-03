//
//  DHBTextField.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/5.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTextField.h"

@implementation DHBTextField

/////////////////////////////////////////////////////////////////
/*************************Begin：初始化**************************/
#pragma mark -
#pragma mark 基本参数初始化
- (void)defaultValue{
    self.leftPadding = 8.0f;
    self.cornerRadius = 2.5f;
    self.borderWidth = 1.0f;
    self.fontSize = 14.0f;
    _style = kDHBTextField_DefaultStyle;
}

- (void)awakeFromNib{
    [self defaultValue];
    [self setUp];
    [self setStyle: kDHBTextField_MaxInputStyle];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultValue];
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValue];
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(DHBTextField_Style) style
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValue];
        [self setUp];
        [self setStyle: style];
    }
    return self;
}

- (DHBtextFieldObject *)textObject{
    if(!_textObject){
        _textObject = [[DHBtextFieldObject alloc] init];
    }
    return _textObject;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton = [[UIButton alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.height, self.frame.size.height)];
        [_cancelButton setImage: [UIImage imageNamed: @"x_normal"] forState: UIControlStateNormal];
        [_cancelButton setImage: [UIImage imageNamed: @"x_focused"] forState: UIControlStateSelected];
        [_cancelButton addTarget: self action: @selector(rightViewDidClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return nil;
}

- (UIView *)paddingView{
    if(!_paddingView){
        _paddingView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.leftPadding, self.size.height)];
    }
    return _paddingView;
}

- (void)setDHB_Delegate:(id<DHBTextField_Delegate>)DHB_Delegate{
    [self.textObject setDelegate: DHB_Delegate];
}
/*************************End：初始化**************************/

//////////////////////////////////////////////////////////////
/*********************Begin：设置文本框属性*********************/
#pragma mark -
#pragma mark 通用属性设置
- (void)setUp
{
    [self setBackgroundColor: [UIColor clearColor]];
    [self setTextColor: [UIColor TextGray_Color]];
    [self setFont: [UIFont systemFontOfSize: self.fontSize]];
    [self setContentVerticalAlignment: UIControlContentVerticalAlignmentCenter];
    [self setLeftViewMode: UITextFieldViewModeAlways];
    [self setLeftView: self.paddingView];
    [self setTintColor: [UIColor TextRed_Color]];
}

#pragma mark 设置输入框样式
- (void)setStyle:(DHBTextField_Style)style{
    switch (style) {
        case 1:{
            //////kDHBTextField_MaxInputStyle
//            [self setDelegate: self];
            [self setDelegate:self.textObject];
            //leftView
            [self.layer setCornerRadius: self.cornerRadius];
            [self.layer setBorderColor: [UIColor InputBorder_Color].CGColor];
            [self.layer setBorderWidth: self.borderWidth];
            [self setReturnKeyType: UIReturnKeyDone];
            [self setTextColor: [UIColor TextGray_Color]];
            //rightView
            [self setRightViewMode: UITextFieldViewModeAlways];
            [self setRightView: self.cancelButton];
            break;
        }
        default:{
            /////kDHBTextField_DefaultStyle
            [self setClearButtonMode: UITextFieldViewModeWhileEditing];
            [self setAutocapitalizationType: UITextAutocapitalizationTypeNone];
            [self setAutocorrectionType: UITextAutocorrectionTypeNo];
            [self setSpellCheckingType: UITextSpellCheckingTypeDefault];
            break;
        }
    }
}
//- (CGRect)textRectForBounds:(CGRect)bounds
//{
//    if (bounds.size.width > self.leftPadding) {
//        return CGRectInset(bounds, 5, 0);
//    }else{
//        return bounds;
//    }
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    if (bounds.size.width > self.leftPadding) {
//        return  CGRectInset(bounds, 5, 0);
//    }else{
//        return bounds;
//    }
//}
/*********************End：设置文本框属性*********************/

////////////////////////////////////////////////////////////
/************Begin：初始化构造便利函数（工厂方法）**************/
#pragma mark -
#pragma mark 构造方法
+ (instancetype)roundRectTextField
{
    DHBTextField *textField = [[DHBTextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    return textField;
}

+ (instancetype)borderTextField
{
    DHBTextField *textField = [[DHBTextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderColor = HEX_RGB(0x999999).CGColor;
    textField.layer.borderWidth = 0.5;
    return textField;
}
/************End：初始化构造便利函数（工厂方法）**************/

/////////////////////////////////////////////////////////
/********Begin:私有方法（private method）****************/
#pragma mark -  输入框右视图点击事件
- (void)rightViewDidClick:(UIButton *)sender{
    [self setText: @""];
}
/**********End:私有方法（private method）****************/


/////////////////////////////////////////////////////////
/************Begin:公用方法（public method）**************/
#pragma mark - 是否显示删除按钮
- (void)showCancelButton:(BOOL) isShow{
    [self.cancelButton setHidden: !isShow];
    [self setRightView: nil];
}
/************End:公用方法（public method）**************/
@end
