//
//  DHBPayOrderViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayOrderViewController.h"

@interface DHBPayOrderViewController ()

@end

@implementation DHBPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"提交成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
