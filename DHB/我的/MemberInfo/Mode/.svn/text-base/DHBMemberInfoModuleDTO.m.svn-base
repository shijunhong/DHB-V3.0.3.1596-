//
//  DHBMemberInfoModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMemberInfoModuleDTO.h"

@implementation DHBMemberInfoModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.memberAccount = [dict EncodeStringFromDicWithKey:@"contact"];
    self.memberMail = [dict EncodeStringFromDicWithKey:@"email"];
    self.memberQQ = [dict EncodeStringFromDicWithKey:@"qq"];
    self.memberName = [dict EncodeStringFromDicWithKey:@"contact"];
    self.memberPhone = [dict EncodeStringFromDicWithKey:@"phone"];
    self.memberBalance = [dict EncodeStringFromDicWithKey:@"blance"];
    self.isOpenQuicklyPay = [[dict EncodeStringFromDicWithKey:@"is_quick"] isEqualToString: @"T"] ? YES : NO;
}
@end
