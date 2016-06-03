//
//  MessageListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageListService;
@protocol MessageListServiceDelegate <NSObject>
@optional
- (void)messageListServiceComplete:(MessageListService *)service isSuccess:(BOOL)isSuccess;
@end

@interface MessageListService : NSObject
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong)NSMutableArray *messagelist;
@property(nonatomic, assign) id<MessageListServiceDelegate> delegate;
- (void)queryMessageData;
- (void)queryMessageTip;
@end
