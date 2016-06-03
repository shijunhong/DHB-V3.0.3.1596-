//
//  DHBPayHistoryDetailsRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBPayHistoryDetailsRequest : DHBBaseNetworkRequest
@property(nonatomic, assign) NSInteger receipts_id;
@end
