//
//  DHBPayHistorySiftingService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPayHistorySiftingService.h"
#import "DHBPayHistorySiftingRequest.h"

@implementation DHBPayHistorySiftingService
-(DHBPayHistorySiftingModuleDTO *)siftingDTO{
    if (!_siftingDTO)
    {
        _siftingDTO = [[DHBPayHistorySiftingModuleDTO alloc] init];
    }
    return _siftingDTO;
}


#pragma mark - 查询列表数据
- (void)querySiftingData{
    
    DHBPayHistorySiftingRequest *request = [[DHBPayHistorySiftingRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.siftingDTO parseFromDict: [dic objectForKey:@"data"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(payHistorySiftingService_Complete:isSuccess:)]) {
                [_delegate payHistorySiftingService_Complete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
    }];
}
@end
