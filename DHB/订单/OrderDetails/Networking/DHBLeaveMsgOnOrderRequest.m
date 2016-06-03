//
//  DHBLeaveMsgOnOrderRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/26.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLeaveMsgOnOrderRequest.h"

@implementation DHBLeaveMsgOnOrderRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"leaveMsgOnOrder";
}

-(id)value{
    return @{@"orders_id":self.orders_id,
             @"remark":self.remark};
}

-(BOOL)submitValidate{
    if ([self.remark length] <= 0)
    {
        [self showMessage: L(@"请填写留言内容")];
        return NO;
    }
    if([self.remark length] >0 && [self.remark length] <= 4){
        [self showMessage: L(@"请输入4-50字符")];
        return NO;
    }
    return YES;
}
@end
