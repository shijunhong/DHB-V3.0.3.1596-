//
//  InvoiceModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "InvoiceModuleDTO.h"

@implementation InvoiceModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
     self.invoice_id = [[dict EncodeNumberFromDicWithKey:@"invoice_id"] integerValue];
     self.invoice_type = [dict EncodeStringFromDicWithKey:@"invoice_type"];
     self.invoice_title = [dict EncodeStringFromDicWithKey:@"invoice_title"];
     self.invoice_tax = [[dict EncodeNumberFromDicWithKey:@"invoice_tax"] integerValue];
     self.invoice_content = [dict EncodeStringFromDicWithKey:@"invoice_content"];
     self.bank = [dict EncodeStringFromDicWithKey:@"bank"];
     self.bank_account = [dict EncodeStringFromDicWithKey:@"bank_account"];
     self.taxpayer_number = [dict EncodeStringFromDicWithKey:@"taxpayer_number"];
}

@end
