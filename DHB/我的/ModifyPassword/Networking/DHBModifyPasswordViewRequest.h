//
//  DHBModifyPasswordViewRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/29/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBModifyPasswordViewRequest : DHBBaseNetworkRequest
@property(nonatomic, retain) NSString *old_pwd;
@property(nonatomic, retain) NSString *n_pwd;
@property(nonatomic, retain) NSString *n_pwd_repeat;
@end
