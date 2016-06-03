//
//  DHBDeliveryViewMode.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDeliveryViewModuleDTO.h"

@implementation DHBDeliveryViewModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.modelNO = [dict EncodeNumberFromDicWithKey: @"ModelNO"];
    self.title = [dict EncodeStringFromDicWithKey:@"Title"];
    self.placeholder = [dict EncodeStringFromDicWithKey:@"Placeholder"];
    self.content = [dict EncodeStringFromDicWithKey:@"content"] == nil ? @"" : [dict EncodeStringFromDicWithKey:@"content"];
}
@end
