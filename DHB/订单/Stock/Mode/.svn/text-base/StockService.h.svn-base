//
//  StockService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"
@class StockService;
@protocol StockServiceDelegate <NSObject>
@optional
- (void)stockServiceComplete:(StockService *)service isSuccess:(BOOL )isSuccess;
@end

@interface StockService : NSObject
@property (nonatomic, assign) id<StockServiceDelegate> delegate;
@property (nonatomic, strong)ShipsModuleDTO *ships;
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic,strong)NSString *orders_id;

-(void)queryOrderDetailData;
@end
