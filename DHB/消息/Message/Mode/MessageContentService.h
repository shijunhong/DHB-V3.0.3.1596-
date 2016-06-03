//
//  MessageContentService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageContentService;
@protocol MessageContentServiceDelegate <NSObject>
@optional
- (void)messageContentServiceComplete:(MessageContentService *)service isSuccess:(BOOL)isSuccess;
@end

@interface MessageContentService : NSObject
@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong)NSMutableArray *messagelist;
@property(nonatomic, assign) id<MessageContentServiceDelegate> delegate;
@property(nonatomic, strong)NSString *post_title_id;
//@property(nonatomic, assign)NSInteger count;
//@property(nonatomic, assign)NSInteger page;
//@property(nonatomic, assign)NSInteger cpage;
//@property(nonatomic, assign)NSInteger totalPage;
- (void)queryMessageData;
@end
