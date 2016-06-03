//
//  DHBSupplierListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSupplierListRequest.h"

@implementation DHBSupplierListRequest
- (NSString *)controller{
    return @"DingHuo";
}

- (NSString *)action{
    return @"getAllCompanyInfo";
}

-(id)value{
    return @{@"skey": self.skey, @"action": @"noSkey"};
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
    return YES;
}
@end
