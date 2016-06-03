//
//  OptionModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/12.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OptionModuleDTO.h"

@implementation OptionModuleDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.price_id = [[dict EncodeNumberFromDicWithKey:@"price_id"] integerValue];
    self.options_id = [dict EncodeStringFromDicWithKey:@"options_id"];
    self.selling_price = [dict EncodeStringFromDicWithKey:@"selling_price"];
    self.whole_price = [dict EncodeStringFromDicWithKey:@"whole_price"];
    self.picture = [dict EncodeStringFromDicWithKey:@"picture"];
    self.number_price = [dict EncodeArrayFromDicWithKey:@"number_price"]?[dict EncodeArrayFromDicWithKey:@"number_price"]:@[];
    self.available_number = [dict EncodeStringFromDicWithKey:@"available_number"];
    self.number = [dict EncodeStringFromDicWithKey:@"number"];
    self.units = [dict EncodeStringFromDicWithKey:@"units"];
}


@end
