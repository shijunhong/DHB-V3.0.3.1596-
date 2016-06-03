
//
//  DHBCustomerModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/5/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCustomerModuleDTO.h"

@implementation DHBCustomerModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.service_id = [dict EncodeStringFromDicWithKey: @"service_id"];
    self.name = [dict EncodeStringFromDicWithKey: @"service_name"];
    self.contactMethod = [dict EncodeStringFromDicWithKey: @"service_number"];
    self.type = [dict EncodeStringFromDicWithKey:@"service_type"];
}
@end
