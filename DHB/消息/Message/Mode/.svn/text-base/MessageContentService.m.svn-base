//
//  MessageContentService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "MessageContentService.h"
#import "DHBMessageContentRequest.h"

@implementation MessageContentService

-(NSMutableArray *)messagelist{
    if (!_messagelist)
    {
        _messagelist = [NSMutableArray array];
    }
    return _messagelist;
}

- (void)queryMessageData {
    
    DHBMessageContentRequest *request = [[DHBMessageContentRequest alloc] init];
    request.post_title_id =  self.post_title_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
            [self.messagelist removeAllObjects];
            for (NSDictionary *dict in [data EncodeArrayFromDicWithKey:@"msgPostList"])
            {
                [self.messagelist addObject:dict];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageContentServiceComplete:isSuccess:)]) {
                    [_delegate messageContentServiceComplete:self isSuccess:YES];
                }
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageContentServiceComplete:isSuccess:)]) {
                [_delegate messageContentServiceComplete:self isSuccess:NO];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageContentServiceComplete:isSuccess:)]) {
                [_delegate messageContentServiceComplete:self isSuccess:NO];
            }
        });
    }];
    
    
}


@end
