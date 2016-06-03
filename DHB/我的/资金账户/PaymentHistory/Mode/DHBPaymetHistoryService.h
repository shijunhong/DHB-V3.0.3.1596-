//
//  DHBPaymetHistoryService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DHBPaymetHistoryService_Delegate <NSObject>
- (void)paymentHistoryService_omplete: service isSuccess:(BOOL)isSuccess;
@end


@interface DHBPaymetHistoryService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, assign) id<DHBPaymetHistoryService_Delegate> delegate;
@property(nonatomic, retain) NSMutableArray *floorsArray;
@property(nonatomic, retain) NSString *status_id;//收款状态
@property(nonatomic, retain) NSString *type_id;//支付方式
@property(nonatomic, retain) NSString *begin_date;//开始时间
@property(nonatomic, retain) NSString *end_date;//终止时间
- (void)queryListData;
@end
