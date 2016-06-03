//
//  DHBOrdersListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrdersListRequest.h"

@implementation DHBOrdersListRequest

- (NSInteger)step{
    return 10;
}

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"ordersList";
}

-(id)value{
    return @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],
             @"step":[NSString stringWithFormat:@"%ld",(long)self.step],
             @"content":[NSString stringWithFormat:@"%@",self.content],
             @"is_attention":[NSString stringWithFormat:@"%@",self.is_attention],
             @"status":[NSString stringWithFormat:@"%@",[self.status isEqualToString:@"all"]?@"":self.status],
             @"pay_status":[NSString stringWithFormat:@"%@",[self.pay_status isEqualToString:@"all"]?@"":self.pay_status],
             @"begin_date":[NSString stringWithFormat:@"%@",self.begin_date],
             @"end_date":[NSString stringWithFormat:@"%@",self.end_date]};
}

@end
