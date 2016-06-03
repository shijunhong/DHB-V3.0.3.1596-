//
//  DHBUploadImageView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CANCELBUTTON_WIDTH 20.0F
#import "DHBUploadImageView.h"

@implementation DHBUploadImageView
#pragma mark - init
- (UIImageView *)photoImageView{
    if(!_photoImageView){
        _photoImageView = [[UIImageView alloc] initWithFrame: CGRectMake(CANCELBUTTON_WIDTH / 2.0f, CANCELBUTTON_WIDTH / 2.0f, self.width - CANCELBUTTON_WIDTH, self.height - CANCELBUTTON_WIDTH)];
        [_photoImageView setContentMode: UIViewContentModeScaleAspectFit];
        [_photoImageView.layer setCornerRadius: 2.5f];
        [_photoImageView.layer setBorderWidth: 0.5f];
        [_photoImageView.layer setBorderColor: HEX_RGB(0xe6e6e6).CGColor];
        [_photoImageView.layer setMasksToBounds: YES];
        [_photoImageView setUserInteractionEnabled: YES];
    }
    return _photoImageView;
}

- (UIButton *)photoCancelButton{
    if(!_photoCancelButton){
        ///图片删除按钮
        _photoCancelButton = [[UIButton alloc] initWithFrame: CGRectMake(self.photoImageView.right - CANCELBUTTON_WIDTH / 2.0F, self.photoImageView.top - CANCELBUTTON_WIDTH / 2.0f, CANCELBUTTON_WIDTH, CANCELBUTTON_WIDTH)];
        [_photoCancelButton setImage: [UIImage imageNamed: @"delete"] forState: UIControlStateNormal];
        [_photoCancelButton addTarget: self action: @selector(photoCancelButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_photoCancelButton setHidden: YES];
    }
    return _photoCancelButton;
}

- (UIView *)maskActivetorView{
    if(!_maskActivetorView){
        _maskActivetorView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.photoImageView.width, self.photoImageView.height)];
        [_maskActivetorView setBackgroundColor: [[UIColor alloc] initWithWhite: 0.1f alpha: 0.6f]];
        [_maskActivetorView setHidden: YES];
        ///指示器
        UIActivityIndicatorView *indicatiorView = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
        [indicatiorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];
        [indicatiorView setCenter: CGPointMake(self.photoImageView.width / 2.0f, self.photoImageView.height / 2.0f)];
        [indicatiorView startAnimating];
        [_maskActivetorView addSubview: indicatiorView];
    }
    return _maskActivetorView;
}


#pragma mark - 
- (id)init{
    self = [super init];
    if(self){
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setFrame: CGRectMake(frame.origin.x - CANCELBUTTON_WIDTH / 2.0f, frame.origin.y - CANCELBUTTON_WIDTH / 2.0f, frame.size.width + CANCELBUTTON_WIDTH, frame.size.height + CANCELBUTTON_WIDTH)];
        [self setBackgroundColor: [UIColor clearColor]];
        [self setUserInteractionEnabled: YES];
        [self addSubview: self.photoImageView];
        [self.photoImageView addSubview: self.maskActivetorView];
        [self addSubview: self.photoCancelButton];
    }
    return self;
}

- (void)photoCancelButtonClick:(UIButton *)sender{
    [self setHidden: YES];
    [self.photoImageView setImage: nil];
    if([_delegate respondsToSelector: @selector(DHBUploadImageView_CancelButtonClick:)]){
        [_delegate DHBUploadImageView_CancelButtonClick: sender];
    }
}

#pragma mark -
- (void)UpdateView:(DHBUploadImage *)image{
    [self.photoImageView setImage: [UIImage imageWithData: image.image]];
    switch (image.status) {
        case NOUPLOAD:{
            [self show];
            break;
        }
        case UPLOADING:{
            [self startUploading];
            break;
        }
        case UPLOADED:{
            [self startUploaded];
            break;
        }
        case ERROR:{
            [self show];
            break;
        }
        default:
            break;
    }
}


#pragma mark 显示将要上传的图片
- (void)show{
    [self setHidden: NO];
    [self.photoCancelButton setHidden: NO];
    [_photoCancelButton setEnabled: YES];
    [_photoCancelButton setImage: [UIImage imageNamed: @"delete"] forState: UIControlStateNormal];
}

#pragma mark 开始上传图片
- (void)startUploading{
    [self setHidden: NO];
    [self.photoCancelButton setHidden: YES];
    [self.maskActivetorView setHidden: NO];
}

#pragma mark 图片上传完毕
- (void)startUploaded{
    [self.photoCancelButton setHidden: NO];
    [self.maskActivetorView setHidden: YES];
    [_photoCancelButton setImage: [UIImage imageNamed: @"adopt"] forState: UIControlStateNormal];
    [_photoCancelButton setEnabled: NO];
}

#pragma mark 隐藏上传的图片
- (void)dismiss{
    [self setHidden: YES];
    [self.photoCancelButton setHidden: YES];
    [self.maskActivetorView setHidden: YES];
}

#pragma mark - tag
- (void)setTag:(NSInteger)tag{
    [super setTag:tag];
    [self.photoCancelButton setTag: tag];
}
@end
