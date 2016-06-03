//
//  DHBReachability.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 4/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define DEFAULT_HOSTNAME @"http://www.dhb.hk"
#define DEFAULT_IPADDRESS @""
#import "DHBReachability.h"

@implementation DHBReachability
#pragma mark - getters and setters
- (SystemSetService *)systemService{
    if(!_systemService){
        _systemService = [[SystemSetService alloc] init];
    }
    return _systemService;
}

#pragma mark - 单例类
+(DHBReachability *)sharedManagered{
    static DHBReachability *reachability = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachability = [[DHBReachability alloc] init];
        /**
         *  默认的网路监测类型
         */
        reachability.curNetworkNotifiyType = kInternetConnection;
        /**
         *  默认是连接上网络的
         */
        reachability.isConnectNetwork = YES;
    });
    return reachability;
}

#pragma mark - 开启通知
- (void)startNotifier{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    switch (self.curNetworkNotifiyType) {
        case kHostName:{
            self.curReachability = [Reachability reachabilityWithHostName: (self.hostName ? self.hostName : DEFAULT_HOSTNAME)];
            break;
        }
        case kIPAddress:{
            struct sockaddr_in sockAddr;
            bzero((char*)&sockAddr,sizeof(sockAddr));
            sockAddr.sin_len = sizeof(sockAddr);
            sockAddr.sin_family = AF_INET;
            sockAddr.sin_addr.s_addr= inet_addr([self.ipAddress ? self.ipAddress : DEFAULT_IPADDRESS UTF8String]);
            self.curReachability = [Reachability reachabilityWithAddress: &sockAddr];
            break;
        }
        case kInternetConnection:{
            self.curReachability = [Reachability reachabilityForInternetConnection];
            break;
        }
        case kLocalWiFi:{
            self.curReachability = [Reachability reachabilityForLocalWiFi];
            break;
        }
        default:
            break;
    }
    if(self.curReachability){
        [self.curReachability startNotifier];
    }
}

#pragma mark - 停止通知
- (void)stopNotifier
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark - 网络状态的监测
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    self.curNetworkStatus = [reachability currentReachabilityStatus];
//    BOOL connectionRequired = [reachability connectionRequired];
    switch (self.curNetworkStatus)
    {
        case NotReachable:{
            /**
             *  网络无法连接
             */
            // 1.关闭“网络连接上”提示消息
            [[DHBAlertView sharedManagered] close];
            // 2.打开"没有网络"的提示信息
            [[DHBNotNetView sharedManagered] show];
            // 3.更新网络连接状态
            self.isConnectNetwork = NO;
            break;
        }
            
        case ReachableViaWWAN:{
            /**
             *  连接WAN网络
             */
            [self networkConnected];
            self.isConnectNetwork = YES;
            break;
        }
        case ReachableViaWiFi:{
            /**
             *  连接wifi网络
             */
            [self networkConnected];
            self.isConnectNetwork = YES;
            break;
        }
    }
}

#pragma mark - 网络连接上的处理操作
- (void)networkConnected{
    /*
     * 1.当断网后，恢复网络时，使用Alert提示用户，网络已经连接，并重新获取基础配置接口
     */
    if(!self.isConnectNetwork){
        [self.systemService querySystemData];
        [[DHBAlertView sharedManagered] showMessage: @"网络已连接,请重新刷新数据"];
    }
    // 2.隐藏"没有网络"的提示视图
    [[DHBNotNetView sharedManagered] dismiss];
}

#pragma mark - dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}
@end
