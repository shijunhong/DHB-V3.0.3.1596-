//
//  ProductFloorDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "GoodsFloorDTO.h"

@implementation GoodsFloorDTO

- (id)initWithName:(NSString *)name moduleList:(NSMutableArray*)moduleList children:(NSMutableArray *)children
{
    self = [super init];
    if (self) {
        self.children = [NSMutableArray arrayWithArray:children];
        self.name = name;
        self.moduleList =[NSMutableArray arrayWithArray:moduleList];
    }
    return self;
}

+ (id)dataObjectWithName:(NSString *)name moduleList:(NSMutableArray*)moduleList children:(NSMutableArray *)children
{
    return [[self alloc] initWithName:name moduleList:moduleList children:children];
}

- (void)addChild:(id)child
{
    NSMutableArray *children = [self.children mutableCopy];
    [children insertObject:child atIndex:0];
    self.children = [children copy];
}

- (void)removeChild:(id)child
{
    NSMutableArray *children = [self.children mutableCopy];
    [children removeObject:child];
    self.children = [children copy];
}

@end
