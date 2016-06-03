
//
//  DHBPaymentRecordDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentRecordDetailsService.h"
#import "DHBPayRecordDetailsRequest.h"

@implementation DHBPaymentRecordDetailsService
#pragma mark - init
- (DHBPaymentRecordModuleDTO *)paymentDTO{
    if(!_paymentDTO){
        _paymentDTO = [[DHBPaymentRecordModuleDTO alloc] init];
    }
    return _paymentDTO;
}

- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

#pragma mark - 构建详情数据
-(void)queryDetailsData{
    DHBPayRecordDetailsRequest *request = [[DHBPayRecordDetailsRequest alloc] init];
    request.payment_id = self.payment_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            [self.paymentDTO parseWithDictionary: [dic objectForKey: @"data"]];
            [self.floorsArray removeAllObjects];
            [self insertFirstFloor];
            [self insertSecondFloor];
//            [self insertThirdFloor];
//            [self insertfourthFloor];
        }
        if ([_delegate respondsToSelector:@selector(DHBPaymentRecordDetailsService_Complete:isSuccess:)]) {
            [_delegate DHBPaymentRecordDetailsService_Complete:self isSuccess:isSuccess];
        }
        
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        if ([_delegate respondsToSelector:@selector(DHBPaymentRecordDetailsService_Complete:isSuccess:)]) {
            [_delegate DHBPaymentRecordDetailsService_Complete:self isSuccess:NO];
        }
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"状态和价格";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentDTO];
    floorDTO.hight = 125.0f;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}


- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"付款单详细信息";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentDTO];
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"备注";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentDTO];
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"3";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertfourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.paymentDTO];
    floorDTO.floorName = @"凭证图片";
    floorDTO.hight = 0.0f;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}
@end
