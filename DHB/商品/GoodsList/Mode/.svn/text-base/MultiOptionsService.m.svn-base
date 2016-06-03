//
//  MultiOptionsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "MultiOptionsService.h"
#import "DHBMultiOptionsRequest.h"
#import "HomeFloorDTO.h"
#import "GoodsModuleDTO.h"
#import "OptionModuleDTO.h"
#import "MultiModuleDTO.h"
@implementation MultiOptionsService{
}

- (void)queryOptionsDataWhitGoodsModuleDTO:(GoodsModuleDTO*)goods {
    self.goods = nil;
    self.goods = goods;
    NSMutableArray *temparr= [NSMutableArray array];
    [self.optionslist removeAllObjects];
    self.optionslist = temparr;
    
    DHBMultiOptionsRequest *request = [[DHBMultiOptionsRequest alloc] init];
    request.goods_id = goods.goods_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            self.goods = nil;
            self.goods = [[GoodsModuleDTO alloc] init];
            [self.goods parseFromDict:[dic objectForKey:@"data"]];
            self.goods.number = self.goods.min_order;
            [self insertFirstFloor];//添加第一层
            [self insertSecondFloor];//添加第二层
            [self insertThirdFloor];//添加第三层
            [self insertFourthFloor];//添加第四层
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(multiOptionsServiceComplete:isSuccess:)]) {
                    [_delegate multiOptionsServiceComplete:self isSuccess:YES];
                }
            });

        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(multiOptionsServiceComplete:isSuccess:)]) {
                    [_delegate multiOptionsServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(multiOptionsServiceComplete:isSuccess:)]) {
                [_delegate multiOptionsServiceComplete:self isSuccess:NO];
            }
        });
    }];
}

-(void)insertFirstFloor{
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"1";
    homeFloorDTO.floorName =@"商品信息";
    homeFloorDTO.templateID= @"1";
    homeFloorDTO.floors = 1;
    homeFloorDTO.hight = 85;
    NSMutableArray *moduleList = [[NSMutableArray alloc] init];
    [moduleList addObject:self.goods];
    homeFloorDTO.moduleList = moduleList;
    
    [self.optionslist addObject:homeFloorDTO];
}

-(void)insertSecondFloor{
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"2";
    homeFloorDTO.floorName =@"商品阶梯价";
    homeFloorDTO.floors = 1;
    homeFloorDTO.moduleList = [[NSMutableArray alloc] initWithArray:@[@{@"goods":_goods}]];
    homeFloorDTO.hight = [[ParameterPublic sharedManagered] client_view_goods_price]?-1:0;
    homeFloorDTO.templateID= homeFloorDTO.hight ==0?@"":@"2";
    [self.optionslist addObject:homeFloorDTO];
}

-(void)insertThirdFloor{
    HomeFloorDTO *floorDTO = [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品规格";
    floorDTO.floors = 1;
    floorDTO.moduleList = [[NSMutableArray alloc] initWithArray:@[@{@"goods":_goods}]];
    floorDTO.hight = [_goods.multi_data count] == 0 || [_goods.options isEqualToString:@"F"] || ![[ParameterPublic sharedManagered] goods_multi]?0:-1;
    floorDTO.templateID = floorDTO.hight ==0?@"":@"3";
    [self.optionslist addObject:floorDTO];
}

//数量楼层
-(void)insertFourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName =@"商品数量";
    floorDTO.moduleList = [NSMutableArray arrayWithArray:@[self.goods]];
    floorDTO.hight = -1;
    floorDTO.floors = 1;
    floorDTO.templateID = @"4";
    [self.optionslist addObject:floorDTO];
}


@end
