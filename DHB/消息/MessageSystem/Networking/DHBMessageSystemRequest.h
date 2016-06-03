//
//  DHBMessageSystemRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBMessageSystemRequest : DHBBaseNetworkRequest
@property(nonatomic ,assign)NSInteger page;
@property(nonatomic ,assign)NSInteger step;
@end
