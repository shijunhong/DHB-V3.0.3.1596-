//
//  CategoryModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModuleDTO : NSObject<NSCopying>
@property(nonatomic ,assign)NSUInteger category_count;//分类子类个数
@property(nonatomic ,assign)NSInteger category_id;//商品类id
@property(nonatomic ,strong)NSString *category_name;//商品分类名称
@property(nonatomic ,assign)NSInteger parent_id;//父类id
@property(nonatomic ,strong)NSString *name;//商品分类名称
@property(nonatomic ,assign)BOOL is_select;//选中中
- (void)parseFromDict:(NSDictionary *)dict;
@end
