//
//  DHBAboutModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/29/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAboutModuleDTO.h"

@implementation DHBAboutModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.qr_code_url = [dict EncodeStringFromDicWithKey:@"qr_code_url"];
    self.mobile_website_url = [dict EncodeStringFromDicWithKey:@"mobile_website_url"];
    self.copyright = [dict EncodeStringFromDicWithKey:@"copyright"];
    self.company = [dict EncodeStringFromDicWithKey:@"company"];
}
@end
