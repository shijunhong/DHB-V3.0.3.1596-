//
//  GoodsFieldModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/7.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsFieldModuleDTO : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *value;
- (void)parseFromDict:(NSDictionary *)dict;
@end
