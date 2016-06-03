//
//  SiftingService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "SiftingService.h"
#import "HomeFloorDTO.h"
#import "DHBSiftingRequest.h"
@implementation SiftingService
-(instancetype)init{
    self = [super init];
    if (self)
    {
        self.siftinglist = [NSMutableArray array];
    }
    return self;
}

- (void)querySiftingData{
    DHBSiftingRequest *request = [[DHBSiftingRequest alloc] init];
    request.category_id = self.category_id;
    request.search_content = self.search_content;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
            self.sifting = [[SiftingModuleDTO alloc] init];
            [self.sifting parseFromDict:data];
            [self.siftinglist removeAllObjects];
            [self insertFirstFloor];//筛选第一层
            [self insertSecondFloor];//价格区间第二层
            [self insertThirdFloor];//品牌第三层
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(siftingServiceComplete:isSuccess:)]) {
                    [_delegate siftingServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(siftingServiceComplete:isSuccess:)]) {
                    [_delegate siftingServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(siftingServiceComplete:isSuccess:)]) {
                [_delegate siftingServiceComplete:self isSuccess:NO];
            }
        });
    }];
}

//筛选楼层
-(void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"筛选层";
    for (TagModuleDTO *dto in self.sifting.tags) {
        if(dto.tag_id == self.tag_id){
            [dto setIs_select: YES];
        }
    }
    floorDTO.moduleList = [[NSMutableArray alloc] initWithArray:self.sifting.tags];
    long n = [self.sifting.tags count]%3>0?[self.sifting.tags count]/3+1:[self.sifting.tags count]/3;
    floorDTO.hight = 43*n+30;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.siftinglist insertObject:floorDTO atIndex:0];
}

//价格楼层
-(void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"价格区间";
    floorDTO.hight = 55;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.siftinglist insertObject:floorDTO atIndex:1];
}

//品牌楼层
-(void)insertThirdFloor{
    NSMutableArray *moduleList= [[NSMutableArray alloc] initWithArray:self.sifting.brands];
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"品牌层";
    if ([[ParameterPublic sharedManagered] goods_brand])
    {
        floorDTO.hight = 44;
        floorDTO.templateID = @"3";
    }
    floorDTO.moduleList = moduleList;
    floorDTO.is_showHeade = NO;
    floorDTO.floors = 1;
    [self.siftinglist insertObject:floorDTO atIndex:2];
}

@end
