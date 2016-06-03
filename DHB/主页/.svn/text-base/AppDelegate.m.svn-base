//
//  AppDelegate.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import <UMengMessage/UMessage.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "DHBLoationManager.h"
#import "DHBLanchScreenViewController.h"
#import "DHBLoginViewController.h"
/********友盟分享组件******/
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/UMSocialWechatHandler.h>
#import <UMengSocial/UMSocialQQHandler.h>
#import <UMengSocial/UMSocialSinaSSOHandler.h>
#import "RealReachability.h"
#import "MobClick.h"
#import "DHBUploadImage.h"
#import "DHBUploadAttachmentRequest.h"
/********支付宝组件******/
#import <AlipaySDK/AlipaySDK.h>
#import <SystemConfiguration/SystemConfiguration.h>
/******网络状态监测*******/
#import "DHBReachability.h"
#import "DHBBindDeviceRequest.h"
#import "ParameterPublic.h"
#import "DHBNotificationManager.h"
#import "DHBAlertView.h"
#import "UMFeedback.h"
#import "DHBTipView.h"

@implementation AppDelegate
#pragma mark - init
- (DHBTipView *)tipMessageView{
    if(!_tipMessageView){
        _tipMessageView = [[DHBTipView alloc] init];
    }
    return _tipMessageView;
}

#pragma mark - application
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSData *image_data_jszzb = [NSData dataWithContentsOfFile:[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/jszzb",@"userid"]]];
//    NSLog_Red(@"path = %@,%@",[paths objectAtIndex:0] ,image_data_jszzb);
    /**
     *  高德API
     */
    [MAMapServices sharedServices].apiKey = AMapKEY;
    [AMapLocationServices sharedServices].apiKey =AMapKEY;
    [[DHBLoationManager sharedInstance] startUpdatingLocation];
    [AMapSearchServices sharedServices].apiKey = AMapKEY;
    
    /**
     *  友盟统计
     */
    [self createUMengAnalyticsFunction];
    
    /**
     *  友盟推送API
     */
    //set AppKey and AppSecret
    [UMessage startWithAppkey:UMengKEY launchOptions:launchOptions];
    [self CreatUMengMessage];
    
    /**
     *  友盟分享API
     */
    [self createUMengShareFunction];
    
    /**
     *  根视图
     */
    //设置状态栏样式
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    /**
     *  注：在AppDelegate中不能使用该方法,因为如果移动设备使用第三方键盘的时候，会引起程序的崩溃
     */
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor NavBack_Red_Color]];
    [self showHomeViewController:launchOptions];
    
    /**
     *  网络状态的监控（苹果官方）
     */
    [[DHBReachability sharedManagered] startNotifier];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[ParameterPublic sharedManagered] setIsactive:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[ParameterPublic sharedManagered] setIsactive:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [UMessage registerDeviceToken:deviceToken];
    NSString *devToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[ParameterPublic sharedManagered] setDeviceToken:devToken];
    [[NSUserDefaults standardUserDefaults]setObject:devToken forKey:@"DEVICETOKEN"];
//    [[[DHBTipView alloc] init] showInSuperView:self.window message:devToken];
    
//    NSLog_Blue(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                  stringByReplacingOccurrencesOfString: @">" withString: @""]
//                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
//    [UMessage addTag:@"GYS:00000" response:^(id responseObject, NSInteger remain, NSError *error) {
//        
//    }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    if ([userInfo objectForKey:@"custom"])
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[userInfo objectForKey:@"custom"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        if (dic)
        {
            [[DHBNotificationManager sharedInstance] pushCustom:dic isPush:![[ParameterPublic sharedManagered] isactive]];
        }
        else
        {
            [self showHomeViewController:nil];
        }
    }
}


#pragma mark showHomeViewController 显示root根页面（显示主页）
- (void)showHomeViewController:(NSDictionary*)launchOptions
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"skey = %@", [userDefaults objectForKey: @"skey"]);
    if(![userDefaults objectForKey: @"skey"]){
        ///未登录状态下，跳转至登录页面
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController =[[UINavigationController alloc]initWithRootViewController:[[DHBLoginViewController alloc] init]];
    }
    else{
        //已设置说明不是第一次显示主页
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[MainPageViewController alloc] init];
    }
    
    if(launchOptions)
    {   /**
         *  由推送进入
         */
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
        {
            [UMessage didReceiveRemoteNotification:userInfo];
            [[DHBNotificationManager sharedInstance] setUserInfo:userInfo];
        }
    }
}



#pragma mark UMengMessage Action 友盟推送集成
-(void)CreatUMengMessage{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    if(([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:NO];
    [UMessage setAutoAlert:NO];
}

#pragma mark - 集成友盟的分享SDK
- (void)createUMengShareFunction{
    [UMSocialData setAppKey:UMengKEY];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"193062435" RedirectURL:@"https://ypc.dhb168.com"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx2e000262d94f4dd3" appSecret:@"1f49848376005f6713e24b60027b18a9" url:@"http://www.dhb.hk"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1104579743" appKey:@"2CHakA4nlIOxENoO" url:@"http://www.dhb.hk"];
}

#pragma mark - 集成友盟分析统计SDK
- (void)createUMengAnalyticsFunction{
    [MobClick startWithAppkey:UMengKEY reportPolicy:BATCH channelId:@"DHB_BETA"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    ///TODO:关闭友盟分析
//    [MobClick setCrashReportEnabled:NO];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSString *handleUrl = [url absoluteString];
//    NSLog_Red(@"handleUrl = %@",handleUrl);
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO)
    {
        //调用其他SDK，例如支付宝SDK等
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"])
        {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
//                NSLog_Red(@"result = %@",resultDic);
            }];
        }
    }
    return result;
}

#pragma mark - 上传图片
-(void)uploadImageContent_table:(NSArray *)content{
    for (DHBUploadImage *img in [[ParameterPublic sharedManagered] upload_arr])
    {
        if (img.status == NOUPLOAD ||img.status == ERROR)
        {
            img.status = UPLOADING;
            DHBUploadAttachmentRequest *request = [[DHBUploadAttachmentRequest alloc] init];
            request.file_value = img.image;
            request.content = content;
            request.timeoutInterval = 20000;
            [request uploadDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
                NSDictionary *dic = (NSDictionary*)data;
                BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
                if (isSuccess)
                {
                    img.status = UPLOADED;
                }
                else
                {
                    img.status = ERROR;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadover" object:nil];
            } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
                img.status = ERROR;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadover" object:nil];
            }];
        }
    }
}

- (void)dealloc {
    // 删除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
