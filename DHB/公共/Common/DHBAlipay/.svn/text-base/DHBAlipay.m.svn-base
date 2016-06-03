//
//  DHBAlipay.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAlipay.h"

@implementation DHBAlipay

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.partner = [dict EncodeStringFromDicWithKey:@"partner"];
    self.seller_id = [dict EncodeStringFromDicWithKey:@"seller_id"];
    self.out_trade_no = [dict EncodeStringFromDicWithKey:@"out_trade_no"];
    self.subject = [dict EncodeStringFromDicWithKey:@"subject"];
    self.body = [dict EncodeStringFromDicWithKey:@"body"];
    self.total_fee = [dict EncodeStringFromDicWithKey:@"total_fee"];
    self.notify_url = [dict EncodeStringFromDicWithKey:@"notify_url"];
    self.service = [dict EncodeStringFromDicWithKey:@"service"];
    self.payment_type = [dict EncodeStringFromDicWithKey:@"payment_type"];
    self.inputCharset = @"utf-8";
    
//    self.itBPay = @"30m";
//    self.showUrl = @"m.alipay.com";
}


- (NSString *)description{
    NSMutableString * discription = [NSMutableString string];
    if (self.inputCharset) {
        [discription appendFormat:@"_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.body) {
        [discription appendFormat:@"&body=\"%@\"", self.body];
    }
    if (self.notify_url) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notify_url];
    }
    if (self.out_trade_no) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.out_trade_no];
    }
    if (self.partner) {
        [discription appendFormat:@"&partner=\"%@\"", self.partner];
    }
    if (self.payment_type) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.payment_type];//1
    }
    if (self.seller_id) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller_id];
    }
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.subject) {
        [discription appendFormat:@"&subject=\"%@\"", self.subject];
    }
    if (self.total_fee) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.total_fee];
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//30m
    }
    if (self.showUrl) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
    }
    
    if (self.rsaDate) {
        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
    for (NSString * key in [self.extraParams allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
    }
    return discription;
}



@end
