//
//  PaymentsDetailsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "DHBPaymentsInfoModuleDTO.h"
#import "DHBPaymentsDetailsRequest.h"
#import "DHBPayHistoryInfoModuleDTO.h"

@protocol DHBPaymentsDetailsService_Delegate <NSObject>
@optional
- (void)DHBPaymentsDetailsService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPaymentsDetailsService : NSObject
@property(nonatomic, assign) id<DHBPaymentsDetailsService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) DHBPaymentsInfoModuleDTO *paymentsDTO;


@property(nonatomic, assign)BOOL is_payHistory;
@property(nonatomic, strong) DHBPayHistoryInfoModuleDTO *payHistoryDTO;

-(void)queryDetailsData;
@end
