//
//  DHBReturnsOrderMessageRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnsOrderMessageRequest.h"

@implementation DHBReturnsOrderMessageRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"leaveMsgOnReturn";
}

-(id)value{
    return @{@"returns_id": self.returns_id, @"remark": self.remark};
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
