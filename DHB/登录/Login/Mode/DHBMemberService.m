//
//  DHBMemberService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMemberService.h"

@implementation DHBMemberService

#pragma mark - init
- (NSMutableArray *)loginRecordArray{
    if(!_loginRecordArray){
        _loginRecordArray = [NSMutableArray array];
    }
    return _loginRecordArray;
}

- (NSMutableArray *)supplierArray{
    if(!_supplierArray){
        _supplierArray = [NSMutableArray array];
    }
    return _supplierArray;
}

#pragma mark -
- (FMDatabase *)openRecordDatabase
{
    NSString *databasePath = [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES))[0] stringByAppendingString: [NSString stringWithFormat: @"/%@",LOCAL_DATABASE]];
    return [FMDatabase databaseWithPath: databasePath];
}

- (BOOL)queryRecordDataFromDatabase{
    FMDatabase *database = [self openRecordDatabase];
    BOOL isOpen = [database open];
    if(isOpen){
        BOOL isSuccess = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS LoginRecord(phone text,addTime datetime)"];
        if(isSuccess){
            FMResultSet *dataSet = [database executeQuery:@"SELECT * FROM LoginRecord ORDER BY addTime DESC"];
            [self.loginRecordArray removeAllObjects];
            while ([dataSet next]) {
                LoginRecordMouleDTO *record = [[LoginRecordMouleDTO alloc] init];
                [record parseFromSet: dataSet];
                [self.loginRecordArray addObject: record];
            }
        }
        [database close];
    }
    return isOpen;
}

#pragma mark 查询登录的历史纪录
- (void)queryLoginRecordData{
    if([_delegate respondsToSelector: @selector(memberService_Complete:isSuccess:)]){
        [_delegate memberService_Complete: self isSuccess: [self queryRecordDataFromDatabase]];
    }
}

#pragma mark 更新历史纪录
- (void)updateLoginRecordData{
    if([_delegate respondsToSelector: @selector(memberService_Update:isSuccess:)]){
        [_delegate memberService_Update: self isSuccess: [self queryRecordDataFromDatabase]];
    }
}

#pragma mark 保存登录记录
- (void)saveLoginRecordData:(LoginRecordMouleDTO *) loginRecord{
    FMDatabase *database = [self openRecordDatabase];
    if([database open]){
        BOOL isSuccess = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS LoginRecord(phone text,addTime datetime)"];
        if(isSuccess){
            FMResultSet *dataSet = [database executeQuery: @"SELECT * FROM LoginRecord where phone=?", loginRecord.phone];
            [database beginTransaction];
            if([dataSet next]){
                //更新
                [database executeUpdate: @"UPDATE LoginRecord set addTime = ? WHERE phone = ?", [NSDate date], loginRecord.phone];
            }
            else{
                //新增
                [database executeUpdate:@"INSERT INTO LoginRecord (phone,addTime) VALUES (?,?)", loginRecord.phone, [NSDate date]];
            }
            [database commit];
        }
        [database close];
    }
}

#pragma mark - 删除登录数据
- (void)deleteLoginRecordData:(NSString *) phone{
    FMDatabase *database = [self openRecordDatabase];
    if([database open]){
        [database executeUpdate: @"delete from LoginRecord where phone=?", phone];
        [database close];
    }
}

#pragma mark - 登录
- (void)login{
    DHBLoginRequest *request = [[DHBLoginRequest alloc] init];
    request.account = self.memberDTO.account;
    request.password = self.memberDTO.password;
//    [request setHidden_effect: YES];
//    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
//        NSLog_Red(@"code=%d ",[[dic objectForKey:@"code"] intValue]);
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        self.loginResultMessage = [dic objectForKey: @"message"];
        if(isSueccess){
            self.skey = [[dic objectForKey: @"data"] objectForKey: @"skey"];
            self.isMoreSupplier = ([[[dic objectForKey: @"data"] objectForKey: @"is_more"] isEqualToString: @"T"] ? YES : NO);
        }
//        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberService_LoginComplete:isSuccess:)]) {
                [_delegate memberService_LoginComplete: self isSuccess:isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
//        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberService_LoginComplete:isSuccess:)]) {
                [_delegate memberService_LoginComplete: self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 查询供应商列表
- (void)querySupplierList{
    DHBSupplierListRequest *request = [[DHBSupplierListRequest alloc] init];
    request.skey = self.skey;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
//        NSLog_Red(@"code=%d ",[[dic objectForKey:@"code"] intValue]);
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if(isSueccess){
            for(NSDictionary *tmpDictionary in [[dic objectForKey:@"data"] objectForKey: @"company"]){
                DHBSupplierModuleDTO *dto = [[DHBSupplierModuleDTO alloc] init];
                [dto parseWithDic: tmpDictionary];
                [self.supplierArray addObject: dto];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(memberService_QuerySupplierComplete:isSuccess:)]){
                [_delegate memberService_QuerySupplierComplete: self isSuccess: isSueccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
//        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(memberService_QuerySupplierComplete:isSuccess:)]){
                [_delegate memberService_QuerySupplierComplete: self isSuccess: NO];
            }
        });
    }];
}
@end
