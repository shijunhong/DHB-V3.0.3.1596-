//
//  DHBUploadAttachmentRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBUploadAttachmentRequest.h"

@implementation DHBUploadAttachmentRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"uploadAttachment";
}

-(id)value{
//    for (NSDictionary* data in self.content)
//    {
//        [arr addObject:data];
//    }
    NSString *content  = [self toJSONData:self.content];
    NSLog_Red(@"%@",content);
    return @{@"content":content};
}

-(NSData *)uploadData{
    return self.file_value;
}

@end
