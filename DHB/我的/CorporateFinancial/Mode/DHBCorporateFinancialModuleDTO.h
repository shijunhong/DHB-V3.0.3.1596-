//
//  DHBCorporateFinancialModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/8/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBCorporateFinancialModuleDTO : NSObject
//@property(nonatomic, retain) NSString *client_name; //公司名称
@property(nonatomic, retain) NSString *account_name; //开户名称
@property(nonatomic, retain) NSString *bank; //开户银行
@property(nonatomic, retain) NSString *bank_account; //银行账号
@property(nonatomic, retain) NSString *taxpayer_number; //纳税人识别号
@property(nonatomic, retain) NSString *invoice_title; //发票抬头

- (void)parseFromDic:(NSDictionary *) dic;
@end
