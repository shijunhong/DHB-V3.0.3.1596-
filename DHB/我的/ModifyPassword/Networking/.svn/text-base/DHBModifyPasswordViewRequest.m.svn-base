//
//  DHBModifyPasswordViewRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/29/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBModifyPasswordViewRequest.h"

@implementation DHBModifyPasswordViewRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"modifyPwd";
}

-(id)value{
    return @{@"old_pwd": (self.old_pwd ? self.old_pwd : @""),@"new_pwd": (self.n_pwd ? self.n_pwd : @""),@"new_pwd_repeat": (self.n_pwd_repeat ? self.n_pwd_repeat : @""),};
}

/**
 *  对提交的数据进行验证
 *
 *  @return 验证通过返回YES,验证失败返回NO
 */
- (BOOL)submitValidate{
    if([self.old_pwd length] <= 0){
        [self showMessage: @"请输入原密码"];
        return NO;
    }
    else if(!([self.n_pwd length] <= 16 && [self.n_pwd length] >= 6)){
        [self showMessage: @"请输入6-16位新密码"];
        return NO;
    }
    //判断密码输入的值是否符合要求
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"[^A-Za-z0-9]" options: NSRegularExpressionCaseInsensitive error: &error];
    NSInteger reslut = [regex numberOfMatchesInString: self.n_pwd options: 0 range: NSMakeRange(0, [self.n_pwd length])];
    if(reslut > 0){
        [self showMessage: @"输入不合法，请输入6-16位数字或字母"];
        return NO;
    }
    if(![self.n_pwd_repeat isEqualToString: self.n_pwd]){
        [self showMessage:  @"2次密码输入不一致，请仔细检查"];
        return NO;
    }
    return YES;
}
@end
