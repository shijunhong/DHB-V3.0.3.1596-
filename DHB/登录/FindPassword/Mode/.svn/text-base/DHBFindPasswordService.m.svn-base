//
//  DHBFindPasswordService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFindPasswordService.h"

@implementation DHBFindPasswordService

#pragma mark - 获取验证码
- (void)sendSMSCode{
    DHBSendCodeRequest *request = [[DHBSendCodeRequest alloc] init];
    request.accounts_mobile = self.memberPhone;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        NSLog_Red(@"code=%d ",[[dic objectForKey:@"code"] intValue]);
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        self.tipMessage = [dic objectForKey: @"message"];
        if(isSueccess){
            isSueccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_SendCodeCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_SendCodeCompelete: self isSuccess:isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_SendCodeCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_SendCodeCompelete: self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 验证验证码
- (void)verificationSMSCode{
    DHBValidateCodeRequest *request = [[DHBValidateCodeRequest alloc] init];
    request.accounts_mobile = self.memberPhone;
    request.verification_code = self.smsCode;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        self.tipMessage = [dic objectForKey: @"message"];
        if(isSueccess){
            isSueccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_ValidateCodeCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_ValidateCodeCompelete: self isSuccess:isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_ValidateCodeCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_ValidateCodeCompelete: self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 设置新密码
- (void)settingNewPassword{
    DHBSettingNewPasswordRequest *request = [[DHBSettingNewPasswordRequest alloc] init];
    request.accounts_mobile = self.memberPhone;
    request.accounts_pass = self.memberPassword;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        self.tipMessage = [dic objectForKey: @"message"];
        if(isSueccess){
            isSueccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_SettingNewPasswordCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_SettingNewPasswordCompelete: self isSuccess:isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBFindPasswordService_SettingNewPasswordCompelete:isSuccess:)]) {
                [_delegate DHBFindPasswordService_SettingNewPasswordCompelete: self isSuccess:NO];
            }
        });
    }];
}
@end
