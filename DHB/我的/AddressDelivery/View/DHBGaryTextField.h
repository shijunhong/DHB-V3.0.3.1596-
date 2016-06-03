//
//  DHBGaryTextField.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/5.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBGaryTextField : UITextField
//附加属性
@property (nonatomic, assign) CGFloat leftPadding;

- (CGRect)textRectForBounds:(CGRect)bounds;

- (CGRect)editingRectForBounds:(CGRect)bounds;

- (CGRect)placeholderRectForBounds:(CGRect)bounds;
@end
