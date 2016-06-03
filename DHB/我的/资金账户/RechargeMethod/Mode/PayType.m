//
//  PayType.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/18.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "PayType.h"

@implementation PayType

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.paytype = [dict EncodeStringFromDicWithKey:@"paytype"];
    self.paytype_value = [dict EncodeStringFromDicWithKey:@"paytype_value"];
    self.is_recom = [dict EncodeStringFromDicWithKey:@"is_recom"];
    self.is_manager = [dict EncodeStringFromDicWithKey:@"is_manager"];
    self.is_client = [dict EncodeStringFromDicWithKey:@"is_client"];
    self.money = [dict EncodeStringFromDicWithKey:@"money"];
    
    if ([self.paytype_value isEqualToString:@"Quick"]) {self.type = Quick;}
    else if ([self.paytype_value isEqualToString:@"Alipay"]){self.type = Alipay;}
    else if ([self.paytype_value isEqualToString:@"Micro"]){self.type = Micro;}
    else if ([self.paytype_value isEqualToString:@"Offline"]){self.type = Offline;}
    else if ([self.paytype_value isEqualToString:@"Deposit"]){self.type = Deposit;}
}

@end
