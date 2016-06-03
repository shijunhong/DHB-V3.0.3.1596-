//
//  OrderStateService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderStateService;
@protocol OrderStateServiceDelegate <NSObject>
@optional
- (void)orderStateServiceComplete:(OrderStateService *)service isSuccess:(BOOL)isSuccess;
@end

@interface OrderStateService : NSObject
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)id<OrderStateServiceDelegate> delegate;
@property(nonatomic, strong)NSMutableArray *statelist;
//@property(nonatomic, assign)BOOL first;

@property(nonatomic, strong)NSString *orders_id;
@property(nonatomic, strong)NSString *create_date;
@property(nonatomic, strong)NSString *orders_num;
- (void)queryOrderStateData;
@end
