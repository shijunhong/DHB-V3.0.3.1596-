//
//  LogisticsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "LogisticsService.h"
#import "HomeFloorDTO.h"
#import "DHBGetLogisticsRequest.h"
@implementation LogisticsService

- (NSMutableArray *)logisticslist
{
    if (!_logisticslist) {
        _logisticslist=[[NSMutableArray alloc]init];
    }
    return _logisticslist;
}

- (void)queryLogisticsData{
    
    DHBGetLogisticsRequest *request =  [[DHBGetLogisticsRequest alloc] init];
    request.express_name = self.ships.logistics_code?self.ships.logistics_code:@"";
    request.express_number = self.ships.express_num;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            [self.logisticslist removeAllObjects];
            for (int i = 0 ; i<[[dic EncodeArrayFromDicWithKey:@"data"] count]; i++)
            {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[dic EncodeArrayFromDicWithKey:@"data"] safeObjectAtIndex:i]];
                [dict setObject:@"0" forKey:@"is_red"];
                [dict setObject:@"1" forKey:@"is_line"];
                if (i==0)
                {
                    [dict setObject:@"1" forKey:@"is_red"];
                }
                if (i== [[dic EncodeArrayFromDicWithKey:@"data"] count]-1)
                {
                    [dict setObject:@"0" forKey:@"is_line"];
                }
                [self.logisticslist addObject:dict];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(logisticsServiceComplete:isSuccess:)]) {
                    [_delegate logisticsServiceComplete:self isSuccess:YES];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(logisticsServiceComplete:isSuccess:)]) {
                [_delegate logisticsServiceComplete:self isSuccess:NO];
            }
        });
    }];
}



@end
