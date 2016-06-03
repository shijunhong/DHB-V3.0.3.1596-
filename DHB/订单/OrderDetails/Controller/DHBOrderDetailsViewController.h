//
//  DHBOrderDetailsViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "DHBOrderAttachmentViewController.h"
#import "OrderDetailsService.h"
#import "DHBPaymentRecordDetailsViewController.h"

@interface DHBOrderDetailsViewController : DHBCommonViewController
@property(nonatomic,strong)OrderDetailsService *orderDetailsService;
@end
