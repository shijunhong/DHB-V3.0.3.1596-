//
//  DHBAddressListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddressListRequest.h"

@implementation DHBAddressListRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"addressList";
}

-(id)value{
    return @{};
}

@end
