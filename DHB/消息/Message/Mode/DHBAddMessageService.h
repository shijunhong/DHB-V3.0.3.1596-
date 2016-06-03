//
//  DHBAddMessageService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBAddNewMessageRequest.h"

@protocol DHBAddMessageService_Delegate <NSObject>
@optional
- (void)addMessageService_Complete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBAddMessageService : NSObject
@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, assign) id<DHBAddMessageService_Delegate> delegate;

- (void)addNewMessage;
- (void)addFeedBack;
@end
