//
//  DHBLoginMainView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define DHB_MOBILE_WEB @"http://shouji.dhb.hk/"
#import <UIKit/UIKit.h>
#import "DHBInputView.h"
#import "LoginRecordMouleDTO.h"

@protocol DHBLoginMainViewDelegate <NSObject>
- (void)loginMainView_DidOpenRecordListButton;
- (void)loginMainView_DidFreeButton:(UIButton *) button;
- (void)loginMainView_DidDeleteRecordButtonClick:(UIButton *)button;
- (void)loginMainView_DidLoginButtonClick:(UIButton *)button;
- (void)loginMainView_DidSelectRecordAtIndex:(NSInteger) index;
- (void)loginMainView_DidFindPasswordClick;
- (void)loginMainView_DidRegisterClick;
- (void)loginMainView_DidCompanyLinkClick;
@end

@interface DHBLoginMainView : UIView<DHBInputViewDelegate>
{
    id firstResponser;
    BOOL isEdit;
}
@property(nonatomic, assign) id<DHBLoginMainViewDelegate> delegate; ///背景图
@property(nonatomic, strong) UIImageView *mainBackgroundView; ///背景图
@property(nonatomic, strong) UIView *maskView; ///覆盖视图
@property(nonatomic, strong) UIView *loginRecordView; ///登录记录
@property(nonatomic, strong) UIImageView *logoImageView; ///顶部logo
@property(nonatomic, strong) UIView *operateView; ///操作区域
@property(nonatomic, strong) DHBInputView *accountInputView;  ///账号输入框
@property(nonatomic, strong) DHBInputView *passwordInputView; ///密码输入框
@property(nonatomic, strong) DHBButton *loginButton;  ///登录按钮
@property(nonatomic, strong) UILabel *registerLabel;  ///注册
@property(nonatomic, strong) UILabel *findPasswordLabel; ///找回密码
@property(nonatomic, strong) UIButton *freeButon;  ///免费体验
@property(nonatomic, strong) UIButton *companyButton;  ///公司名称

- (void)dismissLoginRecordView;
- (void)showLoginRecordView:(NSArray *) dataArray;
- (void)setLoginAccount:(NSString *)account;
@end
