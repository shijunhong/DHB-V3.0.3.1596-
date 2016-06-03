//
//  DHBAddNewMessageRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddNewMessageRequest.h"

@implementation DHBAddNewMessageRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgPostSubmit";
}

-(id)value{
    return @{@"content": (self.content ? self.content : @"")};
}

- (BOOL)submitValidate{
    if([self.content length] <= 0){
        [self showMessage: @"请输入留言内容"];
        return NO;
    }
    return YES;
}
@end
