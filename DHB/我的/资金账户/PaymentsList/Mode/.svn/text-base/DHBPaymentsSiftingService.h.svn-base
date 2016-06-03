//
//  DHBPaymentsSiftingService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBPaymentsSiftingRequest.h"
#import "DHBPaymentsSiftingMOduleDTO.h"

@protocol DHBPaymentsSiftingService_Delegate <NSObject>
- (void)paymentsSiftingService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPaymentsSiftingService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign) id<DHBPaymentsSiftingService_Delegate> delegate;
@property(nonatomic, retain) DHBPaymentsSiftingMOduleDTO *siftingDTO;

- (void)querySiftingData;
@end
