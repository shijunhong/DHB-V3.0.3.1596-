//
//  GoodsFieldModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/7.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "GoodsFieldModuleDTO.h"

@implementation GoodsFieldModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.name = [dict EncodeStringFromDicWithKey:@"name"];
    self.value = [dict EncodeStringFromDicWithKey:@"value"];
}
@end
