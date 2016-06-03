//
//  DHBSupplierModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSupplierModuleDTO.h"

@implementation DHBSupplierModuleDTO
/**
 *  将接口对象解析成供应商数据模型
 *
 *  @param dictionary: 接口返回数据
 */
- (void)parseWithDic:(NSDictionary *)dictionary{
    if(IsNilOrNull(dictionary)){
        return;
    }
    self.name = [dictionary EncodeStringFromDicWithKey: @"name"];
    self.message = [dictionary EncodeStringFromDicWithKey: @"message"];
    self.company_id = [dictionary EncodeStringFromDicWithKey: @"company_id"];
    self.is_login = [[dictionary EncodeStringFromDicWithKey: @"is_login"] isEqualToString: @"T"] ? YES : NO;
}

/**
 *  将供应商数据模型解析成字典数据模型
 *
 *  @return 解析后的数据模型
 */
- (NSDictionary *)dictionaryFromDTO{
    return [NSDictionary dictionaryWithObjectsAndKeys: (self.name ? self.name : @""), @"name", (self.message ? self.message : @""), @"message",  (self.company_id ? self.company_id : @""), @"company_id", nil];
}
@end
