//
//  DHBMessageRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/12.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageRequest.h"

@implementation DHBMessageRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgShowList";
}

-(id)value{
    return @{};
}

@end
