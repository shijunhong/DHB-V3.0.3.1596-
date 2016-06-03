//
//  DHBSubmitShoppingCarRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSubmitShoppingCarRequest.h"

@implementation DHBSubmitShoppingCarRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"cartSubmitCheck";
}

-(id)value{
    NSMutableArray *arr =[NSMutableArray array];
    for (GoodsModuleDTO *goods in self.goods_arr)
    {
        NSDictionary *dic = @{@"goods_id":[NSString stringWithFormat:@"%ld",(long)goods.goods_id],
                              @"price_id":[NSString stringWithFormat:@"%ld",(long)goods.price_id],
                              @"number":goods.number,
                              @"units":[NSString stringWithFormat:@"%@",goods.units]
                              };
        [arr addObject:dic];
    }
    NSString *cart  = [self toJSONData:arr];
    return @{@"cart":cart};
}

@end
