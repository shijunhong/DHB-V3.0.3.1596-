//
//  ReturnedOrderDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define BASE_HEIGHT
#import "ReturnedOrderDetailsService.h"

@implementation ReturnedOrderDetailsService

- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(void)queryOrderDetailData{
    [self.dataArray removeAllObjects];
    ReturnsOrderDetailsRequest *request = [[ReturnsOrderDetailsRequest alloc] init];
    request.orderID = self.orderID;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            self.order = [[OrderModuleDTO alloc] init];
//            [self.order parseFromDict:[dic objectForKey:@"data"]];
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
//                    [_delegate orderDetailsServiceComplete:self isSuccess:YES];
//                }
//            });
        }
        else
        {
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
//                [_delegate orderDetailsServiceComplete:self isSuccess:YES];
//            }
//        });
    }];
}

#pragma mark - 插入第一层的数据
-(void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退单状态";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.order];
    floorDTO.hight = 100.0f;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

#pragma mark - 插入第二层的数据
-(void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退货清单";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.order];
    floorDTO.hight = 100.0f;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}
@end
