//
//  DHBPayRecordDetailsRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/27.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBPayRecordDetailsRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSString *payment_id; ///详情编号
@end
