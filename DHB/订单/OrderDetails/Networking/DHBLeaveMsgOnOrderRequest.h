//
//  DHBLeaveMsgOnOrderRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/26.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBLeaveMsgOnOrderRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSString *orders_id;
@property(nonatomic,strong)NSString *remark;
@end
