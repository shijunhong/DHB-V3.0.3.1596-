//
//  DHBSendCodeView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHBSendCodeView_Delegate <NSObject>
- (void)sendCodeView_DidValidateButton:(UIButton *) button;
- (void)sendCodeView_DidSendCodeButtonClick:(UIButton *) button;
@end

@interface DHBSendCodeView : UIView<DHBTextField_Delegate>
{
    id firstResposer;
    NSTimer *timer;
}
@property(nonatomic, assign) id<DHBSendCodeView_Delegate> delegate;
@property(nonatomic, retain) UIView *phoneMainView;
@property(nonatomic, retain) UIView *smsCodeMainView;
@property(nonatomic, retain) UIButton *sendCodeButton;
@property(nonatomic, retain) UIButton *validateButton;
@property(nonatomic, retain) DHBTextField *phoneTextField;
@property(nonatomic, retain) DHBTextField *smsCodeTextField;

- (void)hiddenKeyBoard;
- (void)startTimer;
@end
