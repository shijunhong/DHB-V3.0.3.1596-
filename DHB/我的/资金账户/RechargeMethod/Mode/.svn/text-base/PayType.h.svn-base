//
//  PayType.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/18.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    Quick,//快速支付
    Alipay,//支付宝
    Micro,//微信
    Offline,//线下支付
    Deposit,//余额支付
    BaiTiao//余额支付
}Paytype;

@interface PayType : NSObject
@property(nonatomic,strong)NSString *paytype;//支付类型
@property(nonatomic,strong)NSString *paytype_value;//支付类型英文（‘Quick,’Alipay’,’Micro’,’Offline’,’Deposit’）
@property(nonatomic,strong)NSString *is_recom;//是否推荐
@property(nonatomic,strong)NSString *is_manager;//供应商是否开通
@property(nonatomic,strong)NSString *is_client;//经销商是否开通
@property(nonatomic,strong)NSString *money;//余额
@property(nonatomic,assign)Paytype type;
- (void)parseFromDict:(NSDictionary *)dict;
@end
