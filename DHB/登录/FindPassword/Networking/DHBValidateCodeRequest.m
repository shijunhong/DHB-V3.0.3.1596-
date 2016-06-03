//
//  DHBValidateCodeRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBValidateCodeRequest.h"

@implementation DHBValidateCodeRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"verificationCode";
}

-(id)value{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys: self.accounts_mobile,@"accounts_mobile", self.verification_code, @"verification_code", @"noSkey", @"action", nil];
    return dic;
}
@end
