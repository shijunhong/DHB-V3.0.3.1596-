//
//  MessageSystemService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageSystemService;
@protocol MessageSystemServiceDelegate <NSObject>
@optional
- (void)messageSystemServiceComplete:(MessageSystemService *)service isSuccess:(BOOL)isSuccess;
@end

@interface MessageSystemService : NSObject
@property(nonatomic, assign)id<MessageSystemServiceDelegate> delegate;
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger cpage;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, strong)NSMutableArray *msglist;


-(void)queryMsgData;
@property(nonatomic,strong)NSString *title_value;
- (void)queryAfficheData;
@end
