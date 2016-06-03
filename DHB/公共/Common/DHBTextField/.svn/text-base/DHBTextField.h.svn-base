//
//  DHBTextField.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/5.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

typedef enum {
    kDHBTextField_DefaultStyle = 0, /// 默认样式
    kDHBTextField_MaxInputStyle = 1 ///输入框比较大的样式
    /*
     ......
     */
}DHBTextField_Style;

#import <UIKit/UIKit.h>
#import "DHBtextFieldObject.h"

@interface DHBTextField : UITextField<UITextFieldDelegate>
/////相关属性
@property(nonatomic, retain) DHBtextFieldObject *textObject;
@property(nonatomic, retain) UIView *paddingView; //输入框的左视图
@property (nonatomic, assign) id<DHBTextField_Delegate> DHB_Delegate;
@property (nonatomic, assign) DHBTextField_Style style; //文本框属性
@property (nonatomic, assign) CGFloat leftPadding;//光标距离输入框的距离
@property (nonatomic, assign) CGFloat cornerRadius;//圆角度数
@property (nonatomic, assign) CGFloat borderWidth; //边框宽度
@property (nonatomic, assign) CGFloat fontSize; //字体大小 

////初始化构造便利函数（工厂方法）
- (id)initWithFrame:(CGRect)frame style:(DHBTextField_Style) style;
+ (instancetype)roundRectTextField; //创建一个圆角的输入框
+ (instancetype)borderTextField; //创建一个带边框的输入框

////kDHBTextField_MaxInputStyle样式
@property(nonatomic, retain) UIButton *cancelButton;
- (void)showCancelButton:(BOOL) isShow;

@end
