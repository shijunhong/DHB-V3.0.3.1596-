//
//  DHBInputTextField.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

typedef enum {
    kAccount_Input_Type,
    kPassWord_Input_Type
}Login_Input_Type;

@protocol DHBInputViewDelegate <NSObject>
-(void)inputView_DidTextFieldBeginEdit:(UITextField *) textField;
-(void)inputView_DidSelectOnClick;
@end

#import <UIKit/UIKit.h>
@interface DHBInputView : UIView<UITextFieldDelegate>
{
    Login_Input_Type inputType;
}
@property(nonatomic, assign) id<DHBInputViewDelegate> delegate;
@property(nonatomic, strong) UIImageView *leftIconImageView;
@property(nonatomic, strong) UITextField *mainTextFiled;
@property(nonatomic, strong) UIButton *rightIconImageView;


- (id)initWithFrame:(CGRect)frame InputType:(Login_Input_Type) type;
- (NSString *)text;
- (void)setPlaceholder:(NSString *) string;
- (void)textFiledBecomeFirstResponder;
- (void)setKeyboardType:(UIKeyboardType) type;
- (void)setText:(NSString *) string;
- (void)setSecureTextEntry:(BOOL) isEntry;
- (void)setHeightLight;
- (void)setLowLight;
@end
