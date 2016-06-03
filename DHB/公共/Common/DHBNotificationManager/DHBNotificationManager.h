//
//  DHBNotificationManager.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageListService.h"
@interface DHBNotificationManager : NSObject

/**
 *  初始化
 *
 *  @return
 */
+(DHBNotificationManager *)sharedInstance;
@property(nonatomic,strong)MessageListService*service;//消息service
@property(nonatomic,strong)NSDictionary* userInfo;//参数

/**
 *  进入模块
 *
 *  @param custom 参数
 *  @param start  是否push (由外面推送点击打开程序）
 */
-(void)pushCustom:(NSDictionary*)custom isPush:(BOOL)is_push;

/**
 *  重推送刚刚启动
 */
-(void)NotificationStartPush;

@end
