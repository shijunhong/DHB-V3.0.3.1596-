//
//  DHBPayHistoryInfoModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBPayHistoryInfoModuleDTO : NSObject<NSCopying>

@property(nonatomic,assign)NSInteger receipts_id;// 明细ID
@property(nonatomic,strong)NSString *amount;//金额
@property(nonatomic,strong)NSString *incexp_id;//预存款类型
@property(nonatomic,strong)NSString *type_id;//付款方式
@property(nonatomic,retain)NSDate *create_date;//支付时间
@property(nonatomic,strong)NSString *status;//状态

- (void)parseFromDict:(NSDictionary *)dict;
@end
