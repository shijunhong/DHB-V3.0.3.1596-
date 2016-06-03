//
//  DHBReturnsOrderMessageRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBReturnsOrderMessageRequest : DHBBaseNetworkRequest
@property(nonatomic , retain)NSString *returns_id; // 退货单ID
@property(nonatomic , retain)NSString *remark; //留言信息
@end
