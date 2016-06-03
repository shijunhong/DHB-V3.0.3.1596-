//
//  DHBSettingNewPasswordRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSettingNewPasswordRequest.h"

@implementation DHBSettingNewPasswordRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"setNewPassword";
}

-(id)value{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys: self.accounts_mobile,@"accounts_mobile", self.accounts_pass, @"accounts_pass", @"noSkey", @"action", nil];
    return dic;
}

- (BOOL)submitValidate{
    BOOL isValidate = YES;
    if([self.accounts_mobile length] == 0){
        isValidate = NO;
        [self showMessage: @"手机号不能为空"];
    }
    else if(!([self.accounts_pass length] <= 16 && [self.accounts_pass length] >= 6)){
        isValidate = NO;
        [self showMessage: @"请输入6-16位密码"];
    }
    //判断密码输入的值是否符合要求
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"[^A-Za-z0-9]" options: NSRegularExpressionCaseInsensitive error: &error];
    NSInteger reslut = [regex numberOfMatchesInString: self.accounts_pass options: 0 range: NSMakeRange(0, [self.accounts_pass length])];
    if(reslut > 0){
        [self showMessage: @"输入不合法，请输入6-16位数字或字母"];
        isValidate = NO;
    }
    return isValidate;
}
@end
