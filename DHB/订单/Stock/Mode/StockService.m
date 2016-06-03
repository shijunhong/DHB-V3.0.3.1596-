//
//  StockService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "StockService.h"
#import "DHBStockRequest.h"
@implementation StockService
- (ShipsModuleDTO *)ships
{
    if (!_ships) {
        _ships=[[ShipsModuleDTO alloc]init];
    }
    return _ships;
}

-(void)queryOrderDetailData{
    
    TT_RELEASE_SAFELY(self.ships);
    DHBStockRequest *request = [[DHBStockRequest alloc] init];
    request.orders_id = self.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"%@",[[dic objectForKey:@"data"] EncodeDicFromDicWithKey:@"ships"]);
            [self.ships parseFromDict:[[dic objectForKey:@"data"] EncodeDicFromDicWithKey:@"ships"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(stockServiceComplete:isSuccess:)]) {
                    [_delegate stockServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(stockServiceComplete:isSuccess:)]) {
                    [_delegate stockServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(stockServiceComplete:isSuccess:)]) {
                [_delegate stockServiceComplete:self isSuccess:NO];
            }
        });
    }];
}
@end
