//
//  NavigationController.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar lt_setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setNavView:(UIView*)view{
    [self.navigationBar removeAllSubviews];
    [self.navigationBar addSubview:view];
}




@end
