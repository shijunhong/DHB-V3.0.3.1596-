//
//  DHBReturnedGoodsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DHBReturnedGoodsService;
@protocol ReturnedGoodsServiceDelegate <NSObject>
@optional
- (void)returnedGoodsServiceComplete:(DHBReturnedGoodsService *)service isSuccess:(BOOL )isSuccess;
@end


@interface DHBReturnedGoodsService : NSObject
@property (nonatomic, assign) id<ReturnedGoodsServiceDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *dataArray;
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic,strong)NSString *orders_id;
@property(nonatomic,strong)NSString *orders_num;

-(void)queryOrderDetailData;
@end
