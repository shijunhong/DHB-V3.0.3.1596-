//
//  DHBSelectSupplierRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/23/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSelectSupplierRequest.h"

@implementation DHBSelectSupplierRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"chooseCompany";
}

-(id)value{
    return @{@"skey": self.skey, @"company_id": self.company_id, @"action":@"noSkey"};
}

/**
 *  对提交的数据进行验证
 *
 *  @return 验证通过返回YES,验证失败返回NO
 */
- (BOOL)submitValidate{
    if([[self skey] length] <= 0){
        [self showMessage: @"缺少skey"];
        return NO;
    }
    if([[self company_id] length] <= 0){
        [self showMessage: @"缺少公司编号"];
        return NO;
    }
    return YES;
}
@end
