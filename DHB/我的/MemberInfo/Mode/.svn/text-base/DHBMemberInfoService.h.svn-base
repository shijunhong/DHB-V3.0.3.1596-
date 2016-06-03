//
//  DHBMemberInfoService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBMemberInfoModuleDTO.h"
#import "HomeFloorDTO.h"
#import "DHBMemberInfoRequest.h"

@protocol DHBMemberInfoService_Delegate <NSObject>
- (void)memberInfoService_Complete: service isSuccess:(BOOL)isSuccess;
- (void)memberInfoService_ModifyMemberInfoResult:(BOOL)isSuccess;
@end

@interface DHBMemberInfoService : NSObject
@property(nonatomic, strong) DHBMemberInfoModuleDTO *memberDTO;
@property(nonatomic, assign) id<DHBMemberInfoService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) NSError *error;

- (void)queryData;
- (void)submitMemberInfoData;
@end
