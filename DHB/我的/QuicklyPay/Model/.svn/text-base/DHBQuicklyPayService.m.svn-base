//
//  DHBQuicklyPayService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/10/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBQuicklyPayService.h"

@implementation DHBQuicklyPayService
#pragma mark - 
- (NSMutableArray *)floorArray{
    if(!_floorArray){
        _floorArray = [NSMutableArray array];
    }
    return _floorArray;
}

#pragma mark - 查询数据
- (void)queryData{
//    NSArray *dataArray = [NSArray arrayWithObject: @{@"name":@"快捷支付", @"status":@"提醒开通", @"description":@"您的供应商还未开通快捷支付，支付太麻烦，去提醒他开通吧"}];
    HomeFloorDTO *dto = [[HomeFloorDTO alloc] init];
    dto.floorName = @"快捷支付";
//    dto.moduleList = [NSMutableArray arrayWithArray: dataArray];
    dto.hight = 60.0f;
    [self.floorArray addObject: dto];
    self.DHBQuicklyPayService_Compelete(self,YES);
}

#pragma mark - 提醒用户开通
- (void)alertOpenAuicklyPay{
    DHBAddNewMessageRequest *request = [[DHBAddNewMessageRequest alloc] init];
    request.content = self.content;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if (isSuccess)
        {
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.DHBQuicklyPayService_AlertOpenAuicklyPay(self,isSuccess);
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.DHBQuicklyPayService_AlertOpenAuicklyPay(self,NO);
        });
    }];
}
@end
