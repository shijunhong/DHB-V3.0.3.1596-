//
//  DHBCorporateFinancialModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/8/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCorporateFinancialModuleDTO.h"

@implementation DHBCorporateFinancialModuleDTO
- (void)parseFromDic:(NSDictionary *) dic{
    if(IsNilOrNull(dic)){
        return;
    }
//    self.client_name = [dic objectForKey: @"phone"];
    self.account_name = [dic objectForKey: @"account_name"];
    self.bank = [dic objectForKey: @"bank"];
    self.bank_account = [dic objectForKey: @"bank_account"];
    self.taxpayer_number = [dic objectForKey: @"taxpayer_number"];
    self.invoice_title = [dic objectForKey: @"invoice_title"];
}
@end
