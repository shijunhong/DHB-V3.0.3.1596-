//
//  DHBUploadImageView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBUploadImage.h"

@protocol DHBUploadImageView_Delegate <NSObject>
- (void)DHBUploadImageView_CancelButtonClick:(UIButton *)sender;
@end

@interface DHBUploadImageView : UIImageView
@property(nonatomic, retain) UIImageView *photoImageView; //凭证图片
@property(nonatomic, retain) UIButton *photoCancelButton; //删除图片按钮
@property(nonatomic, retain) UIView *maskActivetorView; //上传时的阴影指示器
@property(nonatomic, assign) id<DHBUploadImageView_Delegate> delegate;

- (void)UpdateView:(DHBUploadImage *)image;
- (void)dismiss;
- (void)startUploading;
- (void)startUploaded;
@end
