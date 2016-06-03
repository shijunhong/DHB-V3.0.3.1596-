//
//  DHBDeliveryMethodRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/7/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"
#import "DHBDeliveryMethodMoudleDTO.h"

@interface DHBDeliveryMethodRequest : DHBBaseNetworkRequest
@property(nonatomic, retain) NSString *returns_id;//退货单ID
@property(nonatomic, retain) NSString *is_add;//是否是添加配送方式(T:新增； F:修改)
@property(nonatomic, retain) DHBDeliveryMethodMoudleDTO *deliveryMethodDTO;
@end
