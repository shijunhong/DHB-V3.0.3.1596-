//
//  DHBOrderSubmitRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/11.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderSubmitRequest.h"

@implementation DHBOrderSubmitRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"orderSubmit";
}

-(id)value{
    NSString *invoice_type;
    switch (self.userInformation.venders.invoice_type)
    {
        case BK:
            invoice_type = @"F";
            break;
        case PT:
            invoice_type = @"P";
            break;
        case ZZ:
            invoice_type = @"Z";
            break;
        default:
            invoice_type = @"F";
            break;
    }
    AddressModuleDTO *addressDTO = self.userInformation.purchasers.address;
    return @{@"invoice_type":(invoice_type ? invoice_type : @""),
             @"delivery_date":(self.userInformation.delivery_date ? self.userInformation.delivery_date : @""),
             @"distrib_mode":self.userInformation.distrib_mode ? self.userInformation.distrib_mode : @"",
             @"consignee":addressDTO.consignee ? addressDTO.consignee : @"",
             @"consignee_contact": addressDTO.contact ? addressDTO.contact : @"",
             @"consignee_phone": addressDTO.phone ? addressDTO.phone : @"",
             @"consignee_address": addressDTO.address ? addressDTO.address : @"",
             @"invoice_title": self.userInformation.purchasers.invoice_title ? self.userInformation.purchasers.invoice_title : @"",
             @"invoice_content":self.userInformation.purchasers.invoice_content ? self.userInformation.purchasers.invoice_content : @"",
             @"bank":self.userInformation.purchasers.bank ?self.userInformation.purchasers.bank  : @"",
             @"bank_account":self.userInformation.purchasers.bank_account ? self.userInformation.purchasers.bank_account : @"",
             @"account_name":self.userInformation.purchasers.account_name ? self.userInformation.purchasers.account_name : @"",
             @"taxpayer_number":self.userInformation.purchasers.taxpayer_number ? self.userInformation.purchasers.taxpayer_number: @"",
             @"remark": (self.userInformation.remark ? self.userInformation.remark : @"")};
}

-(BOOL)submitValidate{
    BOOL isValidate = YES;
    NSString *message = @"";
    if([[ParameterPublic sharedManagered] delivery_date]&&[[ParameterPublic sharedManagered] delivery_date_option])
    {
        if (!self.userInformation.delivery_date)
        {
            message = L(@"请选择交货日期");
            isValidate = NO;
        }
        else{
            ///判断日期的格式
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat: @"yyyy-MM-dd"];
            NSDate *selectedDate = [formater dateFromString: self.userInformation.delivery_date];
            if(!selectedDate){
                message = L(@"请选择交货日期");
                isValidate = NO;
            }
        }
    }
    if(!self.userInformation.purchasers.address)
    {
        message = L(@"请选择收货信息");
        isValidate = NO;
    }
    if(!isValidate){
        [self showMessage: message];
    }
    return isValidate;
}

@end
