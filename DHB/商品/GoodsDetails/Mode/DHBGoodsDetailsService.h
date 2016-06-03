//
//  DHBProductDetailsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "GoodsModuleDTO.h"
@class DHBGoodsDetailsService;
@protocol GoodsDetailsServiceDelegate <NSObject>
@optional
- (void)goodsDetailsServiceComplete:(DHBGoodsDetailsService *)service isSuccess:(BOOL )isSuccess;

- (void)goodsContentComplete:(DHBGoodsDetailsService *)service isSuccess:(BOOL )isSuccess;
@end


@interface DHBGoodsDetailsService : NSObject<UIWebViewDelegate>
@property(nonatomic,strong)GoodsModuleDTO *goods;
@property(nonatomic,strong)UIWebView *webView;
@property (nonatomic, assign) id<GoodsDetailsServiceDelegate> delegate;
//商品列表数据
@property (nonatomic, strong)NSMutableArray *dataArray;
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)NSInteger goods_id;//外部传入商品 需要由该商品 查询商品详细数据

@property(nonatomic, assign)NSInteger price_id;
@property(nonatomic, strong)NSString *goods_num;
@property(nonatomic, strong)OptionModuleDTO *defaultOption;//默认规格
/**
 *  获取商品数据
 *
 *  方法内部自动获取这些参数
 */
- (void)queryGoodsDetailData;

/**
 *  加入购物车
 *
 *  @param back 提交时返回参数
 */
-(void)addShoppingCar:(void(^)(NSDictionary *data))back;

@end
