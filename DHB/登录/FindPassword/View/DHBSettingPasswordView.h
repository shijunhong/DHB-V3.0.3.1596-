//
//  DHBSettingPasswordView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DHBSettingPasswordView_Delegate <NSObject>
- (void)settingPasswordView_DidSubmitButton:(UIButton *) button;
@end

@interface DHBSettingPasswordView : UIView<DHBTextField_Delegate>
{
    id firstResposer;
}
@property(nonatomic, assign) id<DHBSettingPasswordView_Delegate> delegate;
@property(nonatomic, retain) UIView *passwordMainView;
@property(nonatomic, retain) UIView *confirmPasswordMainView;
@property(nonatomic, retain) UIButton *sendCodeButton;
@property(nonatomic, retain) UIButton *submitButton;
@property(nonatomic, retain) DHBTextField *passwordTextField;
@property(nonatomic, retain) DHBTextField *confirmPasswordTextField;
@end
