//
//  DHBOfflineRechargeService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"

@protocol DHBOfflineRechargeService_Delegte <NSObject>
- (void)offlineRechargeService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBOfflineRechargeService : NSObject
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, assign) id<DHBOfflineRechargeService_Delegte> delegate;

- (void)queryData;
@end
