//
//  DHBFindPasswordService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBSendCodeRequest.h"
#import "DHBValidateCodeRequest.h"
#import "DHBSettingNewPasswordRequest.h"

@protocol DHBFindPasswordService_Delegate <NSObject>
@optional
- (void)DHBFindPasswordService_SendCodeCompelete: service isSuccess:(BOOL )isSuccess;
- (void)DHBFindPasswordService_ValidateCodeCompelete: service isSuccess:(BOOL )isSuccess;
- (void)DHBFindPasswordService_SettingNewPasswordCompelete: service isSuccess:(BOOL )isSuccess;
@end

@interface DHBFindPasswordService : NSObject
@property(nonatomic, retain) NSString *memberPhone;
@property(nonatomic, retain) NSString *memberPassword;
@property(nonatomic, retain) NSString *smsCode;
@property(nonatomic, retain) NSString *tipMessage;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign) id<DHBFindPasswordService_Delegate> delegate;

- (void)sendSMSCode;
- (void)verificationSMSCode;
- (void)settingNewPassword;
@end
