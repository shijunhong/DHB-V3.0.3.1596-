//
//  ParameterPublic.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModuleDTO.h"
#import "DHBDeliveryMethodMoudleDTO.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "JSBadgeView.h"
@interface ParameterPublic : NSObject
+(ParameterPublic *)sharedManagered;


/**系统初始化S**/
@property(nonatomic,strong)NSString *deviceToken; //设备号
@property (nonatomic,readwrite)BOOL isactive; //标注程序是否是在前台运行
/**系统初始化E**/
@property(nonatomic,strong)CategoryModuleDTO *category; //分类ID
@property(nonatomic,assign)NSUInteger shoppingCarNum; //购物车商品数量
@property(strong, nonatomic)JSBadgeView *shoppingCarBadgeView;//显示购物车数量的控件
@property(nonatomic,assign)CLLocationCoordinate2D coord;//经纬坐标
@property(nonatomic,strong)AMapLocationReGeocode* geo;//地址信息
@property(nonatomic,strong)DHBDeliveryMethodMoudleDTO *deliveryInfo;//配送信息
@property(nonatomic,assign)BOOL noPic;//无图模式
@property(nonatomic,strong)NSMutableArray *upload_arr;//上传文件 数组(后台上传数据 持有住数据)
@property(nonatomic,assign)BOOL isMoreSupplier;//是否有多个供应商

/**系统配置**/
- (void)parseFromDict:(NSDictionary *)dict;
@property(nonatomic,assign)NSUInteger cart_count;//购物车数量
@property(nonatomic, retain) NSString *company_name; //供应商名称
@property(nonatomic,assign)NSUInteger company_id;//供应商ID
@property(nonatomic, retain) NSString *accounts_name; //账号名称

@property(nonatomic,assign)BOOL client_view_goods;//能否查看商品
@property(nonatomic,assign)BOOL client_view_goods_price;//能否查看商品价
@property(nonatomic,assign)BOOL client_allow_order;//是否可以订货
@property(nonatomic,assign)BOOL goods_multi;//启用多规格
@property(nonatomic,assign)BOOL goods_brand;//商品品牌
@property(nonatomic,assign)int  quantitative_accuracy;//数量的精度
@property(nonatomic,assign)int  price_accuracy;//价格的精度
@property(nonatomic,assign)BOOL plain_invoice;//开普通发票
@property(nonatomic,assign)BOOL added_tax_invoice;//增值税发票
@property(nonatomic,assign)BOOL delivery_date;//启用交货时间
@property(nonatomic,assign)BOOL delivery_date_option;//交货时间选填、必填
@property(nonatomic,assign)BOOL special_price;//启用订单特批价
@property(nonatomic,assign)BOOL order_shipping;//启用订单运费
@property(nonatomic,assign)BOOL show_inventory;//显示库存
@property(nonatomic,assign)BOOL inventory_control;//是否负库存订货


@end



