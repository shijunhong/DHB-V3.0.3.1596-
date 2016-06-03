//
//  DHBButton.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/7.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBButton.h"

@implementation DHBButton
/////////////////////////////////////////////////////////////////
/*************************Begin：初始化**************************/
#pragma mark -
#pragma mark 基本参数初始化
- (void)defaultValue{
    self.cornerRadius = 2.5f;
    self.borderWidth = 0.5f;
    self.fontSize = 18.0f;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultValue];
    }
    return self;
}

- (id)initStyle:(DHBButton_Style)style
{
    self =  [super init];
    if (self) {
        [self defaultValue];
        [self setButtonStyle: style];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValue];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(DHBButton_Style) style
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValue];
        [self setButtonStyle: style];
    }
    return self;
}
/*************************End：初始化**************************/

//////////////////////////////////////////////////////////////
/*********************Begin：设置按钮属性*********************/
#pragma mark 根据不同样式设置按钮属性
- (void)setButtonStyle:(DHBButton_Style)buttonStyle{
    _buttonStyle = buttonStyle;
    ///通用样式
    [self.layer setMasksToBounds: YES];
    [self.titleLabel setFont: [UIFont systemFontOfSize: self.fontSize]];
    
    ///根据枚举类型调整按钮样式
    switch (buttonStyle) {
        case 0:{
            /////kDHBButton_StyleValue1
            //UIControlStateNormal
            [self setBackgroundImage: [self imageWithColor: [UIColor BtnRedBackground_Color]] forState: UIControlStateNormal];
            [self setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            //UIControlStateHighlighted
            [self setBackgroundImage: [self imageWithColor: [UIColor BtnTouchRedBackground_Color]] forState: UIControlStateHighlighted];
            [self setTitleColor: HEX_RGB(0xeddddd) forState: UIControlStateHighlighted];
            //UIControlStateDisabled
            [self setBackgroundImage: [self imageWithColor: HEX_RGB(0xc3c3c3)] forState: UIControlStateDisabled];
            break;
        }
        case 1:{
            //////kDHBButton_StyleValue2
            [self setBackgroundColor: [UIColor clearColor]];
            [self.layer setCornerRadius: self.cornerRadius];
            //UIControlStateNormal
            [self setTitleColor: [UIColor BtnText_BlackColor] forState: UIControlStateNormal];
            [self.layer setBorderWidth: self.borderWidth];
            [self.layer setBorderColor: [UIColor BtnBorder_Color].CGColor];
            //UIControlStateHighlighted
            [self setTitleColor: [UIColor TextRed_Color] forState: UIControlStateHighlighted];
            //UIControlStateSelected
            [self setTitleColor: [UIColor TextRed_Color] forState: UIControlStateSelected];
            //action
//            [self addTarget: self action: @selector(buttonHighlighted:) forControlEvents: UIControlEventTouchDown];
//            [self addTarget: self action: @selector(buttonTouchUpInside:) forControlEvents: UIControlEventTouchUpInside];
            break;
        }
        case 2:{
            //////kDHBButton_StyleValue3
            [self.layer setMasksToBounds: YES];
            [self.layer setCornerRadius: self.cornerRadius];
            [self.layer setBorderWidth: self.borderWidth];
            [self.layer setBorderColor: [UIColor BtnSelectBorder_Color].CGColor];
            //UIControlStateNormal
            [self setBackgroundImage: [self imageWithColor: [UIColor BtnRedBackground_Color]] forState: UIControlStateNormal];
            [self setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            //UIControlStateHighlighted
//            [self setBackgroundImage: [self imageWithColor: [UIColor clearColor]] forState: UIControlStateHighlighted];
//            [self setTitleColor: [UIColor TextRed_Color] forState: UIControlStateHighlighted];
            [self setBackgroundImage: [self imageWithColor: [UIColor BtnTouchRedBackground_Color]] forState: UIControlStateHighlighted];
            [self setTitleColor: HEX_RGB(0xeddddd) forState: UIControlStateHighlighted];
            //UIControlStateDisabled
            [self setBackgroundImage: [self imageWithColor: HEX_RGB(0xc3c3c3)] forState: UIControlStateDisabled];
            break;
        }
        case 3:{
            //////kDHBButton_StyleValue4
            [self.layer setMasksToBounds: YES];
            [self.layer setCornerRadius: self.cornerRadius];
            [self.layer setBorderWidth: self.borderWidth];
            [self.layer setBorderColor: [UIColor BtnSelectBorder_Color].CGColor];
            //UIControlStateNormal
            [self setBackgroundImage: [self imageWithColor: [UIColor clearColor]] forState: UIControlStateNormal];
            [self setTitleColor: [UIColor TextRed_Color] forState: UIControlStateNormal];
            //UIControlStateDisabled
//            [self setBackgroundImage: [self imageWithColor: HEX_RGB(0xc3c3c3)] forState: UIControlStateDisabled];
            break;
        }
        case 4:{
            //////kDHBButton_StyleValue5
            [self.layer setMasksToBounds: YES];
            [self.layer setCornerRadius: self.cornerRadius];
            [self.layer setBorderWidth: self.borderWidth];
            [self.layer setBorderColor: [UIColor whiteColor].CGColor];
            //UIControlStateNormal
            [self setBackgroundColor: [UIColor clearColor]];
            [self setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            //UIControlStateDisabled
            [self setBackgroundImage: [self imageWithColor: HEX_RGB(0xc3c3c3)] forState: UIControlStateDisabled];
            break;
        }
        case 5:{
            [self setTitleColor: [UIColor TextRed_Color] forState: UIControlStateNormal];
            [self setBackgroundColor: [UIColor yellowColor]];
            [self setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
        }
        default: break;
    }
    
    ///
    [self setSelected: self.selected];
}
/*********************End：设置按钮属性*********************/


/////////////////////////////////////////////////////////
/********Begin:私有方法（private method）****************/
#pragma mark 颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)buttonHighlighted:(UIButton *) sender{
    switch (self.buttonStyle) {
        case 1:{
            //////kDHBButton_StyleValue2
            [self.layer setBorderColor: [UIColor BtnSelectBorder_Color].CGColor];
            break;
        }
        default: break;
    }
}

- (void)buttonTouchUpInside:(UIButton *) sender{
    switch (self.buttonStyle) {
        case 1:{
            //////kDHBButton_StyleValue2
            [self.layer setBorderColor: [UIColor BtnBorder_Color].CGColor];
            break;
        }
        default: break;
    }
}

#pragma mark 选中状态
- (void)setSelected:(BOOL)selected{
    [super setSelected: selected];
    switch (self.buttonStyle) {
        case 1:{
            //////kDHBButton_StyleValue2
            if(selected){
                [self.layer setBorderColor: [UIColor BtnSelectBorder_Color].CGColor];
                [self.layer setBorderWidth: 1.0f];
            }
            else{
                [self.layer setBorderColor: [UIColor BtnBorder_Color].CGColor];
                [self.layer setBorderWidth: self.borderWidth];
            }
            break;
        }
        default: break;
    }
}

#pragma mark 按钮是否可用的状态
- (void)setEnabled:(BOOL)enabled{
    [super setEnabled: enabled];
    if(enabled){
        [self setButtonStyle: self.buttonStyle];
    }
    else{
        switch (self.buttonStyle) {
            case kDHBButton_StyleValue2:{
                [self.layer setBorderColor: HEX_RGB(0xbbbbbb).CGColor];
                [self setTitleColor: HEX_RGB(0xbbbbbb) forState: UIControlStateNormal];
                break;
            }
            case kDHBButton_StyleValue3:{
                [self.layer setBorderColor: HEX_RGB(0xbbbbbb).CGColor];
                break;
            }
            case kDHBButton_StyleValue4:{
                [self.layer setBorderColor: HEX_RGB(0xbbbbbb).CGColor];
                [self setTitleColor: HEX_RGB(0xbbbbbb) forState: UIControlStateNormal];
                break;
            }
            default:
                break;
        }
    }
}
/**********End:私有方法（private method）****************/
@end
