//
//  DHBPayHistorySiftingService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBPayHistorySiftingModuleDTO.h"

@protocol DHBPayHistorySiftingService_Delegate <NSObject>
- (void)payHistorySiftingService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPayHistorySiftingService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign) id<DHBPayHistorySiftingService_Delegate> delegate;
@property(nonatomic, retain) DHBPayHistorySiftingModuleDTO *siftingDTO;
- (void)querySiftingData;

@end
