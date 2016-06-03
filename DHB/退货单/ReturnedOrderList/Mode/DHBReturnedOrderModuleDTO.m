//
//  DHBReturnedOrderModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedOrderModuleDTO.h"

@implementation DHBReturnedOrderModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.returns_id =[dict EncodeStringFromDicWithKey:@"returns_id"];
    self.returns_num =[dict EncodeStringFromDicWithKey:@"returns_num"];
    self.create_date = [dict EncodeStringFromDicWithKey:@"create_date"];
    self.discount_total =[dict EncodeStringFromDicWithKey:@"discount_total"];
    self.returns_details_count =[dict EncodeStringFromDicWithKey:@"returns_details_count"];
    self.status =[dict EncodeStringFromDicWithKey:@"status"];
}
@end
