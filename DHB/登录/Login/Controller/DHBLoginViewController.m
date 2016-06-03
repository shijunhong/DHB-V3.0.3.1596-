//
//  DHBLoginViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLoginViewController.h"

@implementation DHBLoginViewController
- (DHBTipView *)tipView{
    if(!_tipView){
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (DHBLoginMainView *)mainView{
    if(!_mainView){
        _mainView = [[DHBLoginMainView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        [_mainView setDelegate: self];
    }
    return _mainView;
}

- (DHBMemberService *)memberService{
    if(!_memberService){
        _memberService = [[DHBMemberService alloc] init];
        [_memberService setDelegate: self];
    }
    return _memberService;
}

- (NSArray*)recordArray{
    if(!_recordArray){
        _recordArray = [NSArray array];
    }
    return _recordArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
//    [self showKeyBoardTypeHidden: NO];
    ///默认进入登录页面查询登录过的记录
    [self.navigationController setNavigationBarHidden:YES];
    
    isDefaulAccount = NO;
    isViewLoad = NO;
    [self.memberService queryLoginRecordData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.mainView];
}

#pragma mark - DHBLoginMainView delegate
#pragma mark 免费体验按钮
- (void)loginMainView_DidFreeButton:(UIButton *)button
{
    ///保存测试账号的sKey
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: FREE_ACCOUNT_SKEY forKey: @"skey"];
    [userDefaults synchronize];
     //设置根视图
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[MainPageViewController alloc] init];
}

#pragma mark 注册
- (void)loginMainView_DidRegisterClick{
    DHBRegisterViewController *registerVC = [[DHBRegisterViewController alloc] init];
    registerVC.delegate = self;
//    [registerVC setPageType: kRegisterPage];
    [self presentViewController: registerVC animated: YES completion: nil];
}

#pragma mark 找回密码
- (void)loginMainView_DidFindPasswordClick{
    DHBCommonNavigationController *findPasswordNC = [[DHBCommonNavigationController alloc] init];
    [findPasswordNC setPageType: kFindPassowrdPage];
    [self presentViewController: findPasswordNC animated: YES completion: nil];
}

#pragma mark 点击选择登录历史的三角按钮
- (void)loginMainView_DidOpenRecordListButton
{
    [self.memberService queryLoginRecordData];
}

#pragma mark 点击删除登录记录
- (void)loginMainView_DidDeleteRecordButtonClick:(UIButton *)button
{
    if([self.recordArray count] > [button tag]){
        LoginRecordMouleDTO *record = [self.recordArray objectAtIndex: [button tag]];
        [self.memberService deleteLoginRecordData: [record phone]];
        [self.memberService updateLoginRecordData];
    }
}

#pragma mark 选择登录历史中的某个账号
- (void)loginMainView_DidSelectRecordAtIndex:(NSInteger)index
{
    if([self.recordArray count] > index){
        LoginRecordMouleDTO *record = [self.recordArray objectAtIndex: index];
        NSMutableString *phone = [[NSMutableString alloc]  initWithString: [record phone]];
        [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, phone.length)];
        if([phone length] > 3){
            [phone insertString: @" " atIndex: 3];
        }
        if([phone length] > 8){
            [phone insertString: @" " atIndex: 8];
        }
        [self.mainView.accountInputView setText: phone];
        [self.mainView dismissLoginRecordView];
        isShowRecord = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.mainView.accountInputView rightIconImageView].transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark 点击登陆按钮
- (void)loginMainView_DidLoginButtonClick:(UIButton *)button
{
    if(!([[self.mainView.accountInputView text] length] > 0)){
        [self.tipView showInSuperView: self.view message: @"请输入您的手机号"];
        return;
    }
    if(!([[self.mainView.passwordInputView text] length] > 0)){
        [self.tipView showInSuperView: self.view message: @"请输入您的密码"];
        return;
    }
    MemberInfoModuleDTO *memberDTO = [[MemberInfoModuleDTO alloc] init];
    NSMutableString *phone = [[NSMutableString alloc] initWithString: [self.mainView.accountInputView text]];
    [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, [phone length])];
    [memberDTO setAccount: phone];
    [memberDTO setPassword: [self.mainView.passwordInputView text]];
    [self.memberService setMemberDTO: memberDTO];
    [self.memberService login];
}

#pragma mark 公司链接
- (void)loginMainView_DidCompanyLinkClick{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: DHB_MOBILE_WEB]];
}

