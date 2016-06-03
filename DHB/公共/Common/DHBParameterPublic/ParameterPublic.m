//
//  ParameterPublic.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ParameterPublic.h"

@implementation ParameterPublic

+(ParameterPublic *)sharedManagered
{
    static ParameterPublic *parameterPublic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parameterPublic = [[ParameterPublic alloc]init];
        
    });
    
    return parameterPublic;
}

#pragma mark - 初始化显示购物车数量的控件
-(JSBadgeView *)shoppingCarBadgeView{
    if (!_shoppingCarBadgeView)
    {
        _shoppingCarBadgeView = [[JSBadgeView alloc] init];
        [_shoppingCarBadgeView setBadgeBackgroundColor:[UIColor whiteColor]];
        [_shoppingCarBadgeView setBadgeMinWidth:5];
        [_shoppingCarBadgeView setBadgeTextFont:[UIFont systemFontOfSize:13]];
        [_shoppingCarBadgeView setBadgeTextColor:[UIColor TextRed_Color]];
    }
    return _shoppingCarBadgeView;
}

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    
    self.company_name = [dict EncodeStringFromDicWithKey: @"company_name"];
    self.company_id = [[dict EncodeNumberFromDicWithKey: @"company_id"] integerValue];
    self.cart_count = [[dict EncodeNumberFromDicWithKey:@"cart_count"] integerValue];
    self.accounts_name = [dict EncodeStringFromDicWithKey:@"accounts_name"];
    
    NSDictionary *open_set = [dict EncodeDicFromDicWithKey:@"open_set"];
    self.client_view_goods = [[open_set EncodeStringFromDicWithKey:@"client_view_goods"] isEqualToString:@"T"]?YES:NO;
    self.client_view_goods_price = [[open_set EncodeStringFromDicWithKey:@"client_view_goods_price"] isEqualToString:@"T"]?YES:NO;
    self.client_allow_order = [[open_set EncodeStringFromDicWithKey:@"client_allow_order"] isEqualToString:@"T"]?YES:NO;
    
    NSDictionary *goods_set = [dict EncodeDicFromDicWithKey:@"goods_set"];
    self.goods_multi = [[goods_set EncodeStringFromDicWithKey:@"goods_multi"] isEqualToString:@"T"]?YES:NO;
    self.goods_brand = [[goods_set EncodeStringFromDicWithKey:@"goods_brand"] isEqualToString:@"T"]?YES:NO;
    self.quantitative_accuracy = [[goods_set EncodeNumberFromDicWithKey:@"quantitative_accuracy"] intValue];
    self.price_accuracy = [[goods_set EncodeNumberFromDicWithKey:@"price_accuracy"] intValue];
    
    NSDictionary *order_set = [dict EncodeDicFromDicWithKey:@"order_set"];
    self.plain_invoice = [[order_set EncodeStringFromDicWithKey:@"plain_invoice"] isEqualToString:@"T"]?YES:NO;
    self.added_tax_invoice = [[order_set EncodeStringFromDicWithKey:@"added_tax_invoice"] isEqualToString:@"T"]?YES:NO;
    self.delivery_date = [[order_set EncodeStringFromDicWithKey:@"delivery_date"] isEqualToString:@"T"]?YES:NO;
    self.delivery_date_option = [[order_set EncodeStringFromDicWithKey:@"delivery_date_option"] isEqualToString:@"required"]?YES:NO;
    self.special_price = [[order_set EncodeStringFromDicWithKey:@"special_price"] isEqualToString:@"T"]?YES:NO;
    self.order_shipping = [[order_set EncodeStringFromDicWithKey:@"order_shipping"] isEqualToString:@"T"]?YES:NO;
    
    NSDictionary *inventory_set = [dict EncodeDicFromDicWithKey:@"inventory_set"];
    self.show_inventory = [[inventory_set EncodeStringFromDicWithKey:@"show_inventory"] isEqualToString:@"T"]?YES:NO;
    self.inventory_control = [[inventory_set EncodeStringFromDicWithKey:@"inventory_control"] isEqualToString:@"T"]?YES:NO;
}


@end
