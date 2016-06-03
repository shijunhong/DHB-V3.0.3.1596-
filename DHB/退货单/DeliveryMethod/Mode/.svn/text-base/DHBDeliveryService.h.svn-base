//
//  DHBDeliveryService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
typedef NS_ENUM(NSInteger){
    kDelivery_date = 0, //发货日期
    kDelivery_picker, //时间筛选器
    kDelivery_company, //物流公司
    kDelivery_no //物流单号
}DeliveryModel_Type;


#import <Foundation/Foundation.h>
#import "DHBDeliveryMethodMoudleDTO.h"
#import "DHBDeliveryMethodRequest.h"
#import "HomeFloorDTO.h"

@class DHBDeliveryService;
@protocol DHBDeliveryServiceDelegate <NSObject>
@optional
- (void)deliveryServiceComplete:(DHBDeliveryService *)service isSuccess:(BOOL)isSuccess;
- (void)deliveryService_DidSettingDeliveryMethod: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBDeliveryService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign) id<DHBDeliveryServiceDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, retain) DHBDeliveryMethodMoudleDTO *deliveryMethodDTO;

@property(nonatomic, retain) NSString *isAddDelivery;//是否是添加配送方式(T:新增； F:修改)

- (void)queryData;
- (void)settingReturnedOrderDeliveryMethod:(NSString *) _returns_id;
@end
