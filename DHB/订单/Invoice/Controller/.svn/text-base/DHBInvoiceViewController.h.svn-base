//
//  DHBInvoiceViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/11.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "UserInformationModuleDTO.h"
@class DHBInvoiceViewController;
@protocol DHBInvoiceViewControllerDelegate <NSObject>

-(void)DHBInvoiceViewController:(DHBInvoiceViewController*)invoiceController userInformation:(UserInformationModuleDTO*)userInformation;

@end

@interface DHBInvoiceViewController : DHBCommonViewController
@property(nonatomic ,strong)UserInformationModuleDTO *userInformation;
@property(weak ,nonatomic)id<DHBInvoiceViewControllerDelegate>delegate;
@end
