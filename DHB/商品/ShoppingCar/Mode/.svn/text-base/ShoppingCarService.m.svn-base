//
//  ShoppingCarService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/7.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ShoppingCarService.h"
#import "DHBShoppingCarRequest.h"
#import "GoodsModuleDTO.h"
#import "DHBSubmitShoppingCarRequest.h"
#import "DHBAddShoppingCarRequest.h"
#import "DHBTipView.h"
@implementation ShoppingCarService


- (void)queryGoodsData {
    DHBShoppingCarRequest *request = [[DHBShoppingCarRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *data = [dic objectForKey:@"data"];
//            NSLog_Blue(@"%@",data);
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            [[ParameterPublic sharedManagered] setCart_count:self.count];
            NSArray *arr = [data EncodeArrayFromDicWithKey:@"list"];
            self.goodslist = [NSMutableArray array];
            for (NSDictionary *dic in arr)
            {
                GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
                [goods parseFromDict_shoppingCar:dic];
                [self.goodslist addObject:goods];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceComplete:isSuccess:)]) {
                    [_delegate shoppingCarServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceComplete:isSuccess:)]) {
                    [_delegate shoppingCarServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceComplete:isSuccess:)]) {
                [_delegate shoppingCarServiceComplete:self isSuccess:NO];
            }
        });
    }];
}

- (void)submitShoppingCarWithHiddenEffect:(BOOL)hidden_effect{
    DHBSubmitShoppingCarRequest *request = [[DHBSubmitShoppingCarRequest alloc] init];
    request.goods_arr = self.goodslist;
    request.hidden_effect = hidden_effect;
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        self.code = [[data objectForKey:@"code"] intValue];
        if ([[data objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *dic = [data objectForKey:@"data"];
//            NSLog_Blue(@"%@",data);
            if ([[dic EncodeStringFromDicWithKey:@"is_success"] isEqualToString:@"1"])//提交成功
            {
                self.userInformation = [[UserInformationModuleDTO alloc] init];
                [self.userInformation parseFromDict:dic];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCarGoodsUpdate" object:nil userInfo:@{@"goods_list":weakSelf.goodslist}];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceSubmit:isSuccess:)]) {
                        [_delegate shoppingCarServiceSubmit:self isSuccess:YES];
                    }
                });
            }
            else//提交不成功 显示库存 起订量不够
            {
                [self.goodslist removeAllObjects];
                for (NSDictionary *dict in [dic EncodeArrayFromDicWithKey:@"list"])
                {
                    GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
                    [goods parseFromDict_shoppingCar:dict];
                    [self.goodslist addObject:goods];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceSubmit:isSuccess:)]) {
                        [_delegate shoppingCarServiceSubmit:self isSuccess:NO];
                    }
                });
            }
        }
        else if([[data objectForKey:@"code"] intValue] == 300)
        {
            [[[DHBTipView alloc] init] showInSuperView:[[UIApplication sharedApplication] keyWindow] message:[data objectForKey: @"message"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceSubmit:isSuccess:)]) {
                    [_delegate shoppingCarServiceSubmit:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarServiceSubmit:isSuccess:)]) {
                [_delegate shoppingCarServiceSubmit:self isSuccess:NO];
            }
        });
    }];
}



-(void)DeleteShoppingCarGoods:(GoodsModuleDTO *)dto block:(void (^)(BOOL))block{
    //从购物车删除商品
    DHBAddShoppingCarRequest *addShoppingCar = [[DHBAddShoppingCarRequest alloc] init];
    addShoppingCar.number = @"0";
    addShoppingCar.price_id = dto.price_id;
    addShoppingCar.goods_id = dto.goods_id;
    addShoppingCar.units = dto.units;
    addShoppingCar.options_id = @"";
    addShoppingCar.is_delete = YES;
    [addShoppingCar postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        block(YES);
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        block(NO);
    }];
}


-(NSDictionary*)getTotal{
    double total_price = 0.0;
    NSString *price;
    NSInteger total_num = [self.goodslist count];
    for (GoodsModuleDTO *goods in self.goodslist)
    {
        double number = [goods.units isEqualToString:@"base_units"]?[goods.number doubleValue]:[goods.conversion_number doubleValue]*[goods.number doubleValue];
        price = [goods getnumberPrice:[NSString stringWithFormat:@"%lf",number] price_id:goods.price_id];
        total_price += [price doubleValue]*number;
    }
    TT_RELEASE_SAFELY(price);
    
    /**
     *  发票的金额
     */
    if(self.userInformation){
        switch (self.userInformation.venders.invoice_type) {
            case PT:
                total_price += total_price * 0.03;
                break;
            case ZZ:
                total_price += total_price * 0.04;
                break;
            default:
                break;
        }
    }
    
    return  @{@"total_price":@(total_price),
              @"total_num":@(total_num)};
}

@end
