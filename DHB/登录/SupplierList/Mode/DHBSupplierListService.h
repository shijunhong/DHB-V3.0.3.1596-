//
//  DHBSupplierListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBSupplierModuleDTO.h"
#import "DHBSupplierListRequest.h"
#import "DHBSelectSupplierRequest.h"

/**
 *  DHBSupplierListService代理
 */
@protocol DHBSupplierListService_Delegate <NSObject>
@optional
- (void)DHBSupplierListService_Compelete: service isSueccess:(BOOL) isSuccess;
- (void)DHBSupplierListService_SelectedSupplier: service isSueccess:(BOOL) isSuccess;
@end

@interface DHBSupplierListService : NSObject
/**
 *  delegate: 代理对象
 */
@property(nonatomic, assign) id<DHBSupplierListService_Delegate> delegate;
/**
 *  error: 接口错误信息
 */
@property(nonatomic, retain) NSError *error;
/**
 *  dataArray: 接口返回数据源
 */
@property(nonatomic, retain) NSMutableArray *dataArray;
/**
 *  skey: 系统参数
 */
@property(nonatomic, retain) NSString *skey;
/**
 *  company_id: 供应商编号
 */
@property(nonatomic, retain) NSString *company_id;
/**
 *  message: 接口返回的接口信息
 */
@property(nonatomic, retain) NSString *message;

- (void)querDataList;
- (void)selectSupplier;
@end
