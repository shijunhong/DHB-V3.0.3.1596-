//
//  DHBMemberInfoRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/15/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMemberInfoRequest.h"

@implementation DHBMemberInfoRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"myAccountSubmit";
}

-(id)value{
    return @{@"contact": (self.memberInfo.memberName ? self.memberInfo.memberName : @""),@"email": (self.memberInfo.memberMail ? self.memberInfo.memberMail : @""),@"phone": (self.memberInfo.memberPhone ? self.memberInfo.memberPhone : @""),};
}

- (BOOL)submitValidate{
    BOOL isValidate = YES;
    NSString *message = @"";
    if([[self.memberInfo memberName] length] <= 0){
        message = @"姓名不能为空";
        isValidate = NO;
    }
    if([[self.memberInfo memberMail] length] <= 0){
        message = @"邮箱不能为空";
        isValidate = NO;
    }
    if([[self.memberInfo memberPhone] length] <= 0){
        message = @"电话不能为空";
        isValidate = NO;
    }
    if(!isValidate){
        [self showMessage: message];
    }
    return isValidate;
}
@end
