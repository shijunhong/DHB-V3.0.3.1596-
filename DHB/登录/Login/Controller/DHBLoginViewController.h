//
//  DHBLoginViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "DHBLoginMainView.h"
#import "DHBMemberService.h"
#import "MainPageViewController.h"
#import "DHBCommonNavigationController.h"
#import "AppDelegate.h"
#import "DHBSupplierListViewController.h"

@interface DHBLoginViewController : DHBCommonViewController<DHBLoginMainViewDelegate, DHBMemberServiceDelegate,DHBRegisterViewControllerDelegate>
{
    BOOL isShowRecord;
    BOOL isDefaulAccount;
    BOOL isViewLoad;
}
@property (nonatomic, strong) DHBLoginMainView *mainView;
@property (nonatomic, strong) DHBMemberService *memberService;
@property (nonatomic, strong) DHBTipView *tipView;
@property (nonatomic, strong) NSArray *recordArray;
@end
