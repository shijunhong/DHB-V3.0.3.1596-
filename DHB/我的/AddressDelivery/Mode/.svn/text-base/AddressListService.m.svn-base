//
//  AddressListService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "AddressListService.h"
#import "DHBAddressListRequest.h"
#import "UserInformationModuleDTO.h"

@implementation AddressListService
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)queryAddressListlData{
    
    [self.dataArray removeAllObjects];
    DHBAddressListRequest *request = [[DHBAddressListRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Red(@"dic = %@",dic);
            NSArray *arr = [[dic objectForKey:@"data"] objectForKey:@"address"];
            self.dataArray = [NSMutableArray arrayWithCapacity: [arr count]];
            for (NSDictionary *dict in arr)
            {
                AddressModuleDTO *address = [[AddressModuleDTO alloc] init];
                [address parseFromDict:dict];
                if([[address is_default] isEqualToString: @"T"]){
                    [self.dataArray insertObject: address atIndex: 0];
                }
                else
                    [self.dataArray addObject:address];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(addressListServiceComplete:isSuccess:)]) {
                    [_delegate addressListServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(addressListServiceComplete:isSuccess:)]) {
                    [_delegate addressListServiceComplete:self isSuccess:NO];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(addressListServiceComplete:isSuccess:)]) {
                [_delegate addressListServiceComplete:self isSuccess:NO];
            }
        });
    }];
}
@end
