//
//  DHBRegisterViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBRegisterViewController.h"

@interface DHBRegisterViewController()
@property(nonatomic,strong)UIView *statusView;
@end

@implementation DHBRegisterViewController
#pragma mark - getters and setters 
- (UIWebView *)mainWebView{
    if(!_mainWebView){
        _mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20.0f, self.view.frame.size.width, self.view.frame.size.height+Titel_HEIGHT)];
        _mainWebView.delegate = self;
        _mainWebView.scrollView.bounces= NO;
    }
    return _mainWebView;
}

-(UIView *)statusView{
    if (!_statusView)
    {
        _statusView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 20.0f)];
        _statusView.backgroundColor = [UIColor BtnRedBackground_Color];
        [_statusView setHidden:YES];
    }
    return _statusView;
}

#pragma mark - init
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self showBack:YES];
    [self.navigationView setFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, Titel_HEIGHT)];
    [self showBack:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"%@",[NSString stringWithString:[WEBHTTPURL stringByAppendingString:@"reg_role.html?from=ios"]]);
    [self.mainWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[WEBHTTPURL stringByAppendingString:@"reg_role.html?from=ios"]]]];
    [self.view addSubview: self.mainWebView];
    [self.view addSubview:self.statusView];
}


#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.statusView setHidden:NO];
}


-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"dhb"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"&"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        //有参数的
        if([funcStr isEqualToString:@"submit:"])
        {
            [self submit:[arrFucnameAndParameter objectAtIndex:1]];
        }
        //无参数 返回
        if ([funcStr isEqualToString:@"back"])
        {
            [self back];
        }
    }
    return YES;
}

#pragma mark - webView与js交互函数
/**
 *  提交注册
 *
 *  @param str 注册的用户编号
 */
-(void)submit:(NSString *)str {
    [self.delegate RegisterUserId:str];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  返回按钮
 */
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
