//
//  DHBReturnedGoodsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedGoodsService.h"
#import "DHBReturnedGoodsRequest.h"
#import "OrderModuleDTO.h"
@implementation DHBReturnedGoodsService
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
    
    DHBReturnedGoodsRequest  *request = [[DHBReturnedGoodsRequest alloc] init];
    request.orders_id =self.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            NSArray *arr = [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"orderslist"];
            for (NSDictionary *dict in arr)
            {
                OrdersgoodsModuleDTO *ordersgoods = [[OrdersgoodsModuleDTO alloc] init];
                [ordersgoods parseFromDict:dict];
                [self.dataArray addObject:ordersgoods];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(returnedGoodsServiceComplete:isSuccess:)]) {
                    [_delegate returnedGoodsServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(returnedGoodsServiceComplete:isSuccess:)]) {
                    [_delegate returnedGoodsServiceComplete:self isSuccess:NO];
                }
            });
        }

    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(returnedGoodsServiceComplete:isSuccess:)]) {
                [_delegate returnedGoodsServiceComplete:self isSuccess:NO];
            }
        });
    }];
    
}
@end
