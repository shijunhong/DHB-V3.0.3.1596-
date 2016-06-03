//
//  OrderGoodsListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderGoodsListService.h"
#import "DHBOrderGoodsListRequest.h"
#import "OrderModuleDTO.h"
@implementation OrderGoodsListService

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)queryOrderDetailData{
    
    NSMutableArray *temparr= [NSMutableArray array];
    [self.dataArray removeAllObjects];
    self.dataArray = temparr;
    
    DHBOrderGoodsListRequest *request = [[DHBOrderGoodsListRequest alloc] init];
    request.orders_id = self.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            
            NSArray *arr = [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"orderslist"];
            for (NSDictionary *dict in arr)
            {
                OrdersgoodsModuleDTO *ordersgoods = [[OrdersgoodsModuleDTO alloc] init];
                [ordersgoods parseFromDict:dict];
                [self.dataArray addObject:ordersgoods];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderGoodsListServiceComplete:isSuccess:)]) {
                    [_delegate orderGoodsListServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderGoodsListServiceComplete:isSuccess:)]) {
                    [_delegate orderGoodsListServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(orderGoodsListServiceComplete:isSuccess:)]) {
                [_delegate orderGoodsListServiceComplete:self isSuccess:NO];
            }
        });
    }];
}
@end
