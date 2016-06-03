//
//  DHBSettingPasswordViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSettingPasswordViewController.h"

@implementation DHBSettingPasswordViewController
#pragma mark - init
- (DHBTipView *)tipView{
    if(!_tipView){
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (DHBFindPasswordService *)mainService{
    if(!_mainService){
        _mainService = [[DHBFindPasswordService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (DHBSettingPasswordView *)mainView{
    if(!_mainView){
        _mainView = [[DHBSettingPasswordView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_mainView setDelegate: self];
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle: @"设置新密码"];
    [self.view addSubview: self.mainView];
}

- (void)settingPasswordView_DidSubmitButton:(UIButton *)button{
    if([[[self.mainView passwordTextField] text] length] <= 0){
        [self.tipView showInSuperView: self.view message:  @"请输入6-16位密码"];
        return;
    }
    else if(![[[self.mainView passwordTextField] text] isEqualToString: [[self.mainView confirmPasswordTextField] text]]){
        [self.tipView showInSuperView: self.view message: @"2次密码输入不一致!"];
        return;
    }
    [self.mainService setMemberPassword: [[self.mainView passwordTextField] text]];
    [self.mainService settingNewPassword];
}

#pragma mark - DHBFindPasswordService_Delegate
- (void)DHBFindPasswordService_SettingNewPasswordCompelete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.tipView showInSuperView: self.view message: @"修改成功!"];
        [self dismissViewControllerAnimated: YES completion: nil];
    }
    else{
        [self.tipView showInSuperView: self.view message: [self.mainService tipMessage]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
