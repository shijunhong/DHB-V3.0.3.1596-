//
//  DHBMessageSendRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/14.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageSendRequest.h"

@implementation DHBMessageSendRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"msgPostSend";
}

-(id)value{
    return @{@"post_title_id":self.post_title_id,
             @"content":self.content};
}


@end
