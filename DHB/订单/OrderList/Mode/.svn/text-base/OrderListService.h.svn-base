//
//  OrderListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"
@class OrderListService;
@protocol OrderListServiceDelegate <NSObject>
@optional
- (void)orderListServiceComplete:(OrderListService *)service isSuccess:(BOOL)isSuccess;
@end


@interface OrderListService : NSObject

@property(nonatomic, assign)id<OrderListServiceDelegate> delegate;
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger cpage;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, strong)NSMutableArray *orderlist;//订单列表
/* 筛选*/
@property(nonatomic, strong)NSString *is_attention;//是否关注的 ‘T’,’F
@property(nonatomic, strong)NSMutableArray *pay_status_arr;//付款列表数据
@property(nonatomic, strong)NSString *pay_status;//付款状态
@property(nonatomic, strong)NSMutableArray *status_arr;//订单状态列表数据
@property(nonatomic, strong)NSString *status;//订单状态
@property(nonatomic, strong)NSString *begin_date;//订单开始时间
@property(nonatomic, strong)NSString *end_date;//订单终止时间
/* 搜索*/
@property(nonatomic, strong)NSString *content;//搜索内容
/**
 *  获取列表数据
 */
- (void)queryOrderData;

/**
 *  获取筛选数据
 *
 *  @param block
 */
- (void)querySiftingDataCallBack:(void(^)(BOOL is_success))block;
/**
 *  是否为全部订单 （筛选 搜索  条件为空）
 *
 *  @return
 */
-(BOOL)isAllOrder;

/**
 *  获取订单
 *
 *  @param orders_id 订单id
 *  @param callback  订单
 */
-(void)queryOrder:(NSString*)orders_id Order:(void(^)(OrderModuleDTO*order))callback;
@end
