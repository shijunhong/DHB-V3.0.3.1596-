//
//  DHBAboutService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "DHBAboutRequest.h"
#import "DHBAboutModuleDTO.h"
#import "DHBShareInfoRequest.h"
#import "DHBShareInfoModuleDTO.h"

@protocol DHBAboutService_Delegate <NSObject>
@optional
- (void)aboutService_Complete: service isSuccess:(BOOL)isSuccess;
- (void)aboutService_ShareInfoComplete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBAboutService : NSObject
@property(nonatomic, assign) id<DHBAboutService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) DHBAboutModuleDTO *aboutDTO;
@property(nonatomic, strong) DHBShareInfoModuleDTO *shareInfoDTO;

-(void)queryData;
-(void)queryShareData;
@end
