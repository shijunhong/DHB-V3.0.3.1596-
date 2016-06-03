//
//  DHBReturnedListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedListService.h"
#import "DHBReturnsDetailsRequest.h"

@implementation DHBReturnedListService

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 查询退货单数据
- (void)queryData{
    DHBReturnedListRequest *request = [[DHBReturnedListRequest alloc] init];
    request.page = self.page;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            NSDictionary *data = [dic objectForKey:@"data"];
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage =  (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
            NSArray *arr =  [data objectForKey:@"list"];
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in arr)
            {
                DHBReturnedOrderModuleDTO *order = [[DHBReturnedOrderModuleDTO alloc] init];
                [order parseFromDict:dic];
                [self.dataArray addObject:order];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(returnedListService_Complete:isSuccess:)]) {
                [_delegate returnedListService_Complete:self isSuccess:isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(returnedListService_Complete:isSuccess:)]) {
                [_delegate returnedListService_Complete:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 取消退货
- (void)cancelReturnsOrder{
    DHBCancelReturnsOrderRequest *request = [[DHBCancelReturnsOrderRequest alloc] init];
    request.returns_id = self.returns_id;
    request.reason = self.cancel_reason;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        self.message = [dic objectForKey: @"message"];
        if(isSuccess)
        {
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        if (isSuccess)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnOrderUpdate" object:nil userInfo:@{@"returns_id":request.returns_id}];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: self.message delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [alertView show];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
    }];
}


-(void)queryReturnOrderDetailsData:(NSString*)returns_id returnOrder:(void(^)(DHBReturnsOrderModuleDTO* returnOrder))callback{
    DHBReturnsDetailsRequest *request = [[DHBReturnsDetailsRequest alloc] init];
    request.returns_id = returns_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            DHBReturnsOrderModuleDTO *returnedOrderDTO = [[DHBReturnsOrderModuleDTO alloc] init];
            [returnedOrderDTO parseFromDict:[dic objectForKey:@"data"]];
            callback(returnedOrderDTO);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
    }];
}

@end
