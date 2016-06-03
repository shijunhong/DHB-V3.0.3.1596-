//
//  MessageSystemService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "MessageSystemService.h"
#import "DHBMessageSystemRequest.h"
#import "DHBMessageAfficheListRequest.h"

@implementation MessageSystemService
//-(NSMutableArray *)msglist{
//    if (!_msglist)
//    {
//        _msglist=[NSMutableArray array];
//    }
//    return _msglist;
//}

- (void)queryMsgData {
    
    DHBMessageSystemRequest *request = [[DHBMessageSystemRequest alloc] init];
    request.page = self.page;
    request.step = 10;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            NSDictionary *data = [dic objectForKey:@"data"];
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage =  (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
//            [self.msglist removeAllObjects];
            self.msglist = [data objectForKey:@"msgSystem"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                    [_delegate messageSystemServiceComplete:self isSuccess:YES];
                }
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                [_delegate messageSystemServiceComplete:self isSuccess:NO];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                [_delegate messageSystemServiceComplete:self isSuccess:NO];
            }
        });
    }];
    
    
}

- (void)queryAfficheData {
    
    DHBMessageAfficheListRequest *request = [[DHBMessageAfficheListRequest alloc] init];
    request.page = self.page;
    request.step = 10;
    request.title_value = (self.title_value ? self.title_value : @"");
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage =  (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
            //            [self.msglist removeAllObjects];
            self.msglist = [data objectForKey:@"msgAfficheList"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                    [_delegate messageSystemServiceComplete:self isSuccess:YES];
                }
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                [_delegate messageSystemServiceComplete:self isSuccess:NO];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageSystemServiceComplete:isSuccess:)]) {
                [_delegate messageSystemServiceComplete:self isSuccess:NO];
            }
        });
    }];
}

@end
