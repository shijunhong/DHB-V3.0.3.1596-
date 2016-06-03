//
//  DHBPaymentsSiftingService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsSiftingService.h"

@implementation DHBPaymentsSiftingService
#pragma mark - init
- (DHBPaymentsSiftingMOduleDTO *)siftingDTO{
    if(!_siftingDTO){
        _siftingDTO = [[DHBPaymentsSiftingMOduleDTO alloc] init];
    }
    return _siftingDTO;
}

#pragma mark - 查询列表数据
- (void)querySiftingData{
    
    DHBPaymentsSiftingRequest *request = [[DHBPaymentsSiftingRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.siftingDTO parseFromDict: [dic objectForKey:@"data"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(paymentsSiftingService_Complete:isSuccess:)]) {
                [_delegate paymentsSiftingService_Complete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
    }];
}


@end
