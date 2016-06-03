//
//  DHBRechargeMethodService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "OrderModuleDTO.h"

@protocol DHBRechargeMethodService_Delegate <NSObject>
@optional
- (void)rechargeMethodService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBRechargeMethodService : NSObject
@property(nonatomic, assign) id<DHBRechargeMethodService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) OrderModuleDTO *order;//订单
-(void)queryData;
@end
