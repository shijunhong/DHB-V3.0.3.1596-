//
//  DHBOrderAttachmentService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBOrderAttachmentRequest.h"
#import "DHBOrderAttachmentModuleDTO.h"
#import "DHBReturnsAttachmentRequest.h"

@protocol DHBOrderAttachmentService_Delegate <NSObject>
@optional
- (void)orderAttachmentService_Compelete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBOrderAttachmentService : NSObject
@property(nonatomic, assign) id<DHBOrderAttachmentService_Delegate> delegate;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, strong)NSString *orders_id;
@property(nonatomic, strong)NSString *returns_id;

- (void)queryData;
- (void)queryReturnsOrderData;
@end
