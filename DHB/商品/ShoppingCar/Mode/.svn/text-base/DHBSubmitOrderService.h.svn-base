//
//  DHBSubmitOrderService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/30/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "UserInformationModuleDTO.h"
#import "DHBOrderSubmitRequest.h"

@protocol DHBSubmitOrderService_Delegate <NSObject>
@optional
- (void)DHBSubmitOrderService_Complete: service isSuceess:(BOOL) isSuccess;
- (void)DHBSubmitOrderService_SubmitOrder: (NSDictionary *) responseDictionary isSuceess:(BOOL) isSuccess;
@end

@interface DHBSubmitOrderService : NSObject
/**
 *  楼层数据源
 */
@property(nonatomic, strong) NSMutableArray *floorArray;
/**
 *  用户订单提交数据模型
 */
@property(nonatomic, strong) UserInformationModuleDTO *userInfoDTO;
/**
 *  代理对象
 */
@property(nonatomic, assign) id <DHBSubmitOrderService_Delegate> delegate;

/**
 *  public method
 */
- (void)createFloor;
- (void)submitOrder;
@end
