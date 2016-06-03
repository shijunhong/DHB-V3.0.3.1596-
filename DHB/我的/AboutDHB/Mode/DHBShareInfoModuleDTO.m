//
//  DHBShareInfoModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/23/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShareInfoModuleDTO.h"

@implementation DHBShareInfoModuleDTO

- (void)parseFromDic:(NSDictionary *) dic{
    if(IsNilOrNull(dic)){
        return;
    }
    self.share_content = [dic EncodeStringFromDicWithKey:@"share_content"];
    self.share_picture = [dic EncodeStringFromDicWithKey:@"share_picture"];
    self.share_title = [dic EncodeStringFromDicWithKey:@"share_title"];
    self.share_url = [dic EncodeStringFromDicWithKey:@"share_url"];
}

@end
