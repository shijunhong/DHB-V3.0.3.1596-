//
//  DHBShareCollectionViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define LABLE_HEIGHT 20.0f
#import "DHBShareCollectionViewCell.h"

@implementation DHBShareCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addImageView];
        [self addNameLabel];
    }
    return self;
}

- (void)addImageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, self.size.height - LABLE_HEIGHT - 5.0f)];
        [_imageView setContentMode: UIViewContentModeScaleAspectFit];
    }
    [self addSubview: _imageView];
}

- (void)addNameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, self.size.height - LABLE_HEIGHT, self.size.width, LABLE_HEIGHT)];
        [_nameLabel setTextAlignment: NSTextAlignmentCenter];
        [_nameLabel setTextColor: [UIColor TextGray_Color]];
        [_nameLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    }
    [self addSubview: _nameLabel];
}

#pragma mark - 
- (void)updateViewWithDTO:(DHBShareModuleDTO *) dto{
    [_imageView setImage: [UIImage imageNamed: [dto icon]]];
    [_nameLabel setText: [dto name]];
}
@end
