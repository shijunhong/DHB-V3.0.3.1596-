//
//  DHBCustomerService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/5/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define SERVICE_CELL_HEIGHT 50.0f
#import <Foundation/Foundation.h>
#import "DHBCustomerModuleDTO.h"
#import "HomeFloorDTO.h"
#import "DHBCustomerRequest.h"

@protocol DHBCustomerService_Delegate <NSObject>
- (void)customerService_Compelete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBCustomerService : NSObject
@property(nonatomic, retain) NSMutableArray *floorsArray;
@property(nonatomic, assign) id<DHBCustomerService_Delegate> delegate;

- (void)queryData;
@end