#pragma mark - memberService delegate
- (void)memberService_Complete:(DHBMemberService *)service isSuccess:(BOOL)isSuccess
{
    if(isSuccess){
        self.recordArray = service.loginRecordArray;
        if( [self.recordArray count] > 0){
            if(!isDefaulAccount){
                ////当没有默认账号的时候，添加默认账号
                LoginRecordMouleDTO *record = [self.recordArray firstObject];
                NSMutableString *phone = [[NSMutableString alloc]  initWithString: [record phone]];
                [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, phone.length)];
                if([phone length] > 3){
                    [phone insertString: @" " atIndex: 3];
                }
                if([phone length] > 8){
                    [phone insertString: @" " atIndex: 8];
                }
                [self.mainView.accountInputView setText: phone];
                isDefaulAccount = YES;
            }
            else{
                if(!isShowRecord){
                    [UIView animateWithDuration:0.3 animations:^{
                        [self.mainView.accountInputView rightIconImageView].transform = CGAffineTransformMakeRotation(3.15);
                    }];
                    [self.mainView showLoginRecordView: self.recordArray];
                }
                else{
                    [UIView animateWithDuration:0.3 animations:^{
                        [self.mainView.accountInputView rightIconImageView].transform = CGAffineTransformIdentity;
                    }];
                    [self.mainView dismissLoginRecordView];
                }
                isShowRecord = !isShowRecord;
            }
        }
        else{
            if(isViewLoad){
                [self.tipView showInSuperView: self.view message: @"暂无登录记录!"];
            }
        }
        isViewLoad = YES;
    }
}

- (void)memberService_Update:(DHBMemberService *)service isSuccess:(BOOL)isSuccess
{
    if(isSuccess){
        self.recordArray = service.loginRecordArray;
        [self.mainView showLoginRecordView: self.recordArray];
        if([self.recordArray count] == 0){
            isShowRecord = NO;
            [UIView animateWithDuration:0.3 animations:^{
                [self.mainView.accountInputView rightIconImageView].transform = CGAffineTransformIdentity;
            }];
        }
    }
}

- (void)memberService_LoginComplete:(DHBMemberService *)service isSuccess:(BOOL)isSuccess
{
    self.memberService = service;
    if(isSuccess){
        ///保存sKey
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject: service.skey forKey: @"skey"];
        [userDefaults synchronize];
        ///保存登录记录
        LoginRecordMouleDTO *record = [[LoginRecordMouleDTO alloc] init];
        record.phone = [self.mainView.accountInputView text];
        record.loginDate = [NSDate date];
        [self.memberService saveLoginRecordData:record];
        ////:登录成功先判断供应商的数量，如果只有一个供应商就直接登录，如果有多个就跳转到供应商选择列表
        if(service.isMoreSupplier){
            DHBSupplierListViewController *supplierVC = [[DHBSupplierListViewController alloc] init];
            [supplierVC.mainService setSkey: self.memberService.skey];
            [self presentViewController: supplierVC animated: YES completion: nil];
        }
        else{
            ////直接进入首页
            ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[MainPageViewController alloc] init];
        }
    }
    else{
        [self.tipView showInSuperView: self.view message: service.loginResultMessage];
    }
}

#pragma mark DHBRegisterViewControllerDelegate
-(void)RegisterUserId:(NSString *)userId{
    NSMutableString *phone = [[NSMutableString alloc] initWithString: userId];
    [phone replaceOccurrencesOfString: @" " withString: @"" options: NSLiteralSearch range: NSMakeRange(0, phone.length)];
    if([phone length] > 3){
        [phone insertString: @" " atIndex: 3];
    }
    if([phone length] > 8){
        [phone insertString: @" " atIndex: 8];
    }
    self.mainView.accountInputView.text = phone;
}

//#pragma mark - 供应商列表
//- (void)memberService_QuerySupplierComplete:(DHBMemberService *)servicer isSuccess:(BOOL)isSuccess{
//    if(isSuccess){
//        if([servicer.supplierArray count] > 1){
//           
//        }
//        else{
//            DHBSupplierModuleDTO *dto = [servicer.supplierArray firstObject];
//            if(dto){
//                
//            }
//            else{
//                [self.tipView showInSuperView: self.view message: @"账号不可用，没有对应的供应商!"];
//            }
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
