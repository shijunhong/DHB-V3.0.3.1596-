//
//  LogisticsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"

@class LogisticsService;
@protocol LogisticsServiceDelegate <NSObject>
@optional
- (void)logisticsServiceComplete:(LogisticsService *)service isSuccess:(BOOL)isSuccess;
@end


@interface LogisticsService : NSObject
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)id<LogisticsServiceDelegate> delegate;
@property(nonatomic, strong)ShipsChildModuleDTO *ships;
@property(nonatomic, strong)NSMutableArray *logisticslist;
- (void)queryLogisticsData;
@end
