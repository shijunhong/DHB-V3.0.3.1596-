//
//  InvoiceModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoiceModuleDTO : NSObject
@property(nonatomic,assign)NSInteger invoice_id;//发票ID
@property(nonatomic,strong)NSString *invoice_type;//发票类型enum(‘F’,’P’,’Z’)
@property(nonatomic,strong)NSString *invoice_title;//发票抬头
@property(nonatomic,assign)NSInteger invoice_tax;//税点
@property(nonatomic,strong)NSString *invoice_content;//发票内容
@property(nonatomic,strong)NSString *bank;//开户银行
@property(nonatomic,strong)NSString *bank_account;//银行帐号
@property(nonatomic,strong)NSString *taxpayer_number;//纳税人识别号
- (void)parseFromDict:(NSDictionary *)dict;
@end
