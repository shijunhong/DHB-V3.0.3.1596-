//
//  DHBCommonNavigationController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "NavigationController.h"
#import "DHBFindPasswordViewController.h"
#import "DHBRegisterViewController.h"

typedef enum {
    kFindPassowrdPage = 0,
    kRegisterPage = 1
}RootView_Type;

@interface DHBCommonNavigationController : UINavigationController
@property(nonatomic, assign) RootView_Type pageType;
@end
