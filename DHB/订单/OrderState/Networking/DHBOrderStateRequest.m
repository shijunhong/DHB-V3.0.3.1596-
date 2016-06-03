//
//  DHBOrderStateRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderStateRequest.h"

@implementation DHBOrderStateRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"ordersStatus";
}

-(id)value{
    return @{@"orders_id":self.orders_id};
}

@end
