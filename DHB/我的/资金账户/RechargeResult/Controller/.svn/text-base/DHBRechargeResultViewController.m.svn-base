//
//  DHBRechargeResultViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBRechargeResultViewController.h"
#import "DHBOrderListViewController.h"
#import "DHBFinanceAccountViewController.h"

@implementation DHBRechargeResultViewController
#pragma mark - init
- (DHBRechargeResultMainView *)mainView{
    if(!_mainView){
        _mainView = [[DHBRechargeResultMainView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
        [_mainView setDelegate: self];
    }
    return _mainView;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTabBar: NO];
    if(self.order){
        [self showTitel: YES andTitelText: @"支付成功"];
    }
    else{
        [self showTitel: YES andTitelText: @"充值成功"];
    }
    [self setEdgesForExtendedLayout: UIRectEdgeNone];
    [self.view addSubview: self.mainView];
    [self.mainView updateMainViewDate: self.order?YES:NO];
}

#pragma mark - DHBRechargeResultMainView_Delegate
- (void)rechargeResultMainView_DidBackButtonClick:(UIButton *)button{
    if (self.order)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil userInfo:@{@"order":self.order}];
        [self.tabBarController setSelectedIndex:1];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        for (UIViewController* controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[DHBFinanceAccountViewController class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
