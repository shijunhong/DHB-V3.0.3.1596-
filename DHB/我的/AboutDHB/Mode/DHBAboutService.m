//
//  DHBAboutService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define TOPCELL_HEIGHT 376.5f
#define BASECELL_HEIGHT 45.0F
#import "DHBAboutService.h"

@implementation DHBAboutService
#pragma mark - init
- (DHBAboutModuleDTO *)aboutDTO{
    if(!_aboutDTO){
        _aboutDTO = [[DHBAboutModuleDTO alloc] init];
    }
    return _aboutDTO;
}

- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

- (DHBShareInfoModuleDTO *)shareInfoDTO{
    if(!_shareInfoDTO){
        _shareInfoDTO = [[DHBShareInfoModuleDTO alloc] init];
    }
    return _shareInfoDTO;
}

#pragma mark - 构建数据
-(void)queryData{
    DHBAboutRequest *request = [[DHBAboutRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.aboutDTO parseFromDict: [dic objectForKey:@"data"]];
            [self insertFirstFloor];//添加第一层
            [self insertSecondFloor];//添加第二层
            [self insertThirdFloor];//添加第三层
            [self insertFourthFloor];//添加第四层
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(aboutService_Complete:isSuccess:)]) {
                [_delegate aboutService_Complete:self isSuccess:isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(aboutService_Complete:isSuccess:)]) {
                [_delegate aboutService_Complete:self isSuccess: NO];
            }
        });
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"订货宝";
    floorDTO.moduleList = [NSMutableArray arrayWithObject: self.aboutDTO];
    floorDTO.hight = TOPCELL_HEIGHT;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"当前版本";
    floorDTO.hight = BASECELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    floorDTO.moduleList = [NSMutableArray arrayWithObject:Version];
    [self.floorsArray addObject:floorDTO];
}


- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"查看官网";
//    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASECELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"推荐好友使用";
//    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASECELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

#pragma mark - 获取分享内容
-(void)queryShareData{
    DHBShareInfoRequest *request = [[DHBShareInfoRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.shareInfoDTO parseFromDic: [dic objectForKey: @"data"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(aboutService_ShareInfoComplete:isSuccess:)]) {
                [_delegate aboutService_ShareInfoComplete:self isSuccess:isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(aboutService_ShareInfoComplete:isSuccess:)]) {
                [_delegate aboutService_ShareInfoComplete:self isSuccess: NO];
            }
        });
    }];
}
@end
