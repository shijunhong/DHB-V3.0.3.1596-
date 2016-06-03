//
//  选中 DHBReturnsGoodsModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/24/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnsGoodsModuleDTO.h"

@implementation DHBReturnsGoodsModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.orders_num = [dict EncodeStringFromDicWithKey: @"orders_num"];
    self.orders_list_id = [[dict EncodeNumberFromDicWithKey:@"orders_list_id"] integerValue];
    self.goods_id = [[dict EncodeNumberFromDicWithKey:@"goods_id"] integerValue];
    self.options_id = [dict EncodeStringFromDicWithKey:@"options_id"];
    self.returns_number = [[dict EncodeNumberFromDicWithKey:@"returns_number"] doubleValue];
    self.returns_price = [dict EncodeStringFromDicWithKey:@"returns_price"];
    self.goods = [[GoodsModuleDTO alloc] init];
    [self.goods parseFromDict_shoppingCar:[dict EncodeDicFromDicWithKey:@"goods"]];
}
@end
