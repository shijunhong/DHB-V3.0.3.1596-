//
//  DHBOrderStateRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBOrderStateRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSString *orders_id;
@end
