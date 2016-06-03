//
//  DHBPaymentRecordListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModuleDTO.h"

@protocol DHBPaymentRecordListServiceDelegate <NSObject>
@optional
- (void)DHBPaymentRecordListComplete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBPaymentRecordListService : NSObject

@property(nonatomic, assign) id<DHBPaymentRecordListServiceDelegate> delegate;
@property (nonatomic,strong)OrderModuleDTO *order;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic, strong) NSMutableArray *floorsArray;

-(void)queryListData;

@end
