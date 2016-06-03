//
//  DHBMemberCommonViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMemberCommonViewController.h"

@implementation DHBMemberCommonViewController

-(UIView *)navigationView{
    if (!_navigationView)
    {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, Titel_HEIGHT)];
        [_navigationView setBackgroundColor:[[UIColor NavBack_Red_Color] colorWithAlphaComponent:1.0f]];
    }
    return _navigationView;
}

-(UILabel *)titel_lb{
    if (!_titel_lb)
    {
        _titel_lb = [[UILabel alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - 100.0f) / 2.0f, 20.0f + (Titel_HEIGHT - 50.0f) / 2.0f, 100.0f, 30.0f)];
        [_titel_lb setTextAlignment:NSTextAlignmentCenter];
        [_titel_lb setFont:[UIFont systemFontOfSize:18]];
        [_titel_lb setTextColor: [UIColor whiteColor]];
    }
    return _titel_lb;
}

- (UIButton *)backButton{
    if(!_backButton){
        _backButton = [[UIButton alloc] initWithFrame: CGRectMake(15.0f, 20.0f + (Titel_HEIGHT - 50.0f) / 2.0f, 30.0f, 30.0f)];
        [_backButton setImage: [UIImage imageNamed: @"back_normal"] forState: UIControlStateNormal];
        [_backButton addTarget: self action: @selector(backButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(void)viewWillAppear:(BOOL)animated{
    for(UIView *view in [self.navigationView subviews]){
        if(view){
            [view removeFromSuperview];
        }
    }
    [self loadNavigationView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        [self setEdgesForExtendedLayout:  UIRectEdgeNone];
}

- (void)loadNavigationView{
    ////navigation
    [self.navigationController.navigationBar addSubview:self.navigationView];
    //去掉nav 下面的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    ///返回按钮
    [self.navigationItem setHidesBackButton: YES];
    [self.navigationView addSubview: self.backButton];
    [self.navigationView addSubview: self.titel_lb];
}

#pragma mark - 返回按钮
-(void)backButtonClick:(UIButton*)sender{
    if(self.isRoot){
        [self dismissViewControllerAnimated: YES completion: nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - 设置标题
- (void)setTitle:(NSString *)title{
//    [super setTitle: title];
    [self.titel_lb setText:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
