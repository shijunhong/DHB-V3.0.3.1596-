//
//  OrderModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModuleDTO.h"
#import "InvoiceModuleDTO.h"

//订单
@class ShipsModuleDTO;
@interface OrderModuleDTO : NSObject
@property(nonatomic,strong)NSString *orders_id;//订单ID
@property(nonatomic,strong)NSString *orders_num;//订单编号
@property(nonatomic,strong)NSString *orders_type;//订单类型 普通=’’, 特价，秒杀，期货
@property(nonatomic,strong)NSString *pay_status;//待付款,部分付款,已付款
@property(nonatomic,strong)NSString *ships_status;//物流状态 已审核，已出库等
@property(nonatomic,strong)NSString *discount_total;//结算价格
@property(nonatomic,strong)NSString *create_date;//下单时间
@property(nonatomic,strong)NSString *orders_total;//商品金额
@property(nonatomic,strong)NSString *invoice_price;//税费
@property(nonatomic,strong)NSString *freight;//运费
@property(nonatomic,strong)NSString *remark;//备注
@property(nonatomic,strong)NSString *delivery_date;//交货时间
@property(nonatomic,strong)NSString *consignee;//收货单位
@property(nonatomic,strong)NSString *consignee_contact;//联系人
@property(nonatomic,strong)NSString *consignee_phone;//联系方式
@property(nonatomic,strong)NSString *consignee_address;//收货地址
@property(nonatomic,assign)NSInteger goods_count;//商品个数
@property(nonatomic,strong)NSString *account_paid;//已付款金额
@property(nonatomic,strong)NSString *account_notpaid;//未付款金额
@property(nonatomic,strong)NSString *distrib_mode;//配送方式
@property(nonatomic,strong)NSString *apply_total;//特价金额
@property(nonatomic,assign)BOOL is_ship;//是否有收货
@property(nonatomic,assign)BOOL can_return;//是否可退货
@property(nonatomic,assign)BOOL is_follow;//是否关注
@property(nonatomic,assign)NSInteger attcount;//附件个数
@property(nonatomic,strong)InvoiceModuleDTO *invoice;//发票信息

@property(nonatomic,strong)NSString *status;//订单状态
@property(nonatomic,strong)NSString *invoice_tax;//税点
@property(nonatomic,strong)NSMutableArray *log_orders;//操作日志
@property(nonatomic,assign)NSInteger shipscount;//出库/发货记录个数
@property(nonatomic,strong)NSString *is_pay;//是否显示支付按钮

- (void)parseFromDict:(NSDictionary *)dict;
@end


//订单商品
@interface OrdersgoodsModuleDTO : NSObject
@property(nonatomic,strong)NSString *orders_num;//订单ID
@property(nonatomic,assign)NSInteger orders_list_id;//订单商品ID
@property(nonatomic,assign)NSInteger goods_id;//对应商品ID
@property(nonatomic,strong)NSString *options_id;//订单规格
@property(nonatomic,assign)double discount;//订单折扣
@property(nonatomic,strong)NSString *list_type;//商品种类 buy买得、gift赠得
@property(nonatomic,assign)double orders_number;//订购数量
@property(nonatomic,strong)NSString *orders_price;//订购价格
@property(nonatomic,strong)GoodsModuleDTO *goods;//商品对象
@property(nonatomic,assign)BOOL is_select;//选中
- (void)parseFromDict:(NSDictionary *)dict;
@end

//log_orders订单操作日志
@interface LogordersModuleDTO : NSObject
@property(nonatomic,assign)NSInteger track_id;//操作日志ID
@property(nonatomic,assign)NSInteger orders_id;//订单ID
@property(nonatomic,strong)NSString *operation;//操作
@property(nonatomic,strong)NSString *operation_name;//操作名称
@property(nonatomic,strong)NSString *remark;//操作说明
@property(nonatomic,strong)NSString *create_date;//日期
- (void)parseFromDict:(NSDictionary *)dict;
- (void)parseFromReturnedOrderDict:(NSDictionary *)dict;
@end

/**
 *  出库发货对象
 */
@interface ShipsModuleDTO : NSObject
@property(nonatomic,assign)NSInteger goodscount;//待出库商品种数
@property(nonatomic,strong)NSMutableArray *goodslist;//待出库商品列表
@property(nonatomic,strong)NSMutableArray *shipslist;//出库发货记录
- (void)parseFromDict:(NSDictionary *)dict;
@end

/**
 *  出库发货记录
 */
@interface ShipsChildModuleDTO : NSObject
@property(nonatomic,assign)NSInteger ships_id;//出库发货记录
@property(nonatomic,assign)NSInteger orders_id;//订单ID
@property(nonatomic,strong)NSString *ships_num;//出库发货编号
@property(nonatomic,strong)NSString *status;//状态(已收货,待收货,待发货,已取消)
@property(nonatomic,strong)NSString *ships_date;//发货时间
@property(nonatomic,assign)NSInteger logistics_id;//物流公司ID
@property(nonatomic,strong)NSString *logistics_name;//物流公司名称
@property(nonatomic,strong)NSString *logistics_code;//物流公司拼音
@property(nonatomic,strong)NSString *express_num;//物流单号
@property(nonatomic,strong)NSString *goods_count;//商品数量
- (void)parseFromDict:(NSDictionary *)dict;
@end

