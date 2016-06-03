//
//  DHBPaymentsInfoModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBPaymentsInfoModuleDTO : NSObject<NSCopying>
@property(nonatomic, retain) NSString *deposit_id; //明细ID
@property(nonatomic, retain) NSString *amount; //金额
@property(nonatomic, retain) NSString *deposit_type; //	预存款类型
@property(nonatomic, retain) NSString *type_id; //	付款方式
@property(nonatomic, retain) NSString *deposit_balance; //余额
@property(nonatomic, retain) NSDate *pay_time; //	支付时间

@property(nonatomic, retain) NSString *status; //状态
@property(nonatomic, retain) NSString *orders_num; //关联单号
@property(nonatomic, retain) NSString *receipts_date; //转账时间
@property(nonatomic, retain) NSString *update_date; //到账时间
@property(nonatomic, retain) NSString *bank_name; //开户行
@property(nonatomic, retain) NSString *account_name; //开户名
@property(nonatomic, retain) NSString *account_number; //收款账号
@property(nonatomic, retain) NSString *remark; //备注

@property(nonatomic, retain) NSString *resource; //资源图片

- (void)parseFromDict:(NSDictionary *)dict;
@end
