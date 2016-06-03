//
//  DHBDeliveryMethodRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDeliveryMethodRequest.h"

@implementation DHBDeliveryMethodRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"returnsSendMode";
}

-(id)value{
    return @{@"returns_id": self.returns_id,/** @"returns_send_mode": [self.deliveryMethodDTO send_mode], **/@"returns_send_date": [self.deliveryMethodDTO send_date],@"returns_send_company": [self.deliveryMethodDTO send_company],@"returns_send_no": [self.deliveryMethodDTO send_no], @"is_add": self.is_add};
}
@end
