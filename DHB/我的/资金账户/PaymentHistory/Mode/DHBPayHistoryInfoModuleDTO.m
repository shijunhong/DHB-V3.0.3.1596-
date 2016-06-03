//
//  DHBPayHistoryInfoModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayHistoryInfoModuleDTO.h"

@implementation DHBPayHistoryInfoModuleDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.receipts_id = [[dict EncodeNumberFromDicWithKey:@"receipts_id"] integerValue];
    self.amount = ([dict EncodeStringFromDicWithKey:@"amount"] ? [dict EncodeStringFromDicWithKey:@"amount"] : self.amount);
    self.incexp_id = ([dict EncodeStringFromDicWithKey:@"incexp_id"] ? [dict EncodeStringFromDicWithKey:@"incexp_id"] : self.incexp_id);
    self.type_id = ([dict EncodeStringFromDicWithKey:@"type_id"] ? [dict EncodeStringFromDicWithKey:@"type_id"] : self.type_id);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *payTime = [formatter dateFromString: [dict EncodeStringFromDicWithKey:@"create_date"]];
    if(payTime){
        [self setCreate_date: payTime];
    }
    self.status = ([dict EncodeStringFromDicWithKey:@"status"] ? [dict EncodeStringFromDicWithKey:@"status"] : self.status);
}



#pragma mark - 深拷贝
- (id)copyWithZone:(NSZone *)zone{
    DHBPayHistoryInfoModuleDTO *copyDTO = [[[self class] allocWithZone:zone] init];
    [copyDTO setReceipts_id:_receipts_id];
    [copyDTO setAmount: [_amount copy]];
    [copyDTO setIncexp_id: [_incexp_id copy]];
    [copyDTO setType_id: [_type_id copy]];
    [copyDTO setCreate_date: [_create_date copy]];
    [copyDTO setStatus: [_status copy]];
    return copyDTO;
}

@end
