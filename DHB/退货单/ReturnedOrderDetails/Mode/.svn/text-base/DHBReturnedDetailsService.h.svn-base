//
//  DHBReturnedDetailsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBReturnsOrderModuleDTO.h"
#import "DHBReturnsDetailsRequest.h"
#import "HomeFloorDTO.h"
#import "DHBReturnedOrderStatusRequest.h"
#import "DHBCancelReturnsOrderRequest.h"
#import "DHBReturnsAttachmentRequest.h"
#import "DHBReturnsOrderMessageRequest.h"

@protocol DHBReturnedDetailsService_Delegate <NSObject>
@optional
- (void)returnedDetailsService_Complete: service isSuccess:(BOOL)isSuccess;
- (void)returnedDetailsService_OrderStatusRequestFinish: service isSuccess:(BOOL)isSuccess;
- (void)returnedDetailsService_CancelComplete: service isSuccess:(BOOL)isSuccess;
- (void)returnedDetailsService_ReturnsAttachmentComplete: service isSuccess:(BOOL)isSuccess;
- (void)returnedDetailsService_LeaveMessageComplete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBReturnedDetailsService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign)BOOL first;
@property(nonatomic, assign) id<DHBReturnedDetailsService_Delegate> delegate;
@property(nonatomic, strong) DHBReturnsOrderModuleDTO *returnedOrderDTO;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) NSMutableArray *statusFloorsArray;
@property(nonatomic, strong) NSString *returns_id; ///退货单ID
@property(nonatomic, retain) NSString *cancel_reason; //退货原因
@property(nonatomic, retain) NSString *message; ///接口返回的消息
@property(nonatomic, retain) NSString *leaveMessage; //留言的内容

-(void)queryOrderDetailsData; ///查询详情数据
- (void)queryOrderStateData;//查询订单状态
- (void)cancelReturnsOrder; //取消退货
- (void)submitLeaveMessage; //留言
@end
