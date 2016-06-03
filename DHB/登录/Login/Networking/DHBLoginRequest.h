//
//  DHBLoginRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBLoginRequest : DHBBaseNetworkRequest
@property(nonatomic, strong) NSString *account;
@property(nonatomic, strong) NSString *password;
@end
