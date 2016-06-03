//
//  DHBNotificationManager.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBNotificationManager.h"
#import "MainPageViewController.h"
#import "DHBOrderDetailsViewController.h"
#import "ParameterPublic.h"
#import "DHBPaymentsListViewController.h"
#import "ReturnedOrderDetailsViewController.h"
#import "DHBMessageWebViewController.h"
#import "DHBMessageContentViewController.h"
#import "DHBSupplierListViewController.h"

@interface DHBNotificationManager()

@end

@implementation DHBNotificationManager

-(MessageListService *)service{
    if (!_service)
    {
        _service= [[MessageListService alloc] init];
    }
    return _service;
}

+(DHBNotificationManager *)sharedInstance
{
    static DHBNotificationManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DHBNotificationManager alloc]init];
    });
    return shareInstance;
}


-(void)NotificationStartPush{
    if (self.userInfo)
    {
        NSDictionary *custom = [NSJSONSerialization JSONObjectWithData:[[self.userInfo objectForKey:@"custom"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        [self pushCustom:custom isPush:YES];
        TT_RELEASE_SAFELY(self.userInfo);
    }
}


-(void)pushCustom:(NSDictionary*)custom isPush:(BOOL)is_push{
    NSInteger company_id = [[custom EncodeNumberFromDicWithKey:@"company_id"] integerValue];
    NSString *model = [custom EncodeStringFromDicWithKey:@"model"];
    NSString *ids = [custom EncodeStringFromDicWithKey:@"id"];
    if ([model isEqualToString:@"order"])//订单详情
    {
        if (is_push)
        {
            DHBOrderDetailsViewController *order = [[DHBOrderDetailsViewController alloc] init];
            order.orderDetailsService.orders_id = ids;
            [[self selectNavigationController] pushViewController:order animated:YES];
        }
        else
        {
            [self.service queryMessageTip];
        }
    }
    else if ([model isEqualToString:@"finance"])//收支明细列表
    {
        if (is_push)
        {
            DHBPaymentsListViewController *payments = [[DHBPaymentsListViewController alloc] init];
            [[self selectNavigationController] pushViewController:payments animated:YES];
        }
    }
    else if ([model isEqualToString:@"returns"])//退单详情
    {
        if (is_push)
        {
            ReturnedOrderDetailsViewController *returns = [[ReturnedOrderDetailsViewController alloc] init];
            returns.mainService.returns_id = ids;
            [[self selectNavigationController] pushViewController:returns animated:YES];
        }
        else
        {
            [self.service queryMessageTip];
        }
    }
    else if ([model isEqualToString:@"affiche_notice"])//公告详情
    {
        if (is_push)
        {
            if (company_id == [[ParameterPublic sharedManagered] company_id])//推送公告信息在当前的供货商下
            {
                DHBMessageWebViewController *messageWeb = [[DHBMessageWebViewController alloc] init];
                messageWeb.action = @"msgAfficheContent";
                messageWeb.ids = ids;
                [[self selectNavigationController] pushViewController:messageWeb animated:YES];
            }
            else
            {
                //不在当前的供货商下(跳转到供货商选择页面)
                DHBSupplierListViewController *supplier = [[DHBSupplierListViewController alloc] init];
                [supplier.mainService setSkey: [[NSUserDefaults standardUserDefaults] stringForKey: @"skey"]];
                supplier.company_id = company_id;
                [[self selectNavigationController] presentViewController: supplier animated: YES completion: nil];
            }
        }
        else
        {
            [self.service queryMessageTip];
        }
    }
    else if ([model isEqualToString:@"msg_post"])//留言咨询详情
    {
        if (is_push)//前台运行
        {
            DHBMessageContentViewController *messageContent = [[DHBMessageContentViewController alloc] init];
            messageContent.service.post_title_id = ids;
            [[self selectNavigationController] pushViewController:messageContent animated:YES];
        }
        else
        {
            [self.service queryMessageTip];
        }
    }
    
}

-(UINavigationController *)selectNavigationController{
    MainPageViewController *controller =  (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    (UINavigationController*)[[controller childViewControllers] objectAtIndex:controller.selectedIndex];
//    (UINavigationController*)[[controller childViewControllers] objectAtIndex:0];
    return (UINavigationController*)[[controller childViewControllers] objectAtIndex:controller.selectedIndex];
}

@end
