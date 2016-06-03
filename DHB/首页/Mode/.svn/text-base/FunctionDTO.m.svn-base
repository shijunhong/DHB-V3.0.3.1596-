//
//  FunctionDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "FunctionDTO.h"

@implementation FunctionDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.functionId = [[dict EncodeNumberFromDicWithKey:@"functionId"] integerValue];
    self.name = [dict EncodeStringFromDicWithKey:@"name"];
    self.image = [dict EncodeStringFromDicWithKey:@"image"];
    self.number = [[dict EncodeStringFromDicWithKey:@"number"] integerValue];
}

@end
