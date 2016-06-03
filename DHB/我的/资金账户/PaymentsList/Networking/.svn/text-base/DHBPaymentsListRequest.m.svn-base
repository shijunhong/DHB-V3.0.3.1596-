//
//  DHBPaymentsListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsListRequest.h"

@implementation DHBPaymentsListRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"myFinanceDeposit";
}

-(id)value{
    return @{@"incexp_id": (self.deposit_type ? self.deposit_type : @""), @"type_id": (self.type_id ? self.type_id : @""), @"begin_date": (self.begin_date ? self.begin_date : @""), @"end_date": (self.end_date ? self.end_date : @"")};
}
@end
