//
//  ReturnsOrderDetailsRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "ReturnsOrderDetailsRequest.h"

@implementation ReturnsOrderDetailsRequest
@synthesize orderID;
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"";
}

-(id)value{
    return [NSDictionary dictionaryWithObject: orderID forKey: @"orders_id"];
}
@end
