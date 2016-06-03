//
//  DHBAddShoppingCarRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/8.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"
#import "GoodsModuleDTO.h"

@interface DHBAddShoppingCarRequest : DHBBaseNetworkRequest
@property(nonatomic ,assign)NSInteger goods_id;
@property(nonatomic ,assign)NSInteger price_id;
@property(nonatomic ,strong)NSString *options_id;
@property(nonatomic ,strong)NSString *number;
@property(nonatomic ,strong)NSString *units;
@property(nonatomic ,strong)GoodsModuleDTO *goods;
@property(nonatomic ,assign)BOOL is_delete;
@end
