//
//  DHBOrderAttachmentModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderAttachmentModuleDTO.h"

@implementation DHBOrderAttachmentModuleDTO
#pragma mark - 解析数据
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.attachID = [dict EncodeStringFromDicWithKey:@"attachID"];
    self.attatchName =[dict EncodeStringFromDicWithKey:@"attatchName"];
}
@end
