//
//  DHBPaymentRecordDetailsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "DHBPaymentRecordModuleDTO.h"

@protocol DHBPaymentRecordDetailsService_Delegate <NSObject>
@optional
- (void)DHBPaymentRecordDetailsService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPaymentRecordDetailsService : NSObject
@property(nonatomic, assign) id<DHBPaymentRecordDetailsService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) NSString *payment_id; ///详情编号
@property(nonatomic, retain) DHBPaymentRecordModuleDTO *paymentDTO;
-(void)queryDetailsData;
@end
