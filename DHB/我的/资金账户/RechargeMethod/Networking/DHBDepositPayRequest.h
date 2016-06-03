//
//  DHBDepositPayRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBDepositPayRequest : DHBBaseNetworkRequest

@property(nonatomic,strong)NSString *orders_num;
@property(nonatomic,strong)NSString *amount;

@end
