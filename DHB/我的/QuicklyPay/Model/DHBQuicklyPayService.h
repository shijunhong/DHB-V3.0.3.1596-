//
//  DHBQuicklyPayService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/10/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "DHBAddNewMessageRequest.h"

@interface DHBQuicklyPayService : NSObject
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSMutableArray *floorArray;
@property(nonatomic, copy) void(^DHBQuicklyPayService_Compelete) (DHBQuicklyPayService *service, BOOL isSuccess);
@property(nonatomic, copy) void(^DHBQuicklyPayService_AlertOpenAuicklyPay) (DHBQuicklyPayService *service, BOOL isSuccess);

- (void)queryData;
- (void)alertOpenAuicklyPay;
@end
