//
//  DHBDeliveryService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDeliveryService.h"

@implementation DHBDeliveryService

#pragma mark - dataArray
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -  获取数据
- (void)queryData {
    if(IsNilOrNull(self.deliveryMethodDTO)){
        self.deliveryMethodDTO = [[DHBDeliveryMethodMoudleDTO alloc] init];
    }
    for(NSInteger i = 0; i < 4; i++){
        HomeFloorDTO *floorDTO = [[HomeFloorDTO alloc] init];
        switch (i) {
            case 0:
                [floorDTO setFloorName: @"发货日期"];
                break;
            case 1:
                [floorDTO setFloorName: @"时间筛选器"];
                break;
            case 2:
                [floorDTO setFloorName: @"物流公司"];
                break;
            case 3:
                [floorDTO setFloorName: @"物流单号"];
                break;
            default:
                break;
        }
        
        [floorDTO setModuleList: [NSMutableArray arrayWithObject: self.deliveryMethodDTO]];
        [self.dataArray addObject: floorDTO];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(deliveryServiceComplete:isSuccess:)]) {
        [_delegate deliveryServiceComplete:self isSuccess:YES];
    }
}

#pragma mark - 设置退货的配送方式
- (void)settingReturnedOrderDeliveryMethod:(NSString *) _returns_id{
    DHBDeliveryMethodRequest *request = [[DHBDeliveryMethodRequest alloc] init];
    request.returns_id = _returns_id;
    request.deliveryMethodDTO = self.deliveryMethodDTO;
    request.is_add = self.isAddDelivery;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] == 100 ? YES : NO);
        if (isSuccess)
        {
            isSuccess = ([[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 0 ? NO : YES);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnOrderUpdate" object:nil userInfo:@{@"returns_id":_returns_id}];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(deliveryService_DidSettingDeliveryMethod:isSuccess:)]) {
                [_delegate deliveryService_DidSettingDeliveryMethod: self isSuccess:isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(deliveryService_DidSettingDeliveryMethod:isSuccess:)]) {
                [_delegate deliveryService_DidSettingDeliveryMethod:self isSuccess:NO];
            }
        });
    }];
}
@end
