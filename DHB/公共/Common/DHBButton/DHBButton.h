//
//  DHBButton.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/7.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//
typedef enum {
    kDHBButton_StyleValue1 = 0, ///(默认)红色背景，白色字体, 不带圆角；(点击)红色背景加深
    kDHBButton_StyleValue2 = 1, ///(默认)透明背景，灰色字体，圆角带灰色边框；(点击)红色字体，红色边框
    kDHBButton_StyleValue3 = 2, ///(默认)红色背景，白色字体, 带圆角；(点击)透明背景，红色字体，红色边框
    kDHBButton_StyleValue4 = 3, ///(默认)透明背景，红色字体，红色边框, 带圆角；(点击)暂无
    kDHBButton_StyleValue5 = 4, ///(默认)透明背景，白色字体，白色边框, 带圆角；(点击)暂无
    kDHBButton_StyleValue6 = 5, ///(默认)单位按钮,带背景图
    /*
     ......
     */
}DHBButton_Style;
#import <UIKit/UIKit.h>

@interface DHBButton : UIButton
@property (nonatomic, assign)  DHBButton_Style buttonStyle; //按钮样式
@property (nonatomic)   CGFloat borderWidth;
@property (nonatomic)   CGFloat cornerRadius;
//@property (nonatomic, assign) IBInspectable int style; //按钮样式
@property (nonatomic, assign) CGFloat fontSize; //字体大小
- (id)initStyle:(DHBButton_Style)style;
- (id)initWithFrame:(CGRect)frame style:(DHBButton_Style) style;
@end
