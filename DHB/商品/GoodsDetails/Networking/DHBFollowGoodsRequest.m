//
//  DHBFollowGoodsRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/25.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFollowGoodsRequest.h"

@implementation DHBFollowGoodsRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"followGoods";
}

-(id)value{
    return @{@"goods_id":[NSString stringWithFormat:@"%ld",(long)self.goods_id]};
}


@end
