//
//  DHBMyDefaultInfoRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/24/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMyDefaultInfoRequest.h"

@implementation DHBMyDefaultInfoRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"myInfo";
}

-(id)value{
    return @{};
}
@end
