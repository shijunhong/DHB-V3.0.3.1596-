//
//  DHBReturnedListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBReturnedListRequest.h"
#import "DHBReturnedOrderModuleDTO.h"
#import "DHBCancelReturnsOrderRequest.h"
#import "DHBReturnsOrderModuleDTO.h"

@protocol DHBReturnedListService_Delegate <NSObject>
- (void)returnedListService_Complete: service isSuccess:(BOOL) isSuccess;
//- (void)returnedListService_CancelComplete: service isSuccess:(BOOL) isSuccess;
@end

@interface DHBReturnedListService : NSObject
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger cpage;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSString *returns_id; //退货单编号
@property(nonatomic, retain) NSString *cancel_reason; //退货原因
@property(nonatomic, retain) NSString *message;
@property(nonatomic, assign) id<DHBReturnedListService_Delegate> delegate;

- (void)queryData;
- (void)cancelReturnsOrder;
/**
 *  根据退货单ID查询退货单
 *
 *  @param returns_id
 *  @param callback
 */
-(void)queryReturnOrderDetailsData:(NSString*)returns_id returnOrder:(void(^)(DHBReturnsOrderModuleDTO* returnOrder))callback;
@end
