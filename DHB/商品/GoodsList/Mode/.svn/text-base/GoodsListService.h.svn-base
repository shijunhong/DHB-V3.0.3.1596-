//
//  GoodsListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionModuleDTO.h"
#import "DHBAddShoppingCarRequest.h"

@class GoodsListService;
@protocol GoodsListServiceDelegate <NSObject>
@optional
- (void)goodsListServiceComplete:(GoodsListService *)service isSuccess:(BOOL)isSuccess;
@end

@interface GoodsListService : NSObject
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)id<GoodsListServiceDelegate> delegate;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger cpage;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, strong)NSMutableArray *goodslist;
@property(nonatomic, assign)NSInteger category_id;//分类：分类ID
@property(nonatomic, strong)NSString *search_content;//搜索：内容
@property(nonatomic, strong)NSString *goods_type;//筛选：商品类别 收藏，订过，新品，推荐等
@property(nonatomic, assign)NSInteger brand_id;//筛选：商品品牌
@property(nonatomic, strong)NSString *min_price;//筛选：最小价格
@property(nonatomic, strong)NSString *max_price;//筛选：最大价格
@property(nonatomic, strong)NSString *barcode;//搜索：二维码

/**
 *  商品列表查询
 */
- (void)queryGoodsData;
/**
 *  二维码查询商品
 */
- (void)barcodeQueryGoodsData;
/**
 *  提交购物车
 *
 *  @param goods 商品
 *  @param block 提交回调
 */
- (void)submitToShoppingCar:(GoodsModuleDTO *) goods complete: (void (^)(BOOL isSuccess, NSDictionary *responseDic)) block;
/**
 *  是否为全部商品（筛选 搜索 分类 条件为空）
 *
 *  @return
 */
- (BOOL)isAllGoods;



@end
