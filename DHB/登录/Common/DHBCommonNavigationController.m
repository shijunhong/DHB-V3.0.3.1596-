//
//  DHBCommonNavigationController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonNavigationController.h"

@implementation DHBCommonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    switch(self.pageType){
        case 0:{
            DHBFindPasswordViewController *findPasswordVC = [[DHBFindPasswordViewController alloc] init];
            [findPasswordVC setIsRoot: YES];
            [self pushViewController: findPasswordVC animated: YES];
            break;
        }
        case 1:{
            DHBRegisterViewController *registerVC = [[DHBRegisterViewController alloc] init];
//            [registerVC setIsRoot: YES];
            [self pushViewController: registerVC animated: YES];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
