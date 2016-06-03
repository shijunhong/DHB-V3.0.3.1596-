//
//  DHBMessageSendRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/14.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBMessageSendRequest : DHBBaseNetworkRequest
@property(nonatomic ,strong)NSString *post_title_id;
@property(nonatomic ,strong)NSString *content;
@end
