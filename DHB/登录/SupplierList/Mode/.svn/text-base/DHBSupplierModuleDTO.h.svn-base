//
//  DHBSupplierModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBSupplierModuleDTO : NSObject
/**
 *  name: 供应商名称
 */
@property(nonatomic, retain) NSString *name;
/**
 *  message：账号在该供应商下的状态信息
 */
@property(nonatomic, retain) NSString *message;
/**
 *  company_id：供应商编号
 */
@property(nonatomic, retain) NSString *company_id;
/**
 *  is_login：是否允许登录
 */
@property(nonatomic, assign) BOOL is_login;

/**
 * public method
 */
- (void)parseWithDic:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryFromDTO;
@end
