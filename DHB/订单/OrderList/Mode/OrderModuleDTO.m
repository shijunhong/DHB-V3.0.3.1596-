//
//  OrderModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderModuleDTO.h"

@implementation OrderModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.create_date = [dict EncodeStringFromDicWithKey:@"create_date"];
    self.discount_total =[dict EncodeStringFromDicWithKey:@"discount_total"];
    self.pay_status =[dict EncodeStringFromDicWithKey:@"pay_status"];
    self.orders_id =[dict EncodeStringFromDicWithKey:@"orders_id"];
    self.orders_num =[dict EncodeStringFromDicWithKey:@"orders_num"];
    self.orders_type =[dict EncodeStringFromDicWithKey:@"orders_type"];
    self.ships_status =[dict EncodeStringFromDicWithKey:@"ships_status"];
    self.orders_total =[dict EncodeStringFromDicWithKey:@"orders_total"];
    self.freight =[dict EncodeStringFromDicWithKey:@"freight"];
    self.remark =[dict EncodeStringFromDicWithKey:@"remark"];
    self.delivery_date =[dict EncodeStringFromDicWithKey:@"delivery_date"];
    self.consignee = [dict EncodeStringFromDicWithKey:@"consignee"];
    self.consignee_contact = [dict EncodeStringFromDicWithKey:@"consignee_contact"];
    self.consignee_phone = [dict EncodeStringFromDicWithKey:@"consignee_phone"];
    self.consignee_address = [dict EncodeStringFromDicWithKey:@"consignee_address"];
    self.goods_count = [[dict EncodeNumberFromDicWithKey:@"goods_count"] integerValue];
    self.account_paid = [dict EncodeStringFromDicWithKey:@"account_paid"];
    self.account_notpaid = [dict EncodeStringFromDicWithKey:@"account_notpaid"];
    self.distrib_mode = [dict EncodeStringFromDicWithKey:@"distrib_mode"];
    self.shipscount = [[dict EncodeNumberFromDicWithKey:@"shipscount"] integerValue];
    self.status = [dict EncodeStringFromDicWithKey:@"status"];
    self.is_pay = [dict EncodeStringFromDicWithKey:@"is_pay"];
    self.apply_total = [dict EncodeStringFromDicWithKey:@"apply_total"];
    self.is_ship = [[dict EncodeStringFromDicWithKey:@"is_ship"] isEqualToString:@"T"]?YES:NO;
    self.can_return = [[dict EncodeStringFromDicWithKey:@"can_return"] isEqualToString:@"T"]?YES:NO;
    self.is_follow = [[dict EncodeStringFromDicWithKey:@"is_follow"] isEqualToString:@"T"]?YES:NO;
    self.attcount = [[dict EncodeNumberFromDicWithKey:@"attcount"] integerValue];
    
    self.invoice = [[InvoiceModuleDTO alloc] init];
    [self.invoice parseFromDict:[dict EncodeDicFromDicWithKey:@"invoice"]];
    self.invoice_tax = [dict EncodeStringFromDicWithKey:@"invoice_tax"];
    self.invoice_price = [dict EncodeStringFromDicWithKey:@"invoice_price"];
    
    self.log_orders = [NSMutableArray array];
     NSMutableArray *logorders_arr = [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"log_orders"]];
    for (NSDictionary *dic in logorders_arr)
    {
        LogordersModuleDTO *logorder = [[LogordersModuleDTO alloc] init];
        [logorder parseFromDict:dic];
        [self.log_orders addObject:logorder];
    }
    
//    self.orderslist = [NSMutableArray array];
//    NSMutableArray *ordersGoods_arr = [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"orderslist"]];
//    for (NSDictionary *dic in ordersGoods_arr)
//    {
//        OrdersgoodsModuleDTO *ordersgoods = [[OrdersgoodsModuleDTO alloc] init];
//        [ordersgoods parseFromDict:dic];
//        [self.orderslist addObject:ordersgoods];
//    }
    
//    self.ships = [[ShipsModuleDTO alloc] init];
//    [self.ships parseFromDict:[dict EncodeDicFromDicWithKey:@"ships"]];
}

@end


