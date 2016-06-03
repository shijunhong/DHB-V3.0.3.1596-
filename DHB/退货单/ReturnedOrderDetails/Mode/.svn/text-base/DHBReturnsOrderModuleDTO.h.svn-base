//
//  DHBReturnsOrderModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"
#import "DHBDeliveryMethodMoudleDTO.h"

@interface DHBReturnsOrderModuleDTO : NSObject
@property(nonatomic,strong)NSString *returns_id;//退单ID
@property(nonatomic,strong)NSString *returns_num;//退单编号
@property(nonatomic,strong)NSString *status;//状态
@property(nonatomic,strong)NSString *discount_total;//退单金额
@property(nonatomic,strong)NSString *returns_total;//商品金额
@property(nonatomic,strong)NSString *returns_details_count;//商品数量
@property(nonatomic,strong)NSString *create_date;//下单时间
@property(nonatomic,strong)NSString *returns_reason; //备注信息

@property(nonatomic,strong)NSString *returns_consignee;//收货人
@property(nonatomic,strong)NSString *returns_phone;//收货人电话
@property(nonatomic,strong)NSString *returns_address;//收货人地址

@property(nonatomic, retain) DHBDeliveryMethodMoudleDTO *deliveryMethodDTO;

@property(nonatomic,strong)NSMutableArray *log_returns;//操作日志

@property(nonatomic,strong)NSString *attachmentNumber;//退货附件数量
- (void)parseFromDict:(NSDictionary *)dict;
@end
