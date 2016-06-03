//
//  UIColor+DHBColor.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/20.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DHBColor)

/*
  白色 背景色
 */
+ (UIColor *)UIViewBackGroundColor;

/*
 导航栏背景色   #f74c00
 */
+ (UIColor *)NavBack_Red_Color;

///*
// TableView背景色   #dcdcdc
// */
//+ (UIColor *)TableViewBack_Color;

/*
 Cell线颜色   #dcdcdc
 */
+ (UIColor *)CellLine_Color;

/*
 按钮红色背景  #fe4600
 */
+(UIColor *)BtnRedBackground_Color;

/*
 按钮触摸时的红色背景  #ee4400
 */
+(UIColor *)BtnTouchRedBackground_Color;

/*
 按钮边色   #888888
 */
+(UIColor *)BtnBorder_Color;

/*
 按钮点击后边色   #fe4600
 */
+(UIColor *)BtnSelectBorder_Color;

/*
 按钮点击后边色   #333333
 */
+(UIColor *)BtnText_BlackColor;

/*
 字体颜色   #333333
 */
+(UIColor *)TextBlack_Color;

/*
 字体颜色   #fe4600
 */
+(UIColor *)TextRed_Color;
/*
 字体颜色   #757575
 */
+(UIColor *)TextGray_Color;

/*
 文本边框颜色  #eeeeee
 */
+(UIColor *)InputBorder_Color;

/*
 金额颜色  #ff0000
 */
+(UIColor *)Money_Color;
@end
