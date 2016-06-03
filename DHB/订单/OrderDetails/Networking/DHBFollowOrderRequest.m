//
//  DHBFollowOrderRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/27.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFollowOrderRequest.h"

@implementation DHBFollowOrderRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"followOrder";
}

-(id)value{
    return @{@"orders_id":self.orders_id};
}
@end
