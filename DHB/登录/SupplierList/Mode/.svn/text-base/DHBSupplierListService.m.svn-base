//
//  DHBSupplierListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSupplierListService.h"

@implementation DHBSupplierListService
#pragma mark - getters and setters
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 查询数据
/**
 *  供应商数据列表查询接口
 */
- (void)querDataList{
    DHBSupplierListRequest *request = [[DHBSupplierListRequest alloc] init];
    request.skey = self.skey;
    [request setHidden_effect: YES];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        self.message = [dic objectForKey: @"message"];
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if(isSueccess){
            [self.dataArray removeAllObjects];
            for(NSDictionary *tmpDictionary in [[dic objectForKey:@"data"] objectForKey: @"company"]){
                DHBSupplierModuleDTO *dto = [[DHBSupplierModuleDTO alloc] init];
                [dto parseWithDic: tmpDictionary];
                [self.dataArray addObject: dto];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBSupplierListService_Compelete:isSueccess:)]) {
                [_delegate DHBSupplierListService_Compelete: self isSueccess: isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBSupplierListService_Compelete:isSueccess:)]) {
                [_delegate DHBSupplierListService_Compelete: self isSueccess: NO];
            }
        });
    }];
}

#pragma mark - 选择供应商
/**
 *  选中指定供应商接口
 */
- (void)selectSupplier{
    DHBSelectSupplierRequest *request = [[DHBSelectSupplierRequest alloc] init];
    request.skey = self.skey;
    request.company_id = self.company_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        self.message = [dic objectForKey: @"message"];
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if(isSueccess){
            isSueccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBSupplierListService_SelectedSupplier:isSueccess:)]) {
                [_delegate DHBSupplierListService_SelectedSupplier: self isSueccess: isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(DHBSupplierListService_SelectedSupplier:isSueccess:)]) {
                [_delegate DHBSupplierListService_SelectedSupplier: self isSueccess: NO];
            }
        });
    }];
}


@end
