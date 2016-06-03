//
//  OrderListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderListService.h"
#import "DHBOrdersListRequest.h"
#import "DHBOrderSiftingRequest.h"
#import "DHBOrderDetailsRequest.h"
@implementation OrderListService

-(NSMutableArray *)orderlist{
    if (!_orderlist)
    {
        _orderlist=[NSMutableArray array];
    }
    return _orderlist;
}

- (void)queryOrderData {
    DHBOrdersListRequest *request = [[DHBOrdersListRequest alloc] init];
    request.content = self.content?self.content:@"";
    request.is_attention = self.is_attention?self.is_attention:@"F";
    request.status = self.status?self.status:@"";
    request.pay_status = self.pay_status?self.pay_status:@"";
    request.begin_date = self.begin_date?self.begin_date:@"";
    request.end_date = self.end_date?self.end_date:@"";
    request.page = self.page;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
//            NSLog_Blue(@"%@",data);
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage = (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
            NSArray *arr =  [data objectForKey:@"list"];
            [self.orderlist removeAllObjects];
            for (NSDictionary *dic in arr)
            {
                OrderModuleDTO *order = [[OrderModuleDTO alloc] init];
                [order parseFromDict:dic];
                [self.orderlist addObject:order];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderListServiceComplete:isSuccess:)])
                    [_delegate orderListServiceComplete:self isSuccess:YES];
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderListServiceComplete:isSuccess:)])
                    [_delegate orderListServiceComplete:self isSuccess:NO];
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(orderListServiceComplete:isSuccess:)])
                [_delegate orderListServiceComplete:self isSuccess:NO];
        });
    }];
}

-(void)querySiftingDataCallBack:(void (^)(BOOL))block{
    DHBOrderSiftingRequest *request = [[DHBOrderSiftingRequest alloc] init];
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
            weakSelf.pay_status = @"all";
            weakSelf.pay_status_arr = [[NSMutableArray alloc] initWithArray:[data EncodeArrayFromDicWithKey:@"pay_status"]];
            [weakSelf.pay_status_arr insertObject:@{@"name":@"全部",@"value":@"all"} atIndex:0];
            
            weakSelf.status = @"all";
            weakSelf.status_arr = [[NSMutableArray alloc] initWithArray:[data EncodeArrayFromDicWithKey:@"status"]];
            [weakSelf.status_arr insertObject:@{@"name":@"全部",@"value":@"all"} atIndex:0];
            
            weakSelf.content = @"";
            block(YES);
        }
        else NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
}


-(BOOL)isAllOrder{
    BOOL validate = YES;
    if (self.is_attention && (![self.is_attention isEqualToString:@""]))
    {
        if ([self.is_attention isEqualToString:@"F"])
        {
            validate = NO;
        }
    }
    if (self.pay_status && (![self.pay_status isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.status && (![self.status isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.begin_date && (![self.begin_date isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.end_date && (![self.end_date isEqualToString:@""]))
    {
        validate = NO;
    }
    return validate;
}

-(void)queryOrder:(NSString*)orders_id Order:(void(^)(OrderModuleDTO*order))callback{
    DHBOrderDetailsRequest *request = [[DHBOrderDetailsRequest alloc] init];
    request.orders_id = orders_id;
    request.hidden_effect = YES;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            OrderModuleDTO *order = [[OrderModuleDTO alloc] init];
            [order parseFromDict:[dic objectForKey:@"data"]];
            if ([order.pay_status isEqualToString:@"已付款"])
            {
                order.is_pay = @"F";
            }
            else
            {
                if ([order.status isEqualToString:@"已取消"])
                    order.is_pay = @"F";
                else
                    order.is_pay = @"T";
            }
            callback(order);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

@end
