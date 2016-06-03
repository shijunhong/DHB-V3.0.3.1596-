//
//  DHBCancelOrderRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/3.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCancelOrderRequest.h"

@implementation DHBCancelOrderRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"cancelOrder";
}

-(id)value{
    return @{@"orders_id":self.orders_id,
             @"remark":self.remark};
}

- (BOOL)submitValidate{
    if([self.remark length] <= 0){
        [self showMessage: L(@"请填写取消订单的原因")];
        return NO;
    }
    if([self.remark length] >0 && [self.remark length] <= 4){
        [self showMessage: L(@"请输入4-50字符")];
        return NO;
    }
    return YES;
}
@end
