//
//  MessageOrderService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "MessageOrderService.h"
#import "DHBMessageOrderRequest.h"

@implementation MessageOrderService
//-(NSMutableArray *)msglist{
//    if (!_msglist)
//    {
//        _msglist=[NSMutableArray array];
//    }
//    return _msglist;
//}

- (void)queryMsgData {
    
    DHBMessageOrderRequest *request = [[DHBMessageOrderRequest alloc] init];
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
            self.msglist = [data objectForKey:@"msgOrders"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageOrderServiceComplete:isSuccess:)]) {
                    [_delegate messageOrderServiceComplete:self isSuccess:YES];
                }
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageOrderServiceComplete:isSuccess:)]) {
                    [_delegate messageOrderServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageOrderServiceComplete:isSuccess:)]) {
                [_delegate messageOrderServiceComplete:self isSuccess:NO];
            }
        });
    }];
    
    
}

@end
