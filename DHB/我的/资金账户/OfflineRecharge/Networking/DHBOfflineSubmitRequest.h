//
//  DHBOfflineSubmitRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/20.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBOfflineSubmitRequest : DHBBaseNetworkRequest

@property(nonatomic,strong)NSString *bank_id;
@property(nonatomic,strong)NSString *orders_num;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *amount;//付款金额
@property(nonatomic,strong)NSString *receipts_date;//时间

@end
