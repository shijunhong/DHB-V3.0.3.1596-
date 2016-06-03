//
//  MessageService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "MessageService.h"
#import "DHBMessageListRequest.h"

@implementation MessageService
//-(NSMutableArray *)messagelist{
//    if (!_messagelist)
//    {
//        _messagelist = [NSMutableArray array];
//    }
//    return _messagelist;
//}

- (void)queryMessageData{
    
    DHBMessageListRequest *request = [[DHBMessageListRequest alloc] init];
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
            self.messagelist = [data objectForKey:@"msgPost"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(messageServiceComplete:isSuccess:)]) {
                    [_delegate messageServiceComplete:self isSuccess:YES];
                }
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageServiceComplete:isSuccess:)]) {
                [_delegate messageServiceComplete:self isSuccess:NO];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(messageServiceComplete:isSuccess:)]) {
                [_delegate messageServiceComplete:self isSuccess:NO];
            }
        });
    }];

}
@end
