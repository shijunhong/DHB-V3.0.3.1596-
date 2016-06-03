//
//  DHBOfflineSubmitRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/20.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOfflineSubmitRequest.h"

@implementation DHBOfflineSubmitRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"offlineSubmit";
}

-(id)value{
    return @{@"bank_id":self.bank_id,
             @"orders_num":self.orders_num,
             @"remark":self.remark?self.remark:@"",
             @"amount":self.amount,
             @"receipts_date":self.receipts_date};
}

- (BOOL)submitValidate{
    if([self.bank_id length] <= 0){
        [self showMessage: @"请选择收款账户"];
        return NO;
    }
    return YES;
}
@end
