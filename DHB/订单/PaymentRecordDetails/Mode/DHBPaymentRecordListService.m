//
//  DHBPaymentRecordListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentRecordListService.h"
#import "HomeFloorDTO.h"
#import "DHBPayRecordListRequest.h"

@implementation DHBPaymentRecordListService
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

-(void)queryListData{
    [self.floorsArray removeAllObjects];
    DHBPayRecordListRequest *request = [[DHBPayRecordListRequest alloc] init];
    request.orders_num = self.order.orders_num;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
//            NSLog_Blue(@"data = %@",[[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"list"]);
            self.dataArray = [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"list"];
            [self insertFirstFloor];
            [self insertSecondFloor];
            if ([_delegate respondsToSelector:@selector(DHBPaymentRecordListComplete:isSuccess:)]) {
                [_delegate DHBPaymentRecordListComplete:self isSuccess:YES];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(DHBPaymentRecordListComplete:isSuccess:)]) {
                [_delegate DHBPaymentRecordListComplete:self isSuccess:NO];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        if ([_delegate respondsToSelector:@selector(DHBPaymentRecordListComplete:isSuccess:)]) {
            [_delegate DHBPaymentRecordListComplete:self isSuccess:NO];
        }
    }];
}

- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"金额";
    floorDTO.moduleList = [NSMutableArray arrayWithArray:@[self.order]];
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"付款记录";
    floorDTO.moduleList =[NSMutableArray arrayWithObject:self.dataArray];
    floorDTO.templateID = @"2";
    floorDTO.floors = [self.dataArray count];
    [self.floorsArray addObject:floorDTO];
}


@end
