//
//  DHBProductDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsDetailsService.h"
#import "DHBGoodsDetailsRequest.h"
#import "OptionModuleDTO.h"
#import "MultiModuleDTO.h"
#import "DHBAddShoppingCarRequest.h"
#import "DHBAlertView.h"
@implementation DHBGoodsDetailsService{
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}


-(void)queryGoodsDetailData{
    DHBGoodsDetailsRequest *request = [[DHBGoodsDetailsRequest alloc] init];
    request.goods_id = self.goods_id;
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            
            weakSelf.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 15+(10+12)*[_goods.field_data count]+20, SCREEN_WIDTH, 1)];
            weakSelf.webView.delegate = weakSelf;
            weakSelf.webView.scalesPageToFit = YES;
            
            _goods = [[GoodsModuleDTO alloc] init];
            _goods.defaultOption = self.defaultOption;
            [_goods parseFromDict:[dic objectForKey:@"data"]];
            
            
            NSMutableArray *temparr= [NSMutableArray array];
            [self.dataArray removeAllObjects];
            self.dataArray = temparr;
            [self insertFirstFloor];//添加第一层
            [self insertSecondFloor];//添加第二层
            [self insertThirdFloor];//添加第三层
            [self insertFourthFloor];//添加第四层
            [self insertFifthFloor];//第五层
            [self insertSixthFloor];//第六层
            [self insertSeventhFloor];//第七层
            [self insertEighthFloor];//第八层
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsDetailsServiceComplete:isSuccess:)]) {
                    [_delegate goodsDetailsServiceComplete:self isSuccess:YES];
                }
            });
            
            //商品详情
            [weakSelf.webView loadHTMLString:_goods.content baseURL:nil];
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsDetailsServiceComplete:isSuccess:)]) {
                    [_delegate goodsDetailsServiceComplete:weakSelf isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(goodsDetailsServiceComplete:isSuccess:)]) {
                [_delegate goodsDetailsServiceComplete:weakSelf isSuccess:NO];
            }
        });
    }];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self insertEighthFloor];//第八层
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(goodsContentComplete:isSuccess:)]) {
            [_delegate goodsContentComplete:self isSuccess:YES];
        }
    });
}



//图片楼层
-(void)insertFirstFloor{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:_goods.resource];
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品图片";
    floorDTO.moduleList =arr;
    floorDTO.hight = SCREEN_WIDTH;
    floorDTO.templateID = @"1";
    floorDTO.floors = 1;
    [self.dataArray addObject:floorDTO];
}
//描述楼层
-(void)insertSecondFloor{
    OptionModuleDTO *option =[_goods getSelectOptions];
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品描述";
    floorDTO.moduleList = [[NSMutableArray alloc] initWithArray:@[@{@"goods_name":_goods.goods_name,
                                                                    @"goods_num":_goods.goods_num,
                                                                    @"selling_price":option.selling_price,
                                                                    @"whole_price":option.whole_price}]];
    floorDTO.hight = -1;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}
//阶梯价
-(void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"阶梯价";
    floorDTO.moduleList = [[NSMutableArray alloc] initWithArray:@[@{@"goods":_goods}]];
    floorDTO.hight = [[ParameterPublic sharedManagered] client_view_goods_price]?-1:0;
    floorDTO.templateID = floorDTO.hight ==0?@"":@"9";
    floorDTO.floors = 1;
    [self.dataArray addObject:floorDTO];
}

//规格楼层
-(void)insertFourthFloor{
    HomeFloorDTO *floorDTO = [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品规格";
    floorDTO.floors = 1;
    floorDTO.moduleList = [[NSMutableArray alloc] initWithArray:@[@{@"goods":_goods}]];
    floorDTO.hight = [_goods.multi_data count] == 0 || [_goods.options isEqualToString:@"F"] || ![[ParameterPublic sharedManagered] goods_multi]?0:-1;
    floorDTO.templateID = floorDTO.hight ==0?@"":@"3";
    [self.dataArray addObject:floorDTO];
}
//数量楼层
-(void)insertFifthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName =@"商品数量";
    floorDTO.moduleList = [NSMutableArray arrayWithArray:@[@{@"goods":_goods}]];
    floorDTO.hight= -1;
    floorDTO.floors = 1;
    floorDTO.templateID = @"4";
    [self.dataArray addObject:floorDTO];
}

//促销楼层
-(void)insertSixthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName =@"促销";
    floorDTO.hight = 44;
    floorDTO.templateID = @"5";
    floorDTO.floors = 1;
//    [self.dataArray addObject:floorDTO];
}

//活动楼层
-(void)insertSeventhFloor{
    //模拟数据
    NSArray *arr = @[@{@"name":@"满赠",@"content":@"满100赠小蜜蜂一个"},@{@"name":@"套装",@"content":@"满100赠小蜜蜂一个"}];
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"活动";
    floorDTO.moduleList =[NSMutableArray arrayWithArray:arr];
    floorDTO.hight = 44;
    floorDTO.templateID = @"6";
    floorDTO.floors = [arr count];
//    [self.dataArray addObject:floorDTO];

}

//商品介绍
-(void)insertEighthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品介绍";
    floorDTO.floors = 1;
    floorDTO.templateID = @"7";
    floorDTO.is_showHeade = YES;
    floorDTO.hight = 220.0f;
    BOOL is_have = NO;
    for (int i = 0 ; i<[self.dataArray count]; i++)
    {
        HomeFloorDTO *dto = [self.dataArray objectAtIndex:i];
        if ([dto.floorName isEqualToString:@"商品介绍"])
        {
            is_have = YES;
            CGFloat width = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];
            //
            [self.webView stringByEvaluatingJavaScriptFromString:
             @"var imgs = document.querySelectorAll('img');for(var i =0;i<imgs.length;i++){imgs[i].style.width='100%';}"];
            CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]*SCREEN_WIDTH/width;
            CGRect frame = self.webView.frame;
            self.webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
            //模拟数据
            NSArray *arr = @[@{@"web":self.webView,@"content":_goods.content,@"field":_goods.field_data,@"goods":_goods.relation_data}];
            floorDTO.moduleList =[NSMutableArray arrayWithArray:arr];
            if (height != 0 || [_goods.field_data count] != 0)
            {
                floorDTO.hight = 15.0f+(10.0f+12.0f)*[_goods.field_data count]+20.0f+height;
            }
            [self.dataArray replaceObjectAtIndex:i withObject:floorDTO];
        }
    }
    
    if (!is_have)
    {
        NSArray *arr = @[@{@"web":self.webView,@"content":_goods.content,@"field":_goods.field_data,@"goods":_goods.relation_data}];
        floorDTO.moduleList =[NSMutableArray arrayWithArray:arr];
        [self.dataArray addObject:floorDTO];
    }
}


-(void)addShoppingCar:(void(^)(NSDictionary *data))back{
    DHBAddShoppingCarRequest *addShoppingCar = [[DHBAddShoppingCarRequest alloc] init];
    OptionModuleDTO *options = [self.goods getSelectOptions];
    addShoppingCar.number = options.number;
    addShoppingCar.price_id = options.price_id;
    addShoppingCar.options_id = options.options_id;
    addShoppingCar.goods_id = self.goods.goods_id;
    addShoppingCar.units = options.units;
    addShoppingCar.goods = self.goods;
    WS(weakSelf);
    [addShoppingCar postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        if ([[data objectForKey:@"code"] intValue] ==100)
        {
            back([data objectForKey:@"data"]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCarGoodsUpdate" object:nil userInfo:@{@"goods_list":[NSMutableArray arrayWithObjects:weakSelf.goods, nil]}];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

@end
