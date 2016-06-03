//
//  DHBPaymentsListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBPaymentsInfoModuleDTO.h"
#import "DHBPaymentsListRequest.h"
#import "HomeFloorDTO.h"

@protocol DHBPaymentsListService_Delegate <NSObject>
- (void)paymentsListService_omplete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPaymentsListService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, assign) id<DHBPaymentsListService_Delegate> delegate;
@property(nonatomic, retain) NSMutableArray *floorsArray;
@property(nonatomic, retain) NSString *deposit_type;//预存款类型
@property(nonatomic, retain) NSString *type_id;//支付方式
@property(nonatomic, retain) NSString *begin_date;//开始时间
@property(nonatomic, retain) NSString *end_date;//终止时间

- (void)queryListData;
@end
