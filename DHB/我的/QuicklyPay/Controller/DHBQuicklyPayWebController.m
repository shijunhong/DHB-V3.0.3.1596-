//
//  DHBQuicklyPayWebController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBQuicklyPayWebController.h"
#import "DHBRechargeResultViewController.h"

@interface DHBQuicklyPayWebController ()

@end

@implementation DHBQuicklyPayWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super.navigationController setNavigationBarHidden:YES animated:NO];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20.0f, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *url;
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *skey = ([userdefaults objectForKey: @"skey"] == nil ? FREE_ACCOUNT_SKEY : [userdefaults objectForKey: @"skey"]);
    NSDictionary *dic;
    switch (self.payType)
    {
        case LOGIN:
        {
            dic = @{@"skey":skey};
            url = [NSString stringWithFormat:@"yijifu.html?from=ios&c=QuickApi&a=goLogin&val=%@",[[dic toJSONData] URLEncoding]];
        }
            break;
        case REGISTER:
        {
            dic = @{@"skey":skey};
            url = [NSString stringWithFormat:@"yijifu.html?from=ios&c=QuickApi&a=qftSetAccount&val=%@",[[dic toJSONData] URLEncoding]];
        }
            break;
        case PAY:
        {
             dic = @{@"skey":skey,
                     @"orders_num":self.order.orders_num?self.order.orders_num:@"",
                     @"amount":self.amount};
            url = [NSString stringWithFormat:@"yijifu.html?from=ios&c=QuickApi&a=quickPay&val=%@",[[dic toJSONData] URLEncoding]];
        }
            break;
        default:
            break;
    }
//    NSLog_Red(@"%@",[WEBHTTPURL stringByAppendingString:url]);
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[WEBHTTPURL stringByAppendingString:url]]]];
    webView.scrollView.bounces= NO;
    [self.view addSubview: webView];
}

- (void)initTitelView {
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:HEX_RGB(0x5aa42d)];
    [self.view addSubview: view];
    view.sd_layout.topSpaceToView(self.view,0.0f).leftSpaceToView(self.view,0.0f).rightSpaceToView(self.view,0.0f).heightIs(20.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if([funcStr isEqualToString:@"back:"])
        {
            [self back:[arrFucnameAndParameter objectAtIndex:1]];
        }
    }
    return YES;
}


-(void)back:(NSString *)str{
    if (self.payType == PAY)
    {
        if ([str isEqualToString:@"true"])
        {
            DHBRechargeResultViewController *rechargeResult = [[DHBRechargeResultViewController alloc] init];
            rechargeResult.order = self.order;
            rechargeResult.mainView.amount = self.amount;
            rechargeResult.mainView.type = self.curPayType;
            [super.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:rechargeResult animated:YES];
        }
        else
        {
            [super.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
