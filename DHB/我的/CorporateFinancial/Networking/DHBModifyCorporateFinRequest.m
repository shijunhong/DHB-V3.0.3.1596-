//
//  DHBModifyCorporateFinRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBModifyCorporateFinRequest.h"

@implementation DHBModifyCorporateFinRequest
- (NSString *)controller{ 
    return @"DingHuo";
}

- (NSString *)action{
    return @"myFinanceSubmit";
}

-(id)value{
    return @{@"account_name": [self.corporateInfo account_name], @"bank": [self.corporateInfo bank], @"bank_account": [self.corporateInfo bank_account], @"taxpayer_number": [self.corporateInfo taxpayer_number], @"invoice_title":[self.corporateInfo invoice_title]};
}

//#pragma mark - 数据验证
//- (BOOL)submitValidate{
//    BOOL isValidate = YES;
//    NSString *message = @"";
//    if([[self.corporateInfo account_name] length] <= 0){
//        isValidate = NO;
//        message = @"请填写开户名称";
//    }
//    if([[self.corporateInfo bank] length] <= 0){
//        isValidate = NO;
//        message = @"请填写开户银行";
//    }
//    if([[self.corporateInfo bank_account] length] <= 0){
//        isValidate = NO;
//        message = @"请填写银行账号";
//    }
//    if([[self.corporateInfo taxpayer_number] length] <= 0){
//        isValidate = NO;
//        message = @"请填写纳税人识别号";
//    }
//    ///未通过验证时， 显示提示信息
//    if(!isValidate){
//        [self showMessage: message];
//    }
//    return isValidate;
//}
@end
