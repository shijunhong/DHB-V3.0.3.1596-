//
//  DHBCommonViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/16.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "MainPageViewController.h"
#import "DHBSearchViewController.h"
#import "DHBShoppingViewController.h"
#import "JSBadgeView.h"
#import "DHBSupplierListViewController.h"
#import "DHBSupplierListService.h"
#import "DHBNotificationManager.h"

@interface DHBCommonViewController () <DHBSupplierListService_Delegate>
@property(strong, nonatomic)DHBSupplierListService *supplierService;///供应商服务
@property(strong, nonatomic)UIView *backGroundView;//蒙层
@property(nonatomic, copy) void(^onBackgorundViewClick)();//点击蒙层回调
@end

@implementation DHBCommonViewController
#pragma mark - lazyload
- (DHBSupplierListService *)supplierService{
    if(!_supplierService){
        _supplierService = [[DHBSupplierListService alloc] init];
        [_supplierService setDelegate: self];
    }
    return _supplierService;
}

- (UIView *)backGroundView{
    if(!_backGroundView){
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationView.bounds.size.width, self.navigationView.bounds.size.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _backGroundView.opaque = NO;
        [_backGroundView setUserInteractionEnabled: YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(navigationBarMaskViewClick)];
        [_backGroundView addGestureRecognizer: tap];
    }
    return _backGroundView;
}


-(DHBNavBarView *)navigationView{
    if (!_navigationView)
    {
        _navigationView = [[DHBNavBarView alloc] initWithFrame:CGRectMake(0.0f,-20.0f, SCREEN_WIDTH, CGRectGetHeight(self.navigationController.navigationBar.bounds)+20.0f)];
        [_navigationView setBackgroundColor:[[UIColor NavBack_Red_Color] colorWithAlphaComponent:1.0f]];
    }
    return _navigationView;
}


#pragma mark - Controllerlife
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if([[ParameterPublic sharedManagered] observationInfo] && isShowShoppingCar){
        ///只有显示了购物车的界面（即添加l对购物车数量的监听的页面），才能够对其移除观察者，不然程序将会崩溃
        [[ParameterPublic sharedManagered] removeObserver:self forKeyPath:@"cart_count"];
    }
}

