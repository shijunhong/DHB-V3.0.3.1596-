//
//  ProductFloorDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsFloorDTO : NSObject
//楼层层高
@property (nonatomic, assign) NSInteger hight;
//楼层序号
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray  *moduleList;
@property (strong, nonatomic) NSMutableArray  *children;//展开楼层
//模板ID
@property (nonatomic, copy) NSString    *templateID;
@property (nonatomic, assign)BOOL is_expanded;//是否展开

- (id)initWithName:(NSString *)name moduleList:(NSMutableArray*)moduleList children:(NSMutableArray *)children;
+ (id)dataObjectWithName:(NSString *)name moduleList:(NSMutableArray*)moduleList children:(NSMutableArray *)children;
@end
