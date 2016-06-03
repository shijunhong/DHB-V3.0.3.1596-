//
//  DHBMemberCenterService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT1 80.0F
#define CELL_HEIGHT2 50.0F
#import "DHBMemberCenterService.h"

@implementation DHBMemberCenterService
#pragma mark - setters and getters
- (NSMutableArray *)floorArray{
    if(!_floorArray){
        _floorArray = [[NSMutableArray alloc] init];
    }
    return _floorArray;
}

- (DHBMemberInfoModuleDTO *)memberInfo{
    if(!_memberInfo){
        _memberInfo = [[DHBMemberInfoModuleDTO alloc] init];
    }
    return _memberInfo;
}


#pragma mark - 获取会员信息
- (void)queryMemberData{
    DHBMemberCenterRequest *request = [[DHBMemberCenterRequest alloc] init];
//    request.hidden_effect = YES;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.memberInfo parseFromDict: [dic objectForKey:@"data"]];
            [self queryDefaultInfo];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(memberCenterSerivce_RequestMemberDataFinish:isSuccess:)]) {
                [_delegate memberCenterSerivce_RequestMemberDataFinish:self isSuccess: NO];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberCenterSerivce_RequestMemberDataFinish:isSuccess:)]) {
                [_delegate memberCenterSerivce_RequestMemberDataFinish:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 获取默认信息
- (void)queryDefaultInfo{
    DHBMyDefaultInfoRequest *request = [[DHBMyDefaultInfoRequest alloc] init];
    request.hidden_effect = YES;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.memberInfo setMemberBalance: [[dic objectForKey: @"data"] objectForKey: @"balance"]];
            NSString *quickly_pay = [[dic objectForKey: @"data"] objectForKey: @"is_quick"];
            [self.memberInfo setIsOpenQuicklyPay: [quickly_pay isEqualToString: @"T"] ? YES : NO];
            NSString *_manage_quickly_pay = [[dic objectForKey: @"data"] objectForKey: @"is_manager"];
            BOOL is_manager =  [_manage_quickly_pay isEqualToString: @"T"] ? YES : NO;
            /////
            [self.floorArray removeAllObjects];
            [self insertFirstFloor];
            [self insertSecondFloor];
            [self insertThirdFloor: is_manager];
            [self insertForthFloor];
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
        if ([_delegate respondsToSelector:@selector(memberCenterSerivce_RequestMemberDataFinish:isSuccess:)]) {
            [_delegate memberCenterSerivce_RequestMemberDataFinish:self isSuccess: isSuccess];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberCenterSerivce_RequestMemberDataFinish:isSuccess:)]) {
                [_delegate memberCenterSerivce_RequestMemberDataFinish:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floor = [[HomeFloorDTO alloc] init];
    [floor setHight: CELL_HEIGHT1];
    [floor setFloorName: @""];
    [floor setModuleList: [NSMutableArray arrayWithObjects: @"个人账户", nil]];
    [self.floorArray addObject: floor];
}

#pragma mark -
- (void)insertSecondFloor{
    HomeFloorDTO *floor = [[HomeFloorDTO alloc] init];
    [floor setHight: CELL_HEIGHT2];
    [floor setModuleList: [NSMutableArray arrayWithObjects: @"公司财务信息", @"收货地址", nil]];
    [self.floorArray addObject: floor];
}

#pragma mark -
- (void)insertThirdFloor:(BOOL) isQuickly{
    HomeFloorDTO *floor = [[HomeFloorDTO alloc] init];
    [floor setHight: CELL_HEIGHT2];
    NSMutableArray *dataArray = (isQuickly ? [NSMutableArray arrayWithObjects: @"资金账户", @"快捷支付",@"退货单",@"联系供货商", nil] : [NSMutableArray arrayWithObjects: @"资金账户", @"退货单",@"联系供货商", nil]);
    [floor setModuleList: dataArray];
    [self.floorArray addObject: floor];
}

#pragma mark -
- (void)insertForthFloor{
    HomeFloorDTO *floor = [[HomeFloorDTO alloc] init];
    [floor setHight: CELL_HEIGHT2];
    [floor setModuleList: [NSMutableArray arrayWithObjects: @"关于订货宝", @"系统建议与反馈", nil]];
    [self.floorArray addObject: floor];
}


#pragma mark - 退出登录
- (void)loginOut{
    DHBLoginOutRequest *request = [[DHBLoginOutRequest alloc] init];
    request.hidden_effect = YES;
    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if ([_delegate respondsToSelector:@selector(memberCenterSerivce_LoginOutFinish:isSuccess:)]) {
            [_delegate memberCenterSerivce_LoginOutFinish:self isSuccess: isSuccess];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberCenterSerivce_LoginOutFinish:isSuccess:)]) {
                [_delegate memberCenterSerivce_LoginOutFinish:self isSuccess:NO];
            }
        });
    }];

}
@end
