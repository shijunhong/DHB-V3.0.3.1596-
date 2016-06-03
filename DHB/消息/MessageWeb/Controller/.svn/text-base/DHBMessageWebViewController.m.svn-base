//
//  DHBMessageWebViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageWebViewController.h"

@interface DHBMessageWebViewController ()

@end

@implementation DHBMessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"详情"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+Titel_HEIGHT)];
    NSString *skey = ([[NSUserDefaults standardUserDefaults] objectForKey: @"skey"] == nil ? FREE_ACCOUNT_SKEY : [[NSUserDefaults standardUserDefaults] objectForKey: @"skey"]);
    NSString *url = [NSString stringWithFormat:@"%@message_system_info.html?from=ios&id=%@&a=%@&skey=%@",WEBHTTPURL,self.ids,self.action,skey];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
    
    //    webView.delegate = self;
    //    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.0.201:8888/dhb2.0mobile/test.html"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
