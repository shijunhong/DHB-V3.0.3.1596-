//
//  DHBPayHistorySiftingModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayHistorySiftingModuleDTO.h"

@implementation DHBPayHistorySiftingModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.statusArray = [NSMutableArray array];
    NSArray *tmpArray = [dict EncodeArrayFromDicWithKey:@"status_id"];
    for (NSDictionary *dic in tmpArray)
    {
        DHBPayHistoryTypeDTO *type = [[DHBPayHistoryTypeDTO alloc] init];
        [type parseFromDict:dic];
        [self.statusArray addObject:type];
        
    }
    TT_RELEASE_SAFELY(tmpArray);
    self.typeArray = [NSMutableArray array];
    tmpArray = [dict EncodeArrayFromDicWithKey:@"type_id"];
    for (NSDictionary *dic in tmpArray)
    {
        DHBPayHistoryTypeDTO *type = [[DHBPayHistoryTypeDTO alloc] init];
        [type parseFromDict:dic];
        [self.typeArray addObject:type];
    }
}
@end


@implementation DHBPayHistoryTypeDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.name = [dict objectForKey: @"name"];
    self.value = [dict objectForKey: @"value"];
}
@end

