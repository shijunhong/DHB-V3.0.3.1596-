//
//  DHBAboutRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/29/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAboutRequest.h"

@implementation DHBAboutRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"aboutDHB";
}

-(id)value{
    return @{@"device_type": @"iOS",
             @"current_version":@"iOS"};
}
@end
