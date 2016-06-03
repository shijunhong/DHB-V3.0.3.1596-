//
//  GoodsListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "GoodsListService.h"
#import "DHBGoodsListRequest.h"
#import "GoodsModuleDTO.h"
#import "DHBBarcodeSearchRequest.h"
@implementation GoodsListService

//-(NSMutableArray *)goodslist{
//    if (!_goodslist)
//    {
//        _goodslist = [NSMutableArray array];
//    }
//    return _goodslist;
//}

- (void)queryGoodsData {
    DHBGoodsListRequest *request = [[DHBGoodsListRequest alloc] init];
    request.step = 10;
    request.page = self.page;
    request.category_id = self.category_id;
    request.min_price = self.min_price;
    request.search_content = self.search_content;
    request.max_price = self.max_price;
    request.goods_type = (self.goods_type ? self.goods_type : @"0");
    request.brand_id = self.brand_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            NSDictionary *data = [dic objectForKey:@"data"];
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage =  (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
            NSArray *arr =  [data objectForKey:@"list"];
            self.goodslist = [NSMutableArray array];
            for (NSDictionary *dic in arr)
            {
                GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
                [goods parseFromDict_goodsList:dic];
                [self.goodslist addObject:goods];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                    [_delegate goodsListServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                    [_delegate goodsListServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                [_delegate goodsListServiceComplete:self isSuccess:NO];
            }
        });
    }];
}


- (void)barcodeQueryGoodsData {
    DHBBarcodeSearchRequest *request = [[DHBBarcodeSearchRequest alloc] init];
    request.page = self.page;
    request.barcode = self.barcode;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
            NSDictionary *data = [dic objectForKey:@"data"];
            self.count = [[data EncodeNumberFromDicWithKey:@"count"] integerValue];
            self.cpage = [[data EncodeNumberFromDicWithKey:@"cpage"] integerValue];
            self.totalPage =  (self.count % request.step > 0 ? (self.count / request.step + 1) : self.count / request.step);
            NSArray *arr =  [data objectForKey:@"list"];
            self.goodslist = [NSMutableArray array];
            for (NSDictionary *dic in arr)
            {
                GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
                [goods parseFromDict:dic];
                [self.goodslist addObject:goods];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                    [_delegate goodsListServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                    [_delegate goodsListServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(goodsListServiceComplete:isSuccess:)]) {
                [_delegate goodsListServiceComplete:self isSuccess:NO];
            }
        });
    }];
}


#pragma mark - 提交到购物车
- (void)submitToShoppingCar:(GoodsModuleDTO *) goods complete: (void (^)(BOOL isSuccess, NSDictionary *responseDic)) block{
    DHBAddShoppingCarRequest *addShoppingCar = [[DHBAddShoppingCarRequest alloc] init];
    OptionModuleDTO *option = [goods getSelectOptions];
    addShoppingCar.number = option.number;
    addShoppingCar.price_id = option.price_id;
    addShoppingCar.goods_id = goods.goods_id;
    addShoppingCar.units = option.units;
    addShoppingCar.options_id = @"0";
    addShoppingCar.goods = goods;
    [addShoppingCar postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        BOOL isSuccess = ([[data objectForKey:@"code"] intValue] ==100 ? YES : NO);
        dispatch_async(dispatch_get_main_queue(), ^{
            block(isSuccess, data);
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

-(BOOL)isAllGoods{
    BOOL validate = YES;
    if (self.category_id != 0 )
    {
        validate = NO;
    }
    if (self.search_content && (![self.search_content isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.goods_type && (![self.goods_type isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.brand_id != 0 )
    {
        validate = NO;
    }
    if (self.min_price && (![self.min_price isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.max_price && (![self.max_price isEqualToString:@""]))
    {
        validate = NO;
    }
    if (self.barcode && (![self.barcode isEqualToString:@""]))
    {
        validate = NO;
    }
    return validate;
}




@end
