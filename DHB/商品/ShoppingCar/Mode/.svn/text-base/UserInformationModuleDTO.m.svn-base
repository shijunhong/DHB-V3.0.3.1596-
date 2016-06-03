//
//  UserInformationModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "UserInformationModuleDTO.h"

@implementation UserInformationModuleDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.purchasers =[[PurchasersModuleDTO alloc] init];
    [self.purchasers parseFromDict:[dict EncodeDicFromDicWithKey:@"client"]];
    
    self.venders = [[VendersModuleDTO alloc] init];
    [self.venders parseFromDict:[dict EncodeDicFromDicWithKey:@"common_set"]];

    self.total_price = [dict EncodeStringFromDicWithKey:@"total_price"];
}

@end


@implementation PurchasersModuleDTO : NSObject
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.invoice_title =[dict EncodeStringFromDicWithKey:@"invoice_title"];
    self.bank_account =[dict EncodeStringFromDicWithKey:@"bank_account"];
    self.bank =[dict EncodeStringFromDicWithKey:@"bank"];
    self.taxpayer_number =[dict EncodeStringFromDicWithKey:@"taxpayer_number"];
    self.account_name =[dict EncodeStringFromDicWithKey:@"account_name"];
    self.invoice_content = @"商品明细";
    NSArray *arr = [dict EncodeArrayFromDicWithKey:@"address"];
    for (NSDictionary *dic in arr)
    {
        AddressModuleDTO *address = [[AddressModuleDTO alloc] init];
        [address parseFromDict:dic];
        if ([address.is_default isEqualToString:@"T"])
        {
            self.address = address;
        }
    }
}
@end


@implementation VendersModuleDTO : NSObject
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.pt_invoice =[dict EncodeStringFromDicWithKey:@"pt_invoice"];
    self.pt_taxing_point =[dict EncodeStringFromDicWithKey:@"plain_invoice_point"];
    self.zz_invoice =[dict EncodeStringFromDicWithKey:@"zz_invoice"];
    self.zz_taxing_point =[dict EncodeStringFromDicWithKey:@"added_tax_invoice_point"];
    self.invoice_type = BK;
}
@end



@implementation AddressModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.address_id =[[dict EncodeNumberFromDicWithKey:@"address_id"] integerValue];
    self.consignee =[dict EncodeStringFromDicWithKey:@"consignee"];
    self.contact =[dict EncodeStringFromDicWithKey:@"contact"];
    self.phone =[dict EncodeStringFromDicWithKey:@"phone"];
    self.address =[dict EncodeStringFromDicWithKey:@"address"];
    self.address_detail =[dict EncodeStringFromDicWithKey:@"address_detail"];
    self.is_default =[dict EncodeStringFromDicWithKey:@"is_default"];
    if ([self.is_default isEqualToString:@"T"])
    {
        self.is_select = YES;
    }
}
@end