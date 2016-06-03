//
//  OrderGoodsListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderGoodsListService;
@protocol OrderGoodsListServiceDelegate <NSObject>
@optional
- (void)orderGoodsListServiceComplete:(OrderGoodsListService *)service isSuccess:(BOOL )isSuccess;
@end

@interface OrderGoodsListService : NSObject

@property (nonatomic, assign) id<OrderGoodsListServiceDelegate> delegate;
//订单列表数据
@property (nonatomic, strong)NSMutableArray *dataArray;
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic,strong)NSString *orders_id;

-(void)queryOrderDetailData;
@end