- (id)init
{
    self = [super init];
    if (self){
    }
    return self;
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitelView];
    //添加购物车图标
    [self.navigationView.shoppingCar_img addSubview: [[ParameterPublic sharedManagered] shoppingCarBadgeView]];
    ///键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //根视图
    if ([self.navigationController.childViewControllers count] == 1 && self.tabBarController)
    {
//        //读取消息
//        [[DHBNotificationManager sharedInstance].service queryMessageTip];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    KeyboardManager.is_shwoCMview = NO;
    [[DHBAlertView sharedManagered] setIsShow:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    ///销毁监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIKeyboardWillHideNotification object: nil];
//    [[DHBAlertView sharedManagered] close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    //隐藏系统默认返回按钮
    [self.navigationItem setHidesBackButton: YES];
    [self.navigationController.navigationItem setHidesBackButton: YES];
    KeyboardManager;
    //添加足有滑动手势
    [self bindSwipe];
    /////KVO
//    [[ParameterPublic sharedManagered] addObserver:self forKeyPath:@"cart_count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View initTitelView
- (void)initTitelView {
    // Do any additional setup after loading the view.
//    [(NavigationController*)self.navigationController setNavView:self.navigationView];
//    [self.navigationController.navigationBar removeAllSubviews];
    //push
    [self.navigationController.navigationBar addSubview:self.navigationView];
    //去掉nav 下面的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

}

-(void)showVender:(BOOL)isShow andVenderName:(NSString*)name{
    [self.navigationView.left_lb setHidden:!isShow];
    [self.navigationView.left_tap addTarget:self action:@selector(openSuppierList)];
    if(IsNilOrNull(name))
       [self.navigationView.left_lb setText: [[ParameterPublic sharedManagered] company_name]];
    else
        [self.navigationView.left_lb setText: name];
}

-(void)showShoppingCar:(BOOL)isShow{
    [self.navigationView.shoppingCar_btn addTarget:self action:@selector(shoppingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    isShowShoppingCar = isShow;
    if (isShow)
    {
        /////KVO(当显示购物车的时候，对购物车数量进行监听)
        [[ParameterPublic sharedManagered] addObserver:self forKeyPath:@"cart_count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [self AddShoppingCarBadgeNum];
    }
    [self.navigationView.shoppingCar_btn setHidden:!isShow];
    [self.navigationView.shoppingCar_img setHidden:!isShow];
}


-(void)showBack:(BOOL)isShow{
    [self.navigationView.back_btn setHidden:!isShow];
    [self.navigationView.back_btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showTabBar:(BOOL)isShow{
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[MainPageViewController class]])
    {
        MainPageViewController *root = (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        if (isShow)
        {
            [root makeTabBarHidden: NO];
        }
        else
        {
            //        [root hideTabBar:YES];
            [root makeTabBarHidden:YES];
            //        self.hidesBottomBarWhenPushed = YES;
        }
    }
}

-(void)showTitel:(BOOL)isShow andTitelText:(NSString*)text{
    [self.navigationView.center_lb setHidden:!isShow];
    [self.navigationView.center_lb setText:text];
}

-(void)showBackgroundView:(BOOL)isShow onClick:(void(^)())callback {
    self.onBackgorundViewClick = callback;
    if (isShow)
    {
        [[[UIApplication sharedApplication] keyWindow] addSubview: self.backGroundView];
        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront: self.backGroundView];
    }
    else
    {
        if (self.backGroundView)
        {
            [self.backGroundView removeFromSuperview];
            [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        }
    }
}

#pragma mark - 点击导航栏的遮挡视图
- (void)navigationBarMaskViewClick{
    ////此方法是为了解决，点击backgroundView的时候，无法隐藏侧滑栏的问题
    if(self.onBackgorundViewClick) self.onBackgorundViewClick();
}

#pragma mark - ButtonAction
#pragma mark 搜索按钮点击事件
-(void)searchAction:(UIButton*)sender{
    DHBSearchViewController *search = [[DHBSearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:NO];
//    [self.navigationController pushViewController:search animatedWithTransition:UIViewAnimationTransitionFlipFromLeft];
}

#pragma mark 返回按钮点击事件
-(void)backAction:(UIButton*)sender{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //由子类响应返回按钮点击事件
    SEL selector = NSSelectorFromString(@"viewControllerDidClickBackButton");
    if([self respondsToSelector: selector]){
        objc_msgSend(self, selector);
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES ];
    }
}

#pragma mark 购物车按钮点击事件
-(void)shoppingCarAction:(UIButton*)sender{
    DHBShoppingViewController *shopping = [[DHBShoppingViewController alloc] init];
    [self.navigationController pushViewController:shopping animated:NO];
}


#pragma mark - 是否登录
- (BOOL)isLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey: @"skey"] ? YES : NO;
}

#pragma mark KVO Methods addShoppingCar 添加购物车数量
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"cart_count"])
    {
        if (!self.navigationView.shoppingCar_btn.hidden)
        {
            [self AddShoppingCarBadgeNum];
        }
    }
}

#pragma mark 添加购物车上的 数字
-(void)AddShoppingCarBadgeNum{
    NSInteger mun = [[ParameterPublic sharedManagered] cart_count];
//    NSLog_Red(@"num = %ld", (long)mun);
    if (mun > 0)
    {
        [[[ParameterPublic sharedManagered] shoppingCarBadgeView] setHidden:NO];
        [[[ParameterPublic sharedManagered] shoppingCarBadgeView] setBadgeText: [NSString stringWithFormat:@"%ld",(long)mun]];
    }
    else
    {
        [[[ParameterPublic sharedManagered] shoppingCarBadgeView] setHidden:YES];
    }
}

#pragma mark - /* 添加轻扫手势*/
- (void)bindSwipe {
    //向右轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    [self.view addGestureRecognizer:recognizer];
    
    //向左轻扫手势
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    [self.view addGestureRecognizer:recognizer];
}
#pragma mark - /* 手势执行方法*/
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    //根据轻扫方向，进行不同控制
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
//            NSLog_Red(@"Right");
            if (!self.navigationView.back_btn.hidden)
            {
                [self backAction:nil];
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            break;
        }
        case UISwipeGestureRecognizerDirectionUp: {
            break;
        }
        case UISwipeGestureRecognizerDirectionDown: {
            break;
        }
    }
}

- (void)keyBoardWillShow:(NSNotification *)note{
}

- (void)keyBoardWillHide:(NSNotification *)note{
}


#pragma mark - 打开供应商列表
- (void)openSuppierList{
    //先查询供应商列表数量是否大于1，如果大于1才跳转至供应商列表
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [self.supplierService setSkey: [userDefault stringForKey: @"skey"]];
    [self.supplierService querDataList];
}

#pragma mark - DHBSupplierListService_Delegate
- (void)DHBSupplierListService_Compelete:(id)service isSueccess:(BOOL)isSuccess{
    if(isSuccess){
        self.supplierService = service;
//        NSLog(@"%lu", (unsigned long)[[self.supplierService dataArray] count]);
        if([[self.supplierService dataArray] count] > 1){
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            if([userDefault stringForKey: @"skey"]){
                DHBSupplierListViewController *suppierVC = [[DHBSupplierListViewController alloc] init];
                [suppierVC.mainService setSkey: [userDefault stringForKey: @"skey"]];
                [self presentViewController: suppierVC animated: YES completion: nil];
            }
        }
    }
}

#pragma mark - 显示无网视图
-(void)showNoNetView{
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:view];
    view.sd_layout.topSpaceToView(self.view,0.0f).leftSpaceToView(self.view,0.0f).rightSpaceToView(self.view,0.0f).bottomSpaceToView(self.view,0.0f);
}


@end
