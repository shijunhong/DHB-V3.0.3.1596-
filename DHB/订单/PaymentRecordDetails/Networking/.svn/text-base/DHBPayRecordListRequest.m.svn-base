//
//  DHBPayRecordListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayRecordListRequest.h"

@implementation DHBPayRecordListRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"ordersPayment";
}

-(id)value{
    return @{@"orders_num":self.orders_num};
}

- (BOOL)submitValidate{
    if(IsNilOrNull(self.orders_num)){
        [self showMessage: @"订单编号为空"];
        return NO;
    }
    return YES;
}
@end
