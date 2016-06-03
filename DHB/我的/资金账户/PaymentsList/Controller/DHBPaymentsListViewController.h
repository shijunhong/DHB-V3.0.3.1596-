//
//  DHBPaymentsListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBPaymentsListService.h"
#import "DHBPaymentsTableViewCell.h"
#import "DHBPaymentsSiftingService.h"
#import "DHBPaymentsSiftingView.h"
#import "CDRTranslucentSideBar.h"
#import "DHBPaymentsOptionView.h"
#import "DHBPaymentsDetailsViewController.h"

@interface DHBPaymentsListViewController : DHBTableViewController<DHBPaymentsListService_Delegate, DHBPaymentsSiftingService_Delegate, CDRTranslucentSideBarDelegate, DHBPaymentsSiftingView_Delegate, DHBPaymentsOptionView_Delegate>
{
    BOOL isGetSiftingData;
}
@property(nonatomic, retain) DHBPaymentsListService *mainService;
@property(nonatomic, retain) DHBPaymentsSiftingService *siftingService;
@property(nonatomic, retain) UIButton *filterButton;
@property (strong, nonatomic)CDRTranslucentSideBar *siftingViewController;
@property(nonatomic, retain) DHBPaymentsSiftingView *siftingMainView;
@property (strong, nonatomic)CDRTranslucentSideBar *optionViewController;
@property(nonatomic, retain) DHBPaymentsOptionView *optionMainView;
@property(nonatomic, retain) DHBTipView *tipView;
@property (nonatomic,strong) UIView *maskView;
@end
