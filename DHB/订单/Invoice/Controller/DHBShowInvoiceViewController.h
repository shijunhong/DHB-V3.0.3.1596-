//
//  DHBShowInvoiceViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "ShowInvoiceService.h"

@interface DHBShowInvoiceViewController : DHBTableViewController
@property(nonatomic,strong)NSString *titelText;
@property(nonatomic,strong)ShowInvoiceService *service;
@end
