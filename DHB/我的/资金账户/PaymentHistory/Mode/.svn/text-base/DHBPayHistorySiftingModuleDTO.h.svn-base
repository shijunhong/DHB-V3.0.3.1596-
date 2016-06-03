//
//  DHBPayHistorySiftingModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBPayHistorySiftingModuleDTO : NSObject
@property(nonatomic ,retain)NSMutableArray *statusArray;
@property(nonatomic ,retain)NSMutableArray *typeArray;
- (void)parseFromDict:(NSDictionary *)dict;
@end


@interface DHBPayHistoryTypeDTO : NSObject
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *value;
@property(nonatomic ,assign)BOOL is_select;
- (void)parseFromDict:(NSDictionary *)dict;
@end