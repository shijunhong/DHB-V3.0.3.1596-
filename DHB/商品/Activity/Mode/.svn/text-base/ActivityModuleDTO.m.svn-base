//
//  ActivityModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ActivityModuleDTO.h"

@implementation ActivityModuleDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.img = [dict EncodeStringFromDicWithKey:@"img"];
    self.link = [dict EncodeStringFromDicWithKey:@"link"];
    self.item = [dict EncodeStringFromDicWithKey:@"item"];
}

@end
