//
//  ProductModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/27.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define GOODSTYPE_HEIGHT 20.0f
#define GOODSTYPE_WIDTH 22.0f
#import <Foundation/Foundation.h>
#import "OptionModuleDTO.h"
#import "MultiModuleDTO.h"

@interface GoodsModuleDTO : NSObject
                                           
@property(nonatomic, assign)NSInteger goods_id;// 商品ＩＤ
@property(nonatomic, strong)NSString* multi_id;//规格描述ID
@property(nonatomic, strong)NSString *goods_type;//商品类型
@property(nonatomic, strong)NSString* goods_num;//商品编号
@property(nonatomic, strong)NSString* goods_name;//商品名称
@property(nonatomic, strong)NSString* goods_model;//商品型号
@property(nonatomic, strong)NSString* goods_picture;//商品图片
@property(nonatomic, strong)NSString* whole_price;//商品价格
@property(nonatomic, strong)NSString *selling_price;//零售价
@property(nonatomic, strong)NSString* base_units;//基本单位
@property(nonatomic, strong)NSString* container_units;//辅助单位
@property(nonatomic, strong)NSString* conversion_number;//换算关系
@property(nonatomic, strong)NSString* order_units;//起订单位
@property(nonatomic, strong)NSString* min_order;//起订量
@property(nonatomic, strong)NSString* options;//是否有多规格T/F
@property(nonatomic, assign)NSInteger price_count;//多少种规格
@property(nonatomic, strong)NSString *content;//商品详情描述
@property(nonatomic, strong)NSMutableArray* options_data;//多规格数据
@property(nonatomic, strong)NSArray* resource;//商品图片
@property(nonatomic, strong)NSMutableArray *multi_data;//规格数据
@property(nonatomic, strong)NSMutableArray *field_data;//行业特征
@property(nonatomic, strong)NSMutableArray *relation_data;//相关商品
@property(nonatomic, assign)BOOL is_follow;//是否关注
@property(nonatomic, assign)BOOL is_out_of_stock;//是否缺货
@property(nonatomic, strong)NSString *available_number;//购物车提交库存超过返回
@property(nonatomic, strong)NSString *min_number;//购物车提交起订量未超过返回
@property(nonatomic, assign)BOOL in_cart;//是否在购物车
- (void)parseFromDict:(NSDictionary *)dict;//商品获取数据

@property(nonatomic, strong)OptionModuleDTO *defaultOption;//默认规格
@property(nonatomic, strong)NSString *number;//数量
@property(nonatomic, assign)NSInteger price_id;//价格ID
@property(nonatomic, strong)NSString *units;//单位(购物车用)
@property(nonatomic, strong)NSString *inventory_number;//默认库存(购物车用)
@property(nonatomic, strong)NSString *options_id;//默认规格(购物车用)
- (void)parseFromDict_shoppingCar:(NSDictionary *)dict;//购物车获取数据
- (void)parseFromDict_goodsList:(NSDictionary *)dict;//商品列表获取数据
- (OptionModuleDTO*)getSelectOptions;//获取选中得Options
-(BOOL)CheckIsMoreUnit;//判断是否有多个单位
-(NSString *)getnumberPrice:(NSString *)number price_id:(NSUInteger)price_id;//根据数据获取阶梯价方法
-(NSString*)getSelectAvailable;//获取选中库存
-(MultiModuleDTO *)getMultiWithChildMultiId:(NSString*)multi_id;//根据MultiChild ID 获取 Multi
-(MultiChildModuleDTO *)getMultiChildWithChildMultiId:(NSString*)multi_id;//根据MultiChild ID 获取 MultiChild
-(BOOL)getReverMutiWithChildMultiId:(NSString*)multi_id;//判断是否选中
-(void)updateMultiDisEnableWithMultiId:(NSString*)multi_id;//根据MultiChildModuleDTO.multi_id 修改Multi 得置灰状态
-(void)updateMultiSelectWithMultiId:(NSString*)multi_id; //根据MultiChildModuleDTO.multi_id 修改Multi 得选中状态
- (void)showGoodsTypeViewInParentView:(UIView *)parentView shadowView:(UIImageView *)shadowView; ///在指定的父视图中显示goods_type的子视图
@end
