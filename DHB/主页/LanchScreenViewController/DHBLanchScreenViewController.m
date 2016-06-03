//
//  DHBLanchScreenViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/25/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLanchScreenViewController.h"
#import "DHBLoginViewController.h"

@implementation DHBLanchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [imageView setImage: [UIImage imageNamed: @"lang.png"]];
//    [self.view addSubview: imageView];
    [self performSelector: @selector(transformPage) withObject: nil afterDelay: 2.5f];
}

- (void)transformPage{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults objectForKey: @"skey"]){
        ///未登录状态下，跳转至登录页面
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController =[[UINavigationController alloc]initWithRootViewController:[[DHBLoginViewController alloc] init]];
    }
    else{
        //已设置说明不是第一次显示主页
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[MainPageViewController alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
