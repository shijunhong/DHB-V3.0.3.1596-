//
//  DHBReturnedOrderModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBReturnedOrderModuleDTO : NSObject
@property(nonatomic,strong)NSString *returns_id; //订单ID
@property(nonatomic,strong)NSString *returns_num;//退货单编号
@property(nonatomic,strong)NSString *create_date;//创建时间
@property(nonatomic,strong)NSString *discount_total;//退款金额
@property(nonatomic,strong)NSString *returns_details_count;//退单数量
@property(nonatomic,strong)NSString *status;//订单状态

- (void)parseFromDict:(NSDictionary *)dict;
@end
