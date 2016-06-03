//
//  DHBMessageAfficheListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/14.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageAfficheListRequest.h"

@implementation DHBMessageAfficheListRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgAfficheList";
}

-(id)value{
    return @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],
             @"step":[NSString stringWithFormat:@"%ld",(long)self.step],
             @"title_value":self.title_value};
}

@end
