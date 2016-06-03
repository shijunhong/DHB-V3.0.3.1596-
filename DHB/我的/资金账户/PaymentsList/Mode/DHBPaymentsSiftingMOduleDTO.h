//
//  DHBPaymentsSiftingMOduleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
////收支明细的筛选模型
@interface DHBPaymentsSiftingMOduleDTO : NSObject
@property(nonatomic ,retain)NSMutableArray *depositTypeArray;
@property(nonatomic ,retain)NSMutableArray *payTypeArray;
- (void)parseFromDict:(NSDictionary *)dict;
@end

////充值类型
@interface DHBDepositTypeModuleDTO : NSObject
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *value;
@property(nonatomic ,assign)BOOL is_select;
- (void)parseFromDict:(NSDictionary *)dict;
@end

////支付方式
@interface DHBPayTypeModuleDTO : NSObject
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *value;
@property(nonatomic ,assign)BOOL is_select;
- (void)parseFromDict:(NSDictionary *)dict;
@end