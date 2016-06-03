//
//  CustomTabBarViewController.m
//  MtabbarS
//
//  Created by lunaticM on 14-5-28.
//  Copyright (c) 2014年 lunaticM. All rights reserved.
//

#import "CustomTabBarViewController.h"

#import "CustomTabBar.h"
#import "NSString+HexColor.h"

@interface CustomTabBarViewController ()<CustomTabBarResourceDelegate, CustomTabBarDelegate>
{
    CustomTabBar* _tabBar;
    NSArray* _tabBarItems;
    UINavigationController* _currentViewController;
}
@end

@implementation CustomTabBarViewController

@synthesize viewdelegate = _viewDelegate;

static NSMutableDictionary* _sSingletons;

+ (void)initialize {
    static dispatch_once_t once;
    dispatch_once(&once, ^ { _sSingletons = [[NSMutableDictionary alloc] init]; });
    [_sSingletons setObject:[[self alloc] init] forKey:(id<NSCopying>)[self class]];
}

+ (id)singleton {
    return [_sSingletons objectForKey:[self class]];
}

- (void)loadView {
    [super loadView];
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

/**
 *  设置tabBar图片文字
 *
 *  @param tabBarItems 字典array
 */
- (void)setupTabBar:(NSArray*)tabBarItems {
    _tabBarItems = tabBarItems;
    CGRect frame = [UIScreen mainScreen].bounds;
    NSUInteger tabItemsCount = [_tabBarItems count];
    
    //自定义高低
    _tabBar = [[CustomTabBar alloc] initWithItemCount:tabItemsCount itemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/[_tabBarItems count], TabBar_HEIGHT) resourceDelegate:self];
    CGRect tabBarFrame = _tabBar.frame;
    tabBarFrame.origin.y = frame.size.height - tabBarFrame.size.height;
    _tabBar.frame = tabBarFrame;
    [_tabBar setTitleColor:HEX_RGB(0xb4b4b4) selectedColor:HEX_RGB(0xfe4600)];
    [self.view addSubview:_tabBar];
    _tabBar.customTabBarDelegate = self;
    [self touchUpInsideItemAtIndex:0];
    //
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xeaeaea)];
    [_tabBar addSubview: lineView];
}

- (void) selectAtIndex:(NSInteger)index{
    [_tabBar selectItemAtIndex:index];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    for (NSDictionary* item in _tabBarItems)
    {
        UIViewController* viewController = [item objectForKey:@"view"];
        if ([viewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController* wrapperViewController = (UINavigationController* )viewController;
            wrapperViewController.visibleViewController.title = title;
        }
        else
        {
            viewController.title = title;
        }
    }
}

- (void)setTabBarItemLabelAsTitle {
    for (NSDictionary* item in _tabBarItems) {
        UIViewController* viewController = [item objectForKey:@"view"];
        NSString* title = [item objectForKey:@"title"];
        if(title == nil) {
            continue;
        }
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* wrapperViewController = (UINavigationController* )viewController;
            wrapperViewController.visibleViewController.title = title;
        }
        else {
            viewController.title = title;
        }
    }
}
- (UIViewController*)currentViewController {
    return _currentViewController;
}
- (void)viewWillAppear:(BOOL)animated {
    //[_currentViewController viewWillAppear:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  //  [_currentViewController viewDidAppear:animated];
    [super viewDidAppear:animated];
}

