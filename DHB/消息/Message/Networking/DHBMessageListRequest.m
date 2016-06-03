//
//  DHBMessageListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageListRequest.h"

@implementation DHBMessageListRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgPostList";
}

-(id)value{
    return @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],
             @"step":[NSString stringWithFormat:@"%ld",(long)self.step]};
}

@end
