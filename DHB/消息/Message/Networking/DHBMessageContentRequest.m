//
//  DHBMessageContentRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageContentRequest.h"

@implementation DHBMessageContentRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgPostContent";
}

-(id)value{
    return @{@"post_title_id":self.post_title_id};
}
@end
