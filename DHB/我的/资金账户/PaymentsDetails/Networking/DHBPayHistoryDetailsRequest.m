//
//  DHBPayHistoryDetailsRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayHistoryDetailsRequest.h"

@implementation DHBPayHistoryDetailsRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"myPayinfoContent";
}

-(id)value{
    return @{@"receipts_id":@(self.receipts_id)};
}
@end
