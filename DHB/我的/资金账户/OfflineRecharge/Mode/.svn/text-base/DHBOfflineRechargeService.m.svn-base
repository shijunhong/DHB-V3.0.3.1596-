//
//  DHBOfflineRechargeService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#import "DHBOfflineRechargeService.h"
#import "DHBOfflineRechargeRequest.h"

@implementation DHBOfflineRechargeService
#pragma mark - init
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

//- (NSMutableArray *)dataArray{
//    if(!_dataArray){
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}

#pragma mark -  获取数据
- (void)queryData {
    
    DHBOfflineRechargeRequest *request = [[DHBOfflineRechargeRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            self.dataArray = [NSMutableArray arrayWithArray:[[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"offlineList"]];
            [self setDefault:self.dataArray];
            [self insertFirstFloor];//添加第一层
            [self insertFifthFloor];
            [self insertSecondFloor];//添加第二层
            [self insertThirdFloor];//添加第三层
            [self insertFourthFloor];
            if ([_delegate respondsToSelector:@selector(offlineRechargeService_Complete:isSuccess:)]) {
                [_delegate offlineRechargeService_Complete:self isSuccess:YES];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"转账日期";
//    floorDTO.moduleList = ;
    floorDTO.hight = 50.0f;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"收款账户";
    floorDTO.moduleList = self.dataArray;
    floorDTO.hight = [self.dataArray count] * 90.0f + 45.0f;
    floorDTO.templateID = @"2";
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.floors = 1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"备注";
//    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = 100.0f;
    floorDTO.templateID = @"3";
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"凭证";
//    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = 100.0f;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    floorDTO.sectionHeight = 0.0f;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFifthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"时间选择器";
    floorDTO.templateID = @"5";
    floorDTO.sectionHeight = 0.0f;
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

-(void)setDefault:(NSMutableArray*)arr{
    __block BOOL is_Default = NO;
    [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj EncodeStringFromDicWithKey:@"is_default"] isEqualToString:@"T"])
        {
            is_Default = YES;
        }
    }];
    if (!is_Default) {
        NSMutableDictionary *dic = [arr firstObject];
        NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutableItem setObject:@"T" forKey:@"is_default"];
        [arr setObject:mutableItem atIndexedSubscript:0];
    }
    
}

@end
