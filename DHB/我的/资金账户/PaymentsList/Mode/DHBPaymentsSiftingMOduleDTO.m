//
//  DHBPaymentsSiftingMOduleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsSiftingMOduleDTO.h"

@implementation DHBPaymentsSiftingMOduleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.depositTypeArray = [NSMutableArray array];
    NSArray *tmpArray = [dict EncodeArrayFromDicWithKey:@"incexp_id"];
    for (NSDictionary *dic in tmpArray)
    {
        DHBDepositTypeModuleDTO *depositType = [[DHBDepositTypeModuleDTO alloc] init];
        [depositType parseFromDict:dic];
        [self.depositTypeArray addObject: depositType];
        
    }
    TT_RELEASE_SAFELY(tmpArray);
    self.payTypeArray = [NSMutableArray array];
    tmpArray = [dict EncodeArrayFromDicWithKey:@"type_id"];
    for (NSDictionary *dic in tmpArray)
    {
        DHBPayTypeModuleDTO *payType = [[DHBPayTypeModuleDTO alloc] init];
        [payType parseFromDict:dic];
        [self.payTypeArray addObject:payType];
    }
}
@end

@implementation DHBDepositTypeModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.name = [dict objectForKey: @"name"];
    self.value =[dict objectForKey: @"value"];
}
@end

@implementation DHBPayTypeModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.name = [dict objectForKey: @"name"];
    self.value = [dict objectForKey: @"value"];
}
@end
