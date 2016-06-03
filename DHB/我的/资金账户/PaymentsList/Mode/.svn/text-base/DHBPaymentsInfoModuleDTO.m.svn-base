//
//  DHBPaymentsInfoModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsInfoModuleDTO.h"

@implementation DHBPaymentsInfoModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.deposit_id = ([dict EncodeStringFromDicWithKey:@"deposit_id"] ? [dict EncodeStringFromDicWithKey:@"deposit_id"] : self.deposit_id);
    self.amount = ([dict EncodeStringFromDicWithKey:@"amount"] ? [dict EncodeStringFromDicWithKey:@"amount"] : self.amount);
    self.deposit_type = ([dict EncodeStringFromDicWithKey:@"incexp_id"] ? [dict EncodeStringFromDicWithKey:@"incexp_id"] : self.deposit_type);
    self.type_id = ([dict EncodeStringFromDicWithKey:@"type_id"] ? [dict EncodeStringFromDicWithKey:@"type_id"] : self.type_id);
    self.deposit_balance = ([dict EncodeStringFromDicWithKey:@"deposit_balance"] ? [dict EncodeStringFromDicWithKey:@"deposit_balance"] : self.deposit_balance);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *payTime = [formatter dateFromString: [dict EncodeStringFromDicWithKey:@"pay_time"]];
    if(payTime){
        [self setPay_time: payTime];
    }
    self.status = ([dict EncodeStringFromDicWithKey:@"status"] ? [dict EncodeStringFromDicWithKey:@"status"] : self.status);
    self.orders_num = ([dict EncodeStringFromDicWithKey:@"orders_num"] ? [dict EncodeStringFromDicWithKey:@"orders_num"] : self.orders_num);
    self.receipts_date = ([dict EncodeStringFromDicWithKey:@"receipts_date"] ? [dict EncodeStringFromDicWithKey:@"receipts_date"] : self.receipts_date);
    self.update_date = ([dict EncodeStringFromDicWithKey:@"update_date"] ? [dict EncodeStringFromDicWithKey:@"update_date"] : self.update_date);
    self.bank_name = ([dict EncodeStringFromDicWithKey:@"bank_name"] ? [dict EncodeStringFromDicWithKey:@"bank_name"] : self.bank_name);
    self.account_name = ([dict EncodeStringFromDicWithKey:@"account_name"] ? [dict EncodeStringFromDicWithKey:@"account_name"] : self.account_name);
    self.account_number = ([dict EncodeStringFromDicWithKey:@"account_number"] ? [dict EncodeStringFromDicWithKey:@"account_number"] : self.account_number);
    self.remark = ([dict EncodeStringFromDicWithKey:@"remark"] ? [dict EncodeStringFromDicWithKey:@"remark"] : self.remark);
    self.resource = ([dict EncodeStringFromDicWithKey: @"resource"] ? [dict EncodeStringFromDicWithKey: @"resource"] : self.resource);
}
#pragma mark - 深拷贝
- (id)copyWithZone:(NSZone *)zone{
    DHBPaymentsInfoModuleDTO *copyDTO = [[[self class] allocWithZone:zone] init];
    [copyDTO setDeposit_id: [_deposit_id copy]];
    [copyDTO setType_id: [_type_id copy]];
    [copyDTO setAmount: [_amount copy]];
    [copyDTO setDeposit_type: [_deposit_type copy]];
    [copyDTO setPay_time: [_pay_time copy]];
    [copyDTO setStatus: [_status copy]];
    [copyDTO setOrders_num: [_orders_num copy]];
    [copyDTO setReceipts_date: [_receipts_date copy]];
    [copyDTO setUpdate_date: [_update_date copy]];
    [copyDTO setBank_name: [_bank_name copy]];
    [copyDTO setAccount_name: [_account_name copy]];
    [copyDTO setAccount_number: [_account_number copy]];
    [copyDTO setRemark: [_remark copy]];
    [copyDTO setResource: [_resource copy]];
    return copyDTO;
}
@end
