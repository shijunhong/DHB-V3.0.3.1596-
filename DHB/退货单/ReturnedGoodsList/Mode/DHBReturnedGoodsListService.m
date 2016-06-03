//
//  DHBReturnedGoodsListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedGoodsListService.h"

@implementation DHBReturnedGoodsListService

- (NSMutableDictionary *)dataDictionary{
    if(!_dataDictionary){
        _dataDictionary = [[NSMutableDictionary alloc] init];
    }
    return _dataDictionary;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 数据
- (void)queryData {
    if(self.returns_id){
        
        DHBReturnedGoodsListRequest *request = [[DHBReturnedGoodsListRequest alloc] init];
        request.returns_id = self.returns_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess){
                NSDictionary *data = [dic objectForKey:@"data"];
//                NSLog_Blue(@"%@",data);
                NSArray *arr =  [data EncodeArrayFromDicWithKey:@"returnslist"];
                [self.dataArray removeAllObjects];
                [self.dataDictionary removeAllObjects];
                for (NSDictionary *dic in arr)
                {
                    DHBReturnsGoodsModuleDTO *ordersgoods = [[DHBReturnsGoodsModuleDTO alloc] init];
                    [ordersgoods parseFromDict: dic];
                    [self.dataArray addObject:ordersgoods];
                    ////分组
                    NSMutableArray *tempArray = [self.dataDictionary objectForKey: [ordersgoods orders_num]];
                    if(!tempArray){
                        [self.dataDictionary setObject: [NSMutableArray arrayWithObject: ordersgoods] forKey: [ordersgoods orders_num]];
                    }
                    else
                    {
                        [tempArray addObject: ordersgoods];
                        [self.dataDictionary setObject: tempArray forKey: [ordersgoods orders_num]];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(returnedGoodsListService_Compelete:isSuccess:)]) {
                    [_delegate returnedGoodsListService_Compelete:self isSuccess:YES];
                }
            });
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
            self.error = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(returnedGoodsListService_Compelete:isSuccess:)]) {
                    [_delegate returnedGoodsListService_Compelete:self isSuccess:NO];
                }
            });
        }];
    }
}
@end
