//
//  ShowInvoiceService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "ShowInvoiceService.h"

@implementation ShowInvoiceService

-(NSMutableArray *)invoicelist{
    if (!_invoicelist)
    {
        if ([self.invoice.invoice_type isEqualToString:@"P"])
        {
            _invoicelist = [NSMutableArray arrayWithArray:@[@{@"name":@"发票抬头",@"value":self.invoice.invoice_title},
                                                            @{@"name":@"发票内容",@"value":self.invoice.invoice_content}]];

        }
        else
        {
            _invoicelist = [NSMutableArray arrayWithArray:@[@{@"name":@"发票抬头",@"value":self.invoice.invoice_title},
                                                         @{@"name":@"发票内容",@"value":self.invoice.invoice_content},
                                                         @{@"name":@"开户银行",@"value":self.invoice.bank},
                                                         @{@"name":@"银行账号",@"value":self.invoice.bank_account},
                                                         @{@"name":@"纳说人识别号",@"value":self.invoice.taxpayer_number}]];
            
        }
    }
    return _invoicelist;
}


- (void)queryInvoiceData{
    
}
@end
