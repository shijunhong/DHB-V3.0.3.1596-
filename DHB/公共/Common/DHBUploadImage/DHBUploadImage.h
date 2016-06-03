//
//  DHBUploadImage.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NOUPLOAD,//没有上传
    UPLOADING,//上传中
    UPLOADED,//已上传
    ERROR//上传失败
}StatusImg;

@interface DHBUploadImage : NSObject
@property(nonatomic,assign)StatusImg status;
@property(nonatomic,strong)NSData *image;
@end
