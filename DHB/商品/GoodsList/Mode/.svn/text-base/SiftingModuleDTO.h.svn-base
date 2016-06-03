//
//  SiftingModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SiftingModuleDTO : NSObject

@property(nonatomic ,strong)NSMutableArray *brands;
@property(nonatomic ,strong)NSMutableArray *tags;
- (void)parseFromDict:(NSDictionary *)dict;
@end


@interface BrandModuleDTO : NSObject
@property(nonatomic, assign)NSInteger brand_id;
@property(nonatomic, strong)NSString *brand_name;
- (void)parseFromDict:(NSDictionary *)dict;
@end

@interface TagModuleDTO : NSObject
@property(nonatomic, assign)int tag_id;
@property(nonatomic, strong)NSString *tag_name;
@property(nonatomic ,assign)BOOL is_select;
- (void)parseFromDict:(NSDictionary *)dict;
@end