- (void)updateBadge:(NSNotification *)notification
{
//    if ([ParameterPublic sharedManagered].count_UnRead>0)
//    {
//        UIView* v_badge ;
//        UIImageView* iv_bg;
//        if ([ParameterPublic sharedManagered].count_UnRead < 10)
//        {
//            v_badge = [[UIView alloc]initWithFrame:CGRectMake(50, 5, 15, 15)];
//            iv_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
//        }
//        else
//        {
//            v_badge = [[UIView alloc]initWithFrame:CGRectMake(50, 5, 20, 15)];
//            iv_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 15)];
//        }
//
//        UILabel * lb_num = [[UILabel alloc] initWithFrame:CGRectMake(4.5, 2.5, 10, 10)];
//        lb_num.font = [UIFont systemFontOfSize:10];
//        lb_num.textColor = [UIColor whiteColor];
//        [lb_num setText:[NSString stringWithFormat:@"%d",[ParameterPublic sharedManagered].count_UnRead]];
//        
//        [iv_bg setImage:[UIImage imageNamed:@"xiaox"]];
//        [v_badge addSubview:iv_bg];
//        [v_badge addSubview:lb_num];
//        [_tabBar addBadge:v_badge atIndex:1];
//    }
//    else
//    {
//        [_tabBar removeBadge:1];
//    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateBadge:) name:@"UPDATEBADGENOTIFICATION" object:nil];
    
	// Do any additional setup after loading the view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (_currentViewController) {
        return [_currentViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    else {
        return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
}

#pragma mark - TabBar custom

- (NSString*) titleFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex {
    return [[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"title"];
}

- (UIImage*) imageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex {
    return [UIImage imageNamed:[[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"image"]];
}

- (UIImage*) selectedImageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex {
    return [UIImage imageNamed:[[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"selectedImage"]];
}

- (UIImage*) selectedItemBackgroundImageFor:(CustomTabBar*)tabBar {
    return nil;
}

- (UIImage*) backgroundImage {
    return [UIImage imageWithColor:HEX_RGB(0xf8f8f8) size: CGSizeMake(SCREEN_WIDTH, TabBar_HEIGHT)];
}
#pragma mark - TabBar event
- (void)adjustViewController:(UIViewController*)viewController {
    CGRect frame = viewController.view.frame;
    frame.origin = CGPointZero;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.view.bounds.size.height - _tabBar.frame.size.height;
    viewController.view.frame = frame;
}

- (void) touchUpInsideItemAtIndex:(NSUInteger)itemIndex {
    if (_viewDelegate && [_viewDelegate respondsToSelector:@selector(onTouchUpInsideItemAtIndex:)])
        [_viewDelegate onTouchUpInsideItemAtIndex:itemIndex];
    
    //如果不是特殊界面 按照传统跳转方法  与MrootVC的特殊界面一致
    if (itemIndex != 7) {
        
//        NSString* viewControllerStr = [[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"view"];
//        NSLog_Red(@"viewControllerStr = %@",viewControllerStr);
//        UIViewController *viewController = [[NSClassFromString(viewControllerStr) alloc] init];
//        UINavigationController *nav=  [[UINavigationController alloc]initWithRootViewController:viewController];
//        NSLog_Red(@"className = %@",className);
        UINavigationController *nav = [[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"view"];
        if (_currentViewController == nav) {
            return ;
        }
//        2966
        
        if (_currentViewController) {
            [_currentViewController viewWillDisappear:YES];
            [_currentViewController.view removeFromSuperview];
            [_currentViewController viewDidDisappear:YES];
        }
        
//        if (viewController == nil)
//        {
//            //            Class c = NSClassFromString(viewController.className)
//            NSLog(@"1232131");
//        }

        [self adjustViewController:nav];
        
        nav.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [nav viewWillAppear:YES];
        [self.view insertSubview:nav.viewControllers[0].view belowSubview:_tabBar];
//        [self.view addSubview:nav.viewControllers[0].view];
        
        _currentViewController = nav;
        
        [_tabBar selectItemAtIndex:itemIndex];
    }
    
    
    
    // 1.取出之前的控制器

//    if (nav == nil) {
//        Class c = NSClassFromString([[_tabBarItems objectAtIndex:itemIndex] objectForKey:@"view"].className);
//        UIViewController *vc = [[c alloc] init];
//        vc.view.backgroundColor = kViewBg;
//        
//        nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        if (item.modal) {
//            nav.modalPresentationStyle = UIModalPresentationFormSheet;
//            [self presentViewController:nav animated:YES completion:nil];
//            return;
//        }
    
//        nav.view.autoresizingMask = UIViewAutoresizingNone;
//        [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
//        [self addChildViewController:nav];
//        
//        [_childs setObject:nav forKey:item.className];
//    }
    
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)contex {
    if ([animationID isEqualToString:@"hide"]) {
        _tabBar.hidden = YES;
    }
}

- (void)showTabBar:(Boolean)animated {
    if (!_tabBar.hidden) {
        return ;
    }
    
    UIView* currentView = _currentViewController.view;
    CGRect currentViewFrame = currentView.frame;
    currentViewFrame.size.height -= _tabBar.frame.size.height;
    
    _tabBar.hidden = NO;
    CGRect tabBarFrame = _tabBar.frame;
    tabBarFrame.origin.y -= tabBarFrame.size.height;
    
    if (animated) {
        [UIView beginAnimations:@"show" context:nil]; {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.15];
            [UIView setAnimationDelegate:self];
            
            currentView.frame = currentViewFrame;
            _tabBar.frame = tabBarFrame;
            
        }[UIView commitAnimations];
    }
    else {
        currentView.frame = currentViewFrame;
        _tabBar.frame = tabBarFrame;
        _tabBar.hidden = NO;
    }
}

- (void)hideTabBar:(Boolean)animated {
    if (_tabBar.hidden) {
        return ;
    }
    
    UIView* currentView = _currentViewController.view;
    CGRect currentViewFrame = currentView.frame;   
    currentViewFrame.size.height += _tabBar.frame.size.height;
    
    CGRect tabBarFrame = _tabBar.frame;
    tabBarFrame.origin.y += tabBarFrame.size.height;
    
    if (animated) {
        [UIView beginAnimations:@"hide" context:nil]; {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.15];
            [UIView setAnimationDelegate:self];
            
            currentView.frame = currentViewFrame;
            _tabBar.frame = tabBarFrame;
            
        }[UIView commitAnimations];
    }
    else {
        currentView.frame = currentViewFrame;
        _tabBar.frame = tabBarFrame;
        _tabBar.hidden = YES;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
