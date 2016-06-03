//
//  DHBAddMessageService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddMessageService.h"
#import "DHBFeedBackSystemRequest.h"

@implementation DHBAddMessageService
- (void)addNewMessage{
    
    DHBAddNewMessageRequest *request = [[DHBAddNewMessageRequest alloc] init];
    request.content = self.content;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if (isSuccess)
        {
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(addMessageService_Complete:isSuccess:)]) {
                [_delegate addMessageService_Complete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(addMessageService_Complete:isSuccess:)]) {
                [_delegate addMessageService_Complete:self isSuccess:NO];
            }
        });
    }];
}


- (void)addFeedBack{
    DHBFeedBackSystemRequest *request = [[DHBFeedBackSystemRequest alloc] init];
    request.feedback_value = self.content;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if (isSuccess)
        {
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(addMessageService_Complete:isSuccess:)]) {
                [_delegate addMessageService_Complete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(addMessageService_Complete:isSuccess:)]) {
                [_delegate addMessageService_Complete:self isSuccess:NO];
            }
        });
    }];
}

@end
