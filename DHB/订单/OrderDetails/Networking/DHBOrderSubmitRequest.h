//
//  DHBOrderSubmitRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/11.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"
#import "UserInformationModuleDTO.h"

@interface DHBOrderSubmitRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)UserInformationModuleDTO *userInformation;
@end
