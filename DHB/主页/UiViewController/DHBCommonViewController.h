//
//  DHBCommonViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/16.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "NavigationController.h"
#import "DHBNavBarView.h"
@interface DHBCommonViewController : UIViewController
{
    BOOL isShowShoppingCar; ///是否显示了购物车(用于控制购物车数量KVO的监听和释放)
}
@property(strong, nonatomic)DHBNavBarView *navigationView;//nav视图

- (void)initTitelView;
/* 是否展示TabBar*/
-(void)showTabBar:(BOOL)isShow;
/* 是否展示titel_lb*/
-(void)showTitel:(BOOL)isShow andTitelText:(NSString*)text;
/* 是否展示卖家名称*/
-(void)showVender:(BOOL)isShow andVenderName:(NSString*)name;
/* 是否展示购物车*/
-(void)showShoppingCar:(BOOL)isShow;
/* 是否展示返回*/
-(void)showBack:(BOOL)isShow;
/* nav蒙层*/
-(void)showBackgroundView:(BOOL)isShow onClick:(void(^)())callback;
/*无网络视图*/
-(void)showNoNetView;

/* 返回键 调用*/
-(void)backAction:(UIButton*)sender;

/* 是否登录 */
- (BOOL)isLogin;

/* 键盘显示*/
- (void)keyBoardWillShow:(NSNotification *)note;
/* 键盘隐藏*/
- (void)keyBoardWillHide:(NSNotification *)note;

@end
