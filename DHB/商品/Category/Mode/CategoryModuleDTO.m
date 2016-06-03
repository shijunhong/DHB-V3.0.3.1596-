//
//  CategoryModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "CategoryModuleDTO.h"

@implementation CategoryModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict))
    {
        return;
    }
    self.category_id = [[dict EncodeNumberFromDicWithKey:@"category_id"] integerValue];
    self.parent_id = [[dict EncodeNumberFromDicWithKey:@"parent_id"] integerValue];
    self.category_name = [dict EncodeStringFromDicWithKey:@"category_name"];
    self.category_count = [[dict EncodeNumberFromDicWithKey:@"category_count"] integerValue];
    self.name = [dict EncodeStringFromDicWithKey:@"category_name"];
}


-(id)copyWithZone:(NSZone *)zone{
    CategoryModuleDTO *category=[[[self class] allocWithZone:zone] init];
    category.category_id = _category_id;
    category.parent_id = _parent_id;
    NSString *category_name=[_category_name copy];
    category.category_name=category_name;
    category.category_count = _category_count;
    NSString *name=[_name copy];
    category.name=name;
    return category;
}


@end
