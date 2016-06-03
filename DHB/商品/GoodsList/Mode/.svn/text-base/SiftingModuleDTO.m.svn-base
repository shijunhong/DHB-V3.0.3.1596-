//
//  SiftingModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "SiftingModuleDTO.h"

@implementation SiftingModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.brands = [NSMutableArray array];
    NSArray *arr = [dict EncodeArrayFromDicWithKey:@"brand"];
    for (NSDictionary *dic in arr)
    {
        BrandModuleDTO *brand = [[BrandModuleDTO alloc] init];
        [brand parseFromDict:dic];
        [self.brands addObject:brand];
        
    }
    TT_RELEASE_SAFELY(arr);
    self.tags = [NSMutableArray array];
    NSArray *tags = [dict EncodeArrayFromDicWithKey:@"tags"];
    for (NSDictionary *dic in tags)
    {
        TagModuleDTO *tag = [[TagModuleDTO alloc] init];
        [tag parseFromDict:dic];
        [self.tags addObject:tag];
    }
    
}
@end


@implementation BrandModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.brand_id =[[dict EncodeNumberFromDicWithKey:@"brand_id"] integerValue];
    self.brand_name =[dict EncodeStringFromDicWithKey:@"brand_name"];
}
@end

@implementation TagModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.tag_id =[[dict EncodeNumberFromDicWithKey:@"tags_id"] intValue];
    self.tag_name =[dict EncodeStringFromDicWithKey:@"tags_name"];
}
@end