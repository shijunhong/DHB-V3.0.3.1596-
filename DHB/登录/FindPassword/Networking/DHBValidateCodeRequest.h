//
//  DHBValidateCodeRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBValidateCodeRequest : DHBBaseNetworkRequest
@property(nonatomic, retain) NSString *accounts_mobile;
@property(nonatomic, retain) NSString *verification_code;
@end
