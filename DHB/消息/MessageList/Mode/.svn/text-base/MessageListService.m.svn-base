//
//  MessageListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "MessageListService.h"
#import "DHBMessageRequest.h"

//typedef enum {
//    ORDER,//订单消息
//    SYSTEM,//系统公告
//    MESSAGE,//留言咨询
//    OTHER,//其他
//}MessageType;

@implementation MessageListService

-(NSMutableArray *)messagelist{
    if (!_messagelist)
    {
        _messagelist = [NSMutableArray array];
    }
    return _messagelist;
}


-(void)queryMessageTip{
    DHBMessageRequest *request = [[DHBMessageRequest alloc] init];
    request.hidden_effect = YES;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        //        NSLog_Red(@"%@",dic);
        if([[dic objectForKey:@"code"] intValue] == 100)
        {
            if ([[[dic objectForKey:@"data"] EncodeStringFromDicWithKey:@"is_noread"] boolValue])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showMsgTipView" object:nil];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenMsgTipView" object:nil];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

- (void)queryMessageData{
    
    [self.messagelist removeAllObjects];
    DHBMessageRequest *request = [[DHBMessageRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if([[dic objectForKey:@"code"] intValue] == 100)
        {
            if ([[[dic objectForKey:@"data"] EncodeStringFromDicWithKey:@"is_noread"] boolValue])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showMsgTipView" object:nil];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenMsgTipView" object:nil];
            }
            for (NSDictionary * dict in [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"msgArray"])
            {
                NSString *title_value = [dict EncodeStringFromDicWithKey:@"title_value"];
                NSMutableDictionary *msg = [NSMutableDictionary dictionaryWithDictionary:dict];
                [msg setObject: [NSNumber numberWithLong: labs([[dict objectForKey: @"count"] integerValue])] forKey: @"count"];
                if ([title_value isEqualToString:@"order"])
                {
                    [msg setValue:@"ddxx" forKey:@"img"];
                }
                else if ([title_value isEqualToString:@"system"])
                {
                    [msg setValue:@"xtgg" forKey:@"img"];
                }
                else if ([title_value isEqualToString:@"message"])
                {
                    [msg setValue:@"lyzx" forKey:@"img"];
                }
                else
                {
                    [msg setValue:@"moren" forKey:@"img"];
                }
                [self.messagelist addObject:msg];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(messageListServiceComplete:isSuccess:)])
            {
                [_delegate messageListServiceComplete:self isSuccess:YES];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(messageListServiceComplete:isSuccess:)])
            {
                [_delegate messageListServiceComplete:self isSuccess:NO];
            }
        });
    }];
}
@end
