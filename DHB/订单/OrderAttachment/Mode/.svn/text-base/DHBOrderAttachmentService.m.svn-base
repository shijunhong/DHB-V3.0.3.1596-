//
//  DHBOrderAttachmentService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderAttachmentService.h"

@implementation DHBOrderAttachmentService

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 查询订单附件
- (void)queryData {
    if(self.orders_id){
        DHBOrderAttachmentRequest *request = [[DHBOrderAttachmentRequest alloc] init];
        request.orders_id = self.orders_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            [GiFHUD dismiss];
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess)
            {
                for (NSString *str in [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"list"])
                {
                    DHBOrderAttachmentModuleDTO *dto = [[DHBOrderAttachmentModuleDTO alloc] init];
                    dto.attatchName = str;
                    [self.dataArray addObject:dto];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([_delegate respondsToSelector:@selector(orderAttachmentService_Compelete:isSuccess:)]) {
                    [_delegate orderAttachmentService_Compelete:self isSuccess:YES];
                }
            });
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            [GiFHUD dismiss];
            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
            self.error = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([_delegate respondsToSelector:@selector(orderAttachmentService_Compelete:isSuccess:)]) {
                    [_delegate orderAttachmentService_Compelete:self isSuccess:NO];
                }
            });
        }];
    }
}

#pragma mark - 查询退货附件
- (void)queryReturnsOrderData{
    if(self.returns_id){
        DHBReturnsAttachmentRequest *request = [[DHBReturnsAttachmentRequest alloc] init];
        request.returns_id = self.returns_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            [GiFHUD dismiss];
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess)
            {
                for (NSString *str in [[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"list"])
                {
                    DHBOrderAttachmentModuleDTO *dto = [[DHBOrderAttachmentModuleDTO alloc] init];
                    dto.attatchName = str;
                    [self.dataArray addObject:dto];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([_delegate respondsToSelector:@selector(orderAttachmentService_Compelete:isSuccess:)]) {
                    [_delegate orderAttachmentService_Compelete:self isSuccess:YES];
                }
            });
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            [GiFHUD dismiss];
            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
            self.error = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([_delegate respondsToSelector:@selector(orderAttachmentService_Compelete:isSuccess:)]) {
                    [_delegate orderAttachmentService_Compelete:self isSuccess:NO];
                }
            });
        }];
    }
}
@end
