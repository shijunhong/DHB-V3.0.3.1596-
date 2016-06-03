//
//  DHBFindPasswordViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFindPasswordViewController.h"
#import "DHBSettingPasswordViewController.h"

@implementation DHBFindPasswordViewController
#pragma mark - getters and setters
- (DHBTipView *)tipView{
    if(!_tipView){
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (DHBFindPasswordService *)mainSerVice{
    if(!_mainSerVice){
        _mainSerVice = [[DHBFindPasswordService alloc] init];
        [_mainSerVice setDelegate: self];
    }
    return _mainSerVice;
}

- (DHBSendCodeView *)mainView{
    if(!_mainView){
        _mainView = [[DHBSendCodeView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_mainView setDelegate: self];
    }
    return _mainView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self setTitle: @"找回密码"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.mainView];
}

#pragma mark - DHBSendCodeView_Delegate
- (void)sendCodeView_DidSendCodeButtonClick:(UIButton *)button{
    if([[[self.mainView phoneTextField] text] length] <= 0){
        [self.tipView showInSuperView: self.view message: @"请先输入您注册的手机号"];
        return;
    }
    NSMutableString *phone = [[NSMutableString alloc] initWithString: [[self.mainView phoneTextField] text]];
    [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, phone.length)];
    [self.mainSerVice setMemberPhone: phone];
    [self.mainSerVice sendSMSCode];
}

- (void)sendCodeView_DidValidateButton:(UIButton *)button{
    [self.mainView hiddenKeyBoard];
    if([[[self.mainView smsCodeTextField] text] length] <= 0){
        [self.tipView showInSuperView: self.view message: @"请先输入您收到的验证码"];
        return;
    }
    if([[self.mainSerVice memberPhone] length] <= 0){
        NSMutableString *phone = [[NSMutableString alloc] initWithString: [[self.mainView phoneTextField] text]];
        [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, phone.length)];
        [self.mainSerVice setMemberPhone: phone];
    }
    [self.mainSerVice setSmsCode: [[self.mainView smsCodeTextField] text]];
    [self.mainSerVice verificationSMSCode];
}

#pragma mark - DHBFindPasswordService_Delegate
- (void)DHBFindPasswordService_SendCodeCompelete: service isSuccess:(BOOL)isSuccess{
    self.mainSerVice = service;
    if(!isSuccess){
        if([self.mainSerVice.tipMessage length] > 0){
            [self.tipView showInSuperView: self.view message: self.mainSerVice.tipMessage];
        }
    }
    else{
        [self.mainView startTimer];
    }
}

- (void)DHBFindPasswordService_ValidateCodeCompelete:(id)service isSuccess:(BOOL)isSuccess{
    self.mainSerVice = service;
    [self.tipView showInSuperView: self.view message: self.mainSerVice.tipMessage];
    if(isSuccess){
        DHBSettingPasswordViewController *settingVC = [[DHBSettingPasswordViewController alloc] init];
        [settingVC.mainService setMemberPhone: self.mainSerVice.memberPhone];
        [self.navigationController pushViewController: settingVC animated: NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
