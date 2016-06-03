//
//  DHBRechargeMethodViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBRechargeMethodService.h"
#import "DHBRechargeMethodTableViewCell.h"
#import "DHBOfflineRechargeViewController.h"

@interface DHBRechargeMethodViewController : DHBTableViewController<DHBRechargeMethodService_Delegate, DHBRechargeMethodTableViewCell_Delegate>
{
    id firstResponser;
    PayType *curPayType;
}
@property (nonatomic, strong) DHBTipView *tipView;
@property(nonatomic, retain) DHBRechargeMethodService *mainService;
@end
