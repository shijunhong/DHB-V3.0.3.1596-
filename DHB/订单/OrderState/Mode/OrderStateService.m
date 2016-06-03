//
//  OrderStateService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderStateService.h"
#import "HomeFloorDTO.h"
#import "DHBOrderStateRequest.h"

@implementation OrderStateService

- (NSMutableArray *)statelist
{
    if (!_statelist) {
        _statelist=[[NSMutableArray alloc]init];
    }
    return _statelist;
}

- (void)queryOrderStateData{
    [self.statelist removeAllObjects];
//    self.first = NO;
    DHBOrderStateRequest *request = [[DHBOrderStateRequest alloc] init];
    request.orders_id = self.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSArray *orders_flow = [[dic EncodeDicFromDicWithKey:@"data"] EncodeArrayFromDicWithKey:@"orders_flow"];
            NSArray *arr = [[orders_flow reverseObjectEnumerator] allObjects];
            BOOL first = NO;
            for (int i = 0 ;i<[arr count];i++)
            {
                NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithDictionary:[arr safeObjectAtIndex:i]];
                if (![[dto EncodeStringFromDicWithKey:@"create_date"] isEqualToString:@""] && !first)
                {
                    [dto setObject:@"1" forKey:@"is_red"];
                    first = YES;
                }
                else
                {
                    [dto setObject:@"0" forKey:@"is_red"];
                }
                [self.statelist addObject:dto];
            }
//            NSLog_Red(@"%@",self.statelist);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderStateServiceComplete:isSuccess:)]) {
                    [_delegate orderStateServiceComplete:self isSuccess:YES];
                }
            });
        }
        
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
    
}


@end
