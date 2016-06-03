//
//  DHBCancelReturnsOrderRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/26/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCancelReturnsOrderRequest.h"

@implementation DHBCancelReturnsOrderRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"cancelReturns";
}

-(id)value{
    return @{@"returns_id": self.returns_id, @"remark": self.reason};
}


- (BOOL)submitValidate{
    if([self.reason length] <= 0){
        [self showMessage: L(@"请填写取消退货单的原因")];
        return NO;
    }
    if([self.reason length] >0 && [self.reason length] <= 4){
        [self showMessage: L(@"请输入4-50字符")];
        return NO;
    }
    return YES;
}

@end
