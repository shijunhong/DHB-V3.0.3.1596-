//
//  DHBFinanceAccountService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/24.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFinanceAccountService.h"
#import "DHBMyDefaultInfoRequest.h"

@implementation DHBFinanceAccountService

- (void)queryFinanceAccountData{
    DHBMyDefaultInfoRequest*request = [[DHBMyDefaultInfoRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            self.myInfo = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"data"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(financeAccountServiceComplete:isSuccess:)]) {
                [_delegate financeAccountServiceComplete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(financeAccountServiceComplete:isSuccess:)]) {
                [_delegate financeAccountServiceComplete:self isSuccess:NO];
            }
        });
    }];
}

@end
