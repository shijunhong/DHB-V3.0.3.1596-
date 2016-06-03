//
//  ShoppingCarService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/7.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInformationModuleDTO.h"
#import "GoodsModuleDTO.h"

@class ShoppingCarService;
@protocol ShoppingCarServiceDelegate <NSObject>
@optional
- (void)shoppingCarServiceComplete:(ShoppingCarService *)service isSuccess:(BOOL)isSuccess;
- (void)shoppingCarServiceSubmit:(ShoppingCarService *)service isSuccess:(BOOL)isSuccess;
@end

@interface ShoppingCarService : NSObject
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)NSInteger code;
@property(nonatomic, assign)id<ShoppingCarServiceDelegate> delegate;
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger cpage;
@property(nonatomic, strong)NSMutableArray *goodslist;
@property(nonatomic, strong)UserInformationModuleDTO *userInformation;
/**
 *  查询数据
 */
- (void)queryGoodsData;

/**
 *  点击提交购物车 检查购物车数据
 *
 *  @param hidden_effect 是否隐藏数据请求加载效果
 */
- (void)submitShoppingCarWithHiddenEffect:(BOOL)hidden_effect;

/**
 *  删除购物车中数据
 *
 *  @param dto   商品
 *  @param block 回调
 */
- (void)DeleteShoppingCarGoods:(GoodsModuleDTO *)dto block:(void(^)(BOOL is_success))block;

/**
 *  计算 购物车金额，数量总数
 *
 *  @return
 */
-(NSDictionary*)getTotal;
@end
