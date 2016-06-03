//
//  DHBUploadAttachmentRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBUploadAttachmentRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSArray *content;
@property(nonatomic,strong)NSData *file_value;

@end