@implementation OrdersgoodsModuleDTO
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.orders_num = [dict EncodeStringFromDicWithKey: @"orders_num"];
    self.orders_list_id = [[dict EncodeNumberFromDicWithKey:@"orders_list_id"] integerValue];
    self.goods_id = [[dict EncodeNumberFromDicWithKey:@"goods_id"] integerValue];
    self.options_id = [dict EncodeStringFromDicWithKey:@"options_id"];
    self.discount = [[dict EncodeNumberFromDicWithKey:@"discount"] doubleValue];
    self.list_type = [dict EncodeStringFromDicWithKey:@"list_type"];
    self.orders_number = [[dict EncodeNumberFromDicWithKey:@"orders_number"] doubleValue];
    self.orders_price = [dict EncodeStringFromDicWithKey:@"orders_price"];
    self.goods = [[GoodsModuleDTO alloc] init];
    [self.goods parseFromDict_shoppingCar:[dict EncodeDicFromDicWithKey:@"goods"]];
}
@end

@implementation LogordersModuleDTO
#pragma mark - 默认的通过字典解析
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.track_id = [[dict EncodeNumberFromDicWithKey:@"track_id"] integerValue];
    self.orders_id = [[dict EncodeNumberFromDicWithKey:@"orders_id"] integerValue];
    self.operation = [dict EncodeStringFromDicWithKey:@"operation"];
    self.operation_name = [dict EncodeStringFromDicWithKey:@"operation_name"];
    self.remark = [dict EncodeStringFromDicWithKey:@"remark"];
    self.create_date = [dict EncodeStringFromDicWithKey:@"create_date"];
}

#pragma mark - 通过退货单字典解析
- (void)parseFromReturnedOrderDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.track_id = [[dict EncodeNumberFromDicWithKey:@"track_id"] integerValue];
    self.orders_id = [[dict EncodeNumberFromDicWithKey:@"returns_id"] integerValue];
    self.operation = [dict EncodeStringFromDicWithKey:@"operation"];
    self.operation_name = [dict EncodeStringFromDicWithKey:@"operation_name"];
    self.remark = [dict EncodeStringFromDicWithKey:@"remark"];
    self.create_date = [dict EncodeStringFromDicWithKey:@"create_date"];
}
@end


@implementation ShipsModuleDTO
-(void)parseFromDict:(NSDictionary *)dict{
    if (IsNilOrNull(dict)) {
        return;
    }
    self.goodscount = [[dict EncodeNumberFromDicWithKey:@"goodscount"] integerValue];
    self.goodslist = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"goodslist"]]) {
        OrdersgoodsModuleDTO *ordersgoods = [[OrdersgoodsModuleDTO alloc] init];
        [ordersgoods parseFromDict:dic];
        [self.goodslist addObject:ordersgoods];
    }
    
    self.shipslist = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"shipslist"]]) {
        ShipsChildModuleDTO *shipsChild =[[ShipsChildModuleDTO alloc] init];
        [shipsChild parseFromDict:dic];
        [self.shipslist addObject:shipsChild];
    }
}
@end

@implementation ShipsChildModuleDTO
-(void)parseFromDict:(NSDictionary *)dict{
    if (IsNilOrNull(dict)) {
        return;
    }
    self.ships_id = [[dict EncodeNumberFromDicWithKey:@"ships_id"] integerValue];
    self.orders_id = [[dict EncodeNumberFromDicWithKey:@"orders_id"] integerValue];
    self.ships_num = [dict EncodeStringFromDicWithKey:@"ships_num"];
    self.status = [dict EncodeStringFromDicWithKey:@"status"];
    self.ships_date = [dict EncodeStringFromDicWithKey:@"ships_date"];
    self.logistics_id = [[dict EncodeNumberFromDicWithKey:@"logistics_id"] integerValue];
    self.logistics_name = [dict EncodeStringFromDicWithKey:@"logistics_name"];
    self.logistics_code = [dict EncodeStringFromDicWithKey:@"logistics_code"];
    self.express_num = [dict EncodeStringFromDicWithKey:@"express_num"];
    self.goods_count = [dict EncodeStringFromDicWithKey:@"goods_count"];
}
@end

