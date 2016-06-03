//
//  OrderDetailsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"
@class OrderDetailsService;
@protocol OrderDetailsServiceDelegate <NSObject>
@optional
- (void)orderDetailsServiceComplete:(OrderDetailsService *)service isSuccess:(BOOL )isSuccess;
@end

@interface OrderDetailsService : NSObject
@property (nonatomic, strong)OrderModuleDTO *order;
@property (nonatomic, assign) id<OrderDetailsServiceDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSError *error;
@property(nonatomic,strong)NSString *orders_id;//订单id

/**
 *  查询订单详情数据
 */
-(void)queryOrderDetailData;

/**
 *  取消订单
 *  @param msg       取消原因
 *  @param block
 */
-(void)cancelOrderRemark:(NSString*)msg callback:(void(^)(BOOL is_success))block;

/**
 *  订单留言
 *  @param msg       留言内容
 *  @param block
 */
-(void)LeaveMsgRemark:(NSString*)msg callback:(void(^)(BOOL is_success))block;

/**
 *  收藏订单
 *  @param block
 */
-(void)FollowOrderCallback:(void(^)(BOOL is_success ,NSString* msg))block;

@end
