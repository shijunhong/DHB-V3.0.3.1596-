//
//  DHBAboutViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBAboutService.h"
#import "DHBAboutTableViewCell.h"
#import "DHBAboutBottomView.h"
#import <UMengSocial/UMSocial.h>
#import "DHBShareView.h"

@interface DHBAboutViewController : DHBTableViewController<DHBAboutService_Delegate,UMSocialUIDelegate, DHBShareView_Delegate>
@property(nonatomic, retain) DHBAboutService *mainService;
@property(nonatomic, retain) DHBAboutBottomView *bottomView;
@property(nonatomic, retain) DHBShareView *shareMainView;
@end
