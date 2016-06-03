//
//  DHBMemberCenterService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBMemberCenterRequest.h"
#import "DHBMemberInfoModuleDTO.h"
#import "DHBMyDefaultInfoRequest.h"
#import "DHBLoginOutRequest.h"
#import "HomeFloorDTO.h"

@protocol DHBMemberCenterService_Delegate <NSObject>
@optional
- (void)memberCenterSerivce_RequestMemberDataFinish: service isSuccess:(BOOL) isSuccess;
- (void)memberCenterSerivce_LoginOutFinish: service isSuccess:(BOOL) isSuccess;
@end

@interface DHBMemberCenterService : NSObject
@property(nonatomic, assign) id<DHBMemberCenterService_Delegate> delegate;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, retain) DHBMemberInfoModuleDTO *memberInfo;
@property(nonatomic, retain) NSMutableArray *floorArray;

- (void)queryMemberData;
- (void)queryDefaultInfo;
- (void)loginOut;
@end
