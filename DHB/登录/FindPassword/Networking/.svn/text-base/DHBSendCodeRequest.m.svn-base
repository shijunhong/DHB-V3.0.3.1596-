//
//  DHBFindPasswordRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSendCodeRequest.h"

@implementation DHBSendCodeRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"retrievePassword";
}

-(id)value{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys: self.accounts_mobile,@"accounts_mobile", @"noSkey", @"action", nil];
    return dic;
}
@end
