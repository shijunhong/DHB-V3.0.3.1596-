//
//  DHBPaymentHistoryRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentHistoryRequest.h"

@implementation DHBPaymentHistoryRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"myFinancePayinfo";
}

-(id)value{
    return @{@"status_id": (self.status_id ? self.status_id : @""), @"type_id": (self.type_id ? self.type_id : @""), @"begin_date": (self.begin_date ? self.begin_date : @""), @"end_date": (self.end_date ? self.end_date : @"")};
}
@end
