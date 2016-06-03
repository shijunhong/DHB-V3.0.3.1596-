//
//  DHBReachability.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 4/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
typedef enum : NSInteger{
    kHostName = 0, //通过主机名监测
    kIPAddress, //通过IP地址监测
    kInternetConnection, //通过本地的网络状态监测
    kLocalWiFi //通过本地的WiFi信息监测
} NetworkNotifyType;

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <arpa/inet.h>
#import "SystemSetService.h"

@interface DHBReachability : NSObject
/**
 *  网络连接对象
 */
@property(nonatomic, strong) Reachability *curReachability;
/**
 *  当前是否连接上网络
 */
@property(nonatomic, assign) BOOL isConnectNetwork;
/**
 *  当前的网络状态
 */
@property(nonatomic, assign) NetworkStatus curNetworkStatus;
/**
 *  当前的网路监测类型
 */
@property(nonatomic, assign) NetworkNotifyType curNetworkNotifiyType;
/**
 *  主机名
 */
@property(nonatomic, assign) NSString *hostName;
/**
 *  IP地址
 */
@property(nonatomic, assign) NSString *ipAddress;
/**
 *  系统配置服务类
 */
@property (strong, nonatomic) SystemSetService *systemService;


/**
 *  类方法（单例）
 */
+ (DHBReachability *)sharedManagered;

/**
 *  public method
 */
- (void)startNotifier;
- (void)stopNotifier;
@end
