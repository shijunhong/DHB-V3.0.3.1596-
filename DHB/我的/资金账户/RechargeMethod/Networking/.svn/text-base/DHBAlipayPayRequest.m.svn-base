//
//  DHBAlipayPayRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/9.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAlipayPayRequest.h"

@implementation DHBAlipayPayRequest

-(NSString *)controller{
    return @"AlipayApi";
}

-(NSString *)action{
    return @"alipayPay";
}

-(id)value{
    return @{@"orders_num":self.orders_num,
             @"amount":self.amount,
             @"remark":self.remark};
}

@end
