//
//  PaymentsDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsDetailsService.h"
#import "DHBPayHistoryDetailsRequest.h"

@implementation DHBPaymentsDetailsService
#pragma mark - init
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

- (DHBPaymentsInfoModuleDTO *)paymentsDTO{
    if(!_paymentsDTO){
        _paymentsDTO = [[DHBPaymentsInfoModuleDTO alloc] init];
    }
    return _paymentsDTO;
}

#pragma mark - 构建详情数据
-(void)queryDetailsData{
    if (self.is_payHistory)
    {
        DHBPayHistoryDetailsRequest *request = [[DHBPayHistoryDetailsRequest alloc] init];
        request.receipts_id = self.payHistoryDTO.receipts_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess)
            {
                [self.paymentsDTO parseFromDict: [dic EncodeDicFromDicWithKey: @"data"]];
                [self.floorsArray removeAllObjects];
                [self insertFirstFloor];
                [self insertSecondFloor];
                [self insertThirdFloor];
                [self insertfourthFloor];
            }
            if ([_delegate respondsToSelector:@selector(DHBPaymentsDetailsService_Complete:isSuccess:)]) {
                [_delegate DHBPaymentsDetailsService_Complete:self isSuccess:isSuccess];
            }
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            if ([_delegate respondsToSelector:@selector(DHBPaymentsDetailsService_Complete:isSuccess:)]) {
                [_delegate DHBPaymentsDetailsService_Complete:self isSuccess:NO];
            }
        }];

    }
    else
    {
        DHBPaymentsDetailsRequest *request = [[DHBPaymentsDetailsRequest alloc] init];
        request.deposit_id = self.paymentsDTO.deposit_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess)
            {
                [self.paymentsDTO parseFromDict: [dic EncodeDicFromDicWithKey: @"data"]];
                [self.floorsArray removeAllObjects];
                [self insertFirstFloor];
                [self insertSecondFloor];
                [self insertThirdFloor];
                [self insertfourthFloor];
            }
            if ([_delegate respondsToSelector:@selector(DHBPaymentsDetailsService_Complete:isSuccess:)]) {
                [_delegate DHBPaymentsDetailsService_Complete:self isSuccess:isSuccess];
            }
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            if ([_delegate respondsToSelector:@selector(DHBPaymentsDetailsService_Complete:isSuccess:)]) {
                [_delegate DHBPaymentsDetailsService_Complete:self isSuccess:NO];
            }
        }];
    }
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"状态和价格";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentsDTO];
    floorDTO.hight = 125.0f;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}


- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"付款单详细信息";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.paymentsDTO];
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"备注";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentsDTO];
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"3";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertfourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"凭证图片";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentsDTO];
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}
@end
