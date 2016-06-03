//
//  DHBMemberService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRecordMouleDTO.h"
#import "MemberInfoModuleDTO.h"
#import "DHBLoginRequest.h"
#import "DHBSupplierListRequest.h"
#import "DHBSupplierModuleDTO.h"

@class DHBMemberService;

@protocol DHBMemberServiceDelegate <NSObject>
@optional
- (void)memberService_Complete:(DHBMemberService *) service isSuccess:(BOOL )isSuccess;
- (void)memberService_Update:(DHBMemberService *) service isSuccess:(BOOL )isSuccess;
- (void)memberService_LoginComplete:(DHBMemberService *) service isSuccess:(BOOL )isSuccess;
- (void)memberService_QuerySupplierComplete: (DHBMemberService *) servicer isSuccess:(BOOL )isSuccess;
@end

@interface DHBMemberService : NSObject

@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong)NSString *loginResultMessage;
@property(nonatomic, strong) NSMutableArray *loginRecordArray;
@property(nonatomic, strong) MemberInfoModuleDTO *memberDTO;
@property(nonatomic, assign) id<DHBMemberServiceDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *supplierArray; ///供应商数据

@property(nonatomic, strong)NSString *skey;
@property(nonatomic, assign)BOOL isMoreSupplier;///是否多个供应商

- (void)queryLoginRecordData;
- (void)updateLoginRecordData;
- (void)saveLoginRecordData:(LoginRecordMouleDTO *) loginRecord;
- (void)deleteLoginRecordData:(NSString *) phone;
- (void)querySupplierList;
- (void)login;
@end
