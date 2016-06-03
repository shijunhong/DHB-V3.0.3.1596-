//
//  选中 DHBReturnsGoodsModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/24/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModuleDTO.h"

@interface DHBReturnsGoodsModuleDTO : NSObject
@property(nonatomic,strong)NSString *orders_num;//订单ID
@property(nonatomic,assign)NSInteger orders_list_id;//订单商品ID
@property(nonatomic,assign)NSInteger goods_id;//对应商品ID
@property(nonatomic,strong)NSString *options_id;//订单规格
@property(nonatomic,assign)double returns_number;//订购数量
@property(nonatomic,strong)NSString *returns_price;//订购价格
@property(nonatomic,strong)GoodsModuleDTO *goods;//商品对象
@property(nonatomic,assign)BOOL is_select;//选中


- (void)parseFromDict:(NSDictionary *)dict;
@end
