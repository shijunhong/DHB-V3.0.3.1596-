//
//  DHBOrderAttachmentModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHBOrderAttachmentModuleDTO : NSObject
@property(nonatomic,strong)NSString *attachID;//附件编号
@property(nonatomic,strong)NSString *attatchName; //附件名称

- (void)parseFromDict:(NSDictionary *)dict;
@end
