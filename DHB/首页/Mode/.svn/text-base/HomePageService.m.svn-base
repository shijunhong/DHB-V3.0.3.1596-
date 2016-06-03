//
//  HomePageService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/16.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "HomePageService.h"
#import "DHBGoodsHomeRequest.h"
@implementation HomePageService


- (NSMutableArray *)floorArray
{
    if (!_floorArray) {
        _floorArray=[[NSMutableArray alloc]init];
    }
    return _floorArray;
}
/**
 *  获取首页楼层数据
 *  接口只需要terminalID、channnelID、versionNumber
 *  方法内部自动获取这些参数
 */
- (void)queryHomePageData {
    DHBGoodsHomeRequest *request = [[DHBGoodsHomeRequest alloc] init];
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data =[dic objectForKey:@"data"];
//            NSLog_Red(@"%@",data);
            NSMutableArray *temparr= [NSMutableArray array];
            [weakSelf.floorArray removeAllObjects];
            weakSelf.floorArray = temparr;
            [weakSelf insertEightBannerFloor:data];
            [weakSelf insertFunctionFloor];
            [weakSelf insertTitleMainFloor];
            [weakSelf queryGoodsList];//获取商品列表
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(homePageServiceComplete:isSuccess:)]) {
                    [_delegate homePageServiceComplete:self isSuccess:YES];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
    
}

/**
 *  获取商品列表 首页获取推荐商品
 */
- (void)queryGoodsList{
    ///获取商品推荐
    DHBGoodsListRequest *request = [[DHBGoodsListRequest alloc] init];
    request.ishome = YES;
    request.step = 15;
    request.hidden_effect = YES;
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
            NSArray *dataArray =  [data objectForKey:@"list"];
            [weakSelf insertMainFloor:dataArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(homePageServiceComplete:isSuccess:)]) {
                    [_delegate homePageServiceComplete:self isSuccess:YES];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
    }];
}


#pragma mark - 推荐商品的标题层
-(void)insertTitleMainFloor{
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"3";
    homeFloorDTO.floorName = @"首推商品";
    homeFloorDTO.templateID= @"3";
    homeFloorDTO.floors = 1;
    homeFloorDTO.color = [UIColor TextGray_Color];
    homeFloorDTO.hight = 54.0f;
    [self.floorArray addObject:homeFloorDTO];
}

#pragma mark - 推荐商品列表层
-(void)insertMainFloor:(NSArray *) dataArray{
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"2";
    homeFloorDTO.floorName =@"推荐商品列表";
    homeFloorDTO.templateID= @"5";
    homeFloorDTO.color = [UIColor TextGray_Color];
    homeFloorDTO.hight = 130.0f;
    ///绑定数据
//    NSInteger flag = ([dataArray count] > 15 ? 15 : [dataArray count]);
    homeFloorDTO.floors = [dataArray count];
    for (NSInteger i = 0; i < [dataArray count]; i++)
    {
        NSDictionary *dic = [dataArray objectAtIndex: i];
        GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
        [goods parseFromDict:dic];
        [homeFloorDTO.moduleList addObject:goods];
    }
    [self.floorArray addObject:homeFloorDTO];
}

#pragma mark - banner八连版
-(void)insertEightBannerFloor:(NSDictionary*)dataBanner{
    NSArray *arr = [dataBanner EncodeArrayFromDicWithKey:@"banner"];
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"1";
    homeFloorDTO.floorName =@"banner";
    homeFloorDTO.templateID= @"1";
    homeFloorDTO.floors = 1;
    homeFloorDTO.hight = Multiple * 200.0f;
    for (NSDictionary *dic in arr)
    {
        ActivityModuleDTO *dto = [[ActivityModuleDTO alloc] init];
        [dto parseFromDict:dic];
        [homeFloorDTO.moduleList addObject:dto];
    }
    [self.floorArray insertObject:homeFloorDTO atIndex:0];
}

#pragma mark - 首页功能版
-(void)insertFunctionFloor{
    HomeFloorDTO *homeFloorDTO = [[HomeFloorDTO alloc] init];
    homeFloorDTO.orderNO = @"2";
    homeFloorDTO.floorName =@"首页功能版";
    homeFloorDTO.templateID= @"2";
    homeFloorDTO.floors = 1;
    homeFloorDTO.hight = 234.0f;
    homeFloorDTO.is_showHeade = YES;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"functionId":@"5",@"image":@"促销",@"name":@"促销商品",@"number":@"0"},
                                                           @{@"functionId":@"3",@"image":@"热销",@"name":@"热销商品",@"number":@"10"},
                                                           @{@"functionId":@"2",@"image":@"推荐",@"name":@"推荐商品",@"number":@"5"},
                                                           @{@"functionId":@"1",@"image":@"最新",@"name":@"最新商品",@"number":@"0"},
                                                           @{@"functionId":@"-2",@"image":@"收藏",@"name":@"收藏商品",@"number":@"2"},
                                                           @{@"functionId":@"-1",@"image":@"订过",@"name":@"订过商品",@"number":@"1"}]];
    for (NSDictionary *dic in arr)
    {
        FunctionDTO *function = [[FunctionDTO alloc] init];
        [function parseFromDict:dic];
        [homeFloorDTO.moduleList addObject:function];
    }
    
    [self.floorArray addObject:homeFloorDTO];
}
@end
