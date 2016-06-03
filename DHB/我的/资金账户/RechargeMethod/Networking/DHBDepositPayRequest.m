//
//  DHBDepositPayRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDepositPayRequest.h"

@implementation DHBDepositPayRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"depositPay";
}

-(id)value{
    return @{@"orders_num":self.orders_num,
             @"amount":self.amount};
}

@end
