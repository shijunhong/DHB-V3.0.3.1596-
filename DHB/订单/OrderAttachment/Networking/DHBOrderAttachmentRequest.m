//
//  DHBOrderAttachmentRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderAttachmentRequest.h"

@implementation DHBOrderAttachmentRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"getOrderAttachment";
}

-(id)value{
    return @{@"orders_id":self.orders_id};
}
@end
