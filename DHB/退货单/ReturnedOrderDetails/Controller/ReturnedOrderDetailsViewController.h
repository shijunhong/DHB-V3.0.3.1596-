//
//  ReturnedOrderDetailsViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBReturnedDetailsService.h"
#import "DHBReturnedDetailsTableViewCell.h"
#import "DHBReturnedDetailsFooterView.h"
#import "DeliveryMethodViewController.h"
#import "DHBOrderAttachmentViewController.h"
#import "DHBOrderAlertView.h"

@interface ReturnedOrderDetailsViewController : DHBTableViewController<DHBReturnedDetailsService_Delegate, DHBReturnedDetailsFooterView_Delegate>
@property(nonatomic, retain) DHBReturnedDetailsService *mainService;
@property(nonatomic, retain) NSArray *dataArray;
@property(nonatomic, retain) DHBReturnedDetailsFooterView *footerView;
@end
