//
//  MainPageViewController.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "MainPageViewController.h"
#import "NavigationController.h"

#import "DHBHomePageViewController.h"
#import "DHBGoodsViewController.h"
#import "DHBMessageViewController.h"
#import "DHBOrderListViewController.h"
#import "MemberCenterViewController.h"
#import "DHBAlertView.h"

@interface MainPageViewController ()
{
    DHBHomePageViewController *homePageView;
    DHBGoodsViewController *productView;
    DHBOrderListViewController *orderView;
    DHBMessageViewController *messageView;
    UIViewController *mineView;
}
@end

@implementation MainPageViewController
#pragma mark - init
- (UIImageView *)messageTipView{
    if(!_messageTipView){
        CGFloat origin_x = SCREEN_WIDTH * 3.0f / 4.0f - Multiple * 39.0f;
        CGFloat origin_y = 3.0f;
        _messageTipView = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, origin_y, 12.0f, 12.0f)];
        [_messageTipView setBackgroundColor: [UIColor clearColor]];
        [_messageTipView setImage: [UIImage imageNamed:@"menu_news"]];
    }
    return _messageTipView;
}

- (UIView *)tabBarMaskView{
    if(!_tabBarMaskView){
        _tabBarMaskView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, TabBar_HEIGHT)];
        [_tabBarMaskView setBackgroundColor: [[UIColor alloc] initWithWhite: 0.0f alpha: 0.5f]];
    }
    return _tabBarMaskView;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //页面控件初始化
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMsgtipView) name:@"showMsgTipView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenMsgtipView) name:@"hiddenMsgTipView" object:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    ///销毁监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name: @"showMsgTipView" object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: @"hiddenMsgTipView" object: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initView{
    //首页
    homePageView = [[DHBHomePageViewController alloc]init];
    //订单
    orderView = [[DHBOrderListViewController alloc] init];
    //消息
    messageView = [[DHBMessageViewController alloc] init];
    //我的
    mineView = [[MemberCenterViewController alloc]init];
    UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:homePageView];
    firstNav.title = L(@"商品");
    firstNav.tabBarItem.image =[[UIImage imageNamed:@"ic_product_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    firstNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_product_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [firstNav.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0.0f, -4.0f)];
    [firstNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TextRed_Color],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    UINavigationController *secondNav = [[UINavigationController alloc]initWithRootViewController:orderView];
    secondNav.title = L(@"订单");
    secondNav.tabBarItem.image =[[UIImage imageNamed:@"ic_order_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_order_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [secondNav.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0.0f, -4.0f)];
    [secondNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TextRed_Color],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    UINavigationController *thirdNav = [[UINavigationController alloc]initWithRootViewController:messageView];
    thirdNav.title = L(@"消息");
    thirdNav.tabBarItem.image =[[UIImage imageNamed:@"ic_news_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_news_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [thirdNav.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0.0f, -4.0f)];
    [thirdNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TextRed_Color], NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    UINavigationController *fourthtNav = [[UINavigationController alloc]initWithRootViewController:mineView];
    fourthtNav.title = L(@"我的");
    [fourthtNav.navigationBar setBarStyle: UIBarStyleBlackOpaque];
    fourthtNav.tabBarItem.image = [[UIImage imageNamed:@"ic_user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    [fourthtNav.tabBarItem setImageInsets: UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    fourthtNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_user_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [fourthtNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TextRed_Color],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    [fourthtNav.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0.0f, -4.0f)];
    ////调整tabbar的样式
    NSArray *controllers = [NSArray arrayWithObjects:firstNav,secondNav,thirdNav,fourthtNav, nil];
    self.viewControllers = controllers;
    [self.tabBar setBarStyle: UIBarStyleBlack];
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0){
        [self.tabBar setBarTintColor: HEX_RGB(0xf8f8f8)];
    }
    else{
        [self.tabBar setBackgroundColor: HEX_RGB(0xf8f8f8)];
    }
    ///分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdedede)];
    [lineView.layer setShadowOpacity: 0.3f];
    [lineView.layer setShadowOffset: CGSizeMake(0.0f, -3.0f)];
//    [lineView.layer setShadowColor: HEX_RGB(0xe5e4e9).CGColor];
    [self.tabBar addSubview: lineView];
    [self setDelegate: self];
    ///消息提示视图
    [self.tabBar addSubview: self.messageTipView];
    [self.messageTipView setHidden: YES];
}


- (void)makeTabBarHidden:(BOOL)hide {
    if ( [self.view.subviews count] < 2 )
        return;
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    [contentView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    //    NSLog(@"%f,%f,%f,%f", self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    if ( hide ){
        WS(weakSelf);
        ///先调整contentView的高度，解决tabBar动画的时候出现灰条
        contentView.height = SCREEN_HEIGHT + TabBar_HEIGHT;
        [UIView animateWithDuration: 0.3f animations: ^{
            weakSelf.tabBar.top = SCREEN_HEIGHT;
        } completion: ^(BOOL finish){
            ///当TabBar隐藏之后，需要将UITabBarController的View的高度调高49.0f,不然在viewcontroller底部区域的视图不能够点击
            weakSelf.view.height = SCREEN_HEIGHT + TabBar_HEIGHT;
//            NSLog(@"%f,%f,%f,%f", self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
        }];
    }
    else{
        WS(weakSelf);
        ///当显示TabBar的时候，需要将UITabBarController的View高度恢复到初始状态，不然视图位置会变形
        ///(注：此时无须再调整contentView的高度，因为设置UITabBarController的View高度的时候，已经自动设置了contentView的高度)
        weakSelf.view.height = SCREEN_HEIGHT;
        [UIView animateWithDuration: 0.3f animations: ^{
            weakSelf.tabBar.top = SCREEN_HEIGHT - TabBar_HEIGHT;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)makeTabBarMask:(BOOL) isMask
{
    [self.tabBarMaskView setHidden: !isMask];
    [self.tabBar addSubview: self.tabBarMaskView];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

}

-(void)showMsgtipView{
    [self.messageTipView setHidden: NO];
}

-(void)hiddenMsgtipView{
    [self.messageTipView setHidden: YES];
}

@end
