//
//  DHBRechargeMethodService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#define CELL_HEIGHT 50.0F
#import "DHBRechargeMethodService.h"
#import "DHBRechargeRequest.h"
#import "PayType.h"

@interface DHBRechargeMethodService ()
@end


@implementation DHBRechargeMethodService
#pragma mark - init
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

#pragma mark - 构建数据
-(void)queryData{
    [self.floorsArray removeAllObjects];
    DHBRechargeRequest *request = [[DHBRechargeRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            if (self.order)
            {
                [self insertFirstFloor_1];//添加第一层
            }
            else
            {
                [self insertFirstFloor];//添加第一层
            }
            [self insertSecondFloor];//添加第二层
            for (NSDictionary *dict in [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"paytype"])
            {
                PayType * paytype = [[PayType alloc] init];
                [paytype parseFromDict:dict];
                [self insertThirdFloor:paytype];//添加第三层
            }
            //添加白条
            [self insertFourFloor];
            if ([_delegate respondsToSelector:@selector(rechargeMethodService_Complete:isSuccess:)]) {
                [_delegate rechargeMethodService_Complete:self isSuccess:YES];
            }
        }

    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"类型";
    //    floorDTO.moduleList = ;
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFirstFloor_1{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"类型";
    floorDTO.moduleList = [NSMutableArray arrayWithArray:@[@{@"order":self.order}]];
    floorDTO.hight = 128;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = self.order?@" 本次支付":@" 本次充值";
    if(self.order){
        floorDTO.moduleList = [NSMutableArray arrayWithArray:@[@{@"order":self.order}]];
    }
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor:(PayType*)paytype{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = paytype.paytype_value;
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"pay":paytype}]];
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"3";
    floorDTO.floors =1;
    if (!self.order)
    {
        if (paytype.type != Deposit)
        {
            [self.floorsArray addObject:floorDTO];
        }
    }
    else
    {
        [self.floorsArray addObject:floorDTO];
    }
}

#pragma mark - 添加白条
- (void)insertFourFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"白条支付";
    PayType *type = [[PayType alloc]  init];
    [type setPaytype: @"白条支付"];
    [type setType: BaiTiao];
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"pay": type}]];
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"3";
    floorDTO.floors =1;
    if (self.order){
        [self.floorsArray addObject:floorDTO];
    }
}
@end
