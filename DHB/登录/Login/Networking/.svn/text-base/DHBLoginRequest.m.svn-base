//
//  DHBLoginRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLoginRequest.h"

@implementation DHBLoginRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"getSkeyValue";
}

-(id)value{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys: self.account,@"accounts_name",self.password,@"accounts_pass", @"noSkey", @"action", nil];
    return dic;
}

/**
 *  对提交的数据进行验证
 *
 *  @return 验证通过返回YES,验证失败返回NO
 */
- (BOOL)submitValidate{
    if(!([self.account length] > 0)){
        [self showMessage: @"请输入您的手机号"];
        return NO;
    }
    else if(!([self.password length] <= 16 && [self.password length] >= 6)){
        [self showMessage: @"请输入6-16位密码"];
        return NO;
    }
    //判断密码输入的值是否符合要求
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"[^A-Za-z0-9]" options: NSRegularExpressionCaseInsensitive error: &error];
    NSInteger reslut = [regex numberOfMatchesInString: self.password options: 0 range: NSMakeRange(0, [self.password length])];
    if(reslut > 0){
        [self showMessage: @"输入不合法，请输入6-16位数字或字母"];
        return NO;
    }
    return YES;
}

@end
