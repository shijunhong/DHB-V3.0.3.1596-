//
//  DHBGetLogisticsRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/1.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBGetLogisticsRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSString *express_name;
@property(nonatomic,strong)NSString *express_number;
@end
