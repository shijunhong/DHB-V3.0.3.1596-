//
//  DHBShoppingCarRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/7.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShoppingCarRequest.h"

@implementation DHBShoppingCarRequest


-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"cartListGoods";
}

-(id)value{
    return @{};
}

@end
