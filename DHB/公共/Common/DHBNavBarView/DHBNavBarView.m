//
//  DHBNavBarView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/7.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBNavBarView.h"

@interface DHBNavBarView ()
@end

@implementation DHBNavBarView

-(UILabel *)center_lb{
    if (!_center_lb)
    {
        _center_lb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-200.0f/2, 20.0f, 200.0f, self.height-20.0f)];
        [_center_lb setTextAlignment:NSTextAlignmentCenter];
        [_center_lb setFont:[UIFont systemFontOfSize:18.0f]];
        [_center_lb setTextColor:HEX_RGB(0xffffff)];
        [_center_lb setHidden:YES];
    }
    return _center_lb;
}

-(UILabel *)left_lb{
    if (!_left_lb)
    {
        _left_lb = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 20.0f, SCREEN_WIDTH, self.height-20.0f)];
        [_left_lb setFont:[UIFont systemFontOfSize:18]];
        [_left_lb setTextColor:HEX_RGB(0xffffff)];
        [_left_lb setHidden:YES];
        ////
        self.left_tap = [[UITapGestureRecognizer alloc] init];
        [_left_lb setUserInteractionEnabled: YES];
        [_left_lb addGestureRecognizer:self.left_tap];
    }
    return _left_lb;
}

-(UIButton *)back_btn{
    if (!_back_btn)
    {
        _back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 22.0f+20.0f, self.height-20.0f)];
        [_back_btn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
        [_back_btn setImage:[UIImage imageNamed:@"back_focused"] forState: UIControlStateHighlighted];
        [_back_btn setBackgroundColor: [UIColor clearColor]];
        [_back_btn setHidden:YES];
    }
    return _back_btn;
}



-(UIImageView *)shoppingCar_img{
    if (!_shoppingCar_img)
    {
        _shoppingCar_img = [[UIImageView alloc] initWithFrame:CGRectMake(self.shoppingCar_btn.centerX-22/2, self.shoppingCar_btn.centerY-22/2, 22, 22)];
        [_shoppingCar_img setImage:[UIImage imageNamed:@"shoppingcartnumber_normal"]];
        [_shoppingCar_img setHidden:YES];
    }
    return _shoppingCar_img;
}

-(UIButton *)shoppingCar_btn{
    if (!_shoppingCar_btn) {
        _shoppingCar_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-22-20-5, 20.0f+1.0f, 22+20, self.height-21.0f)];
        [_shoppingCar_btn setHidden:YES];
    }
    return _shoppingCar_btn;
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.center_lb];
        [self addSubview:self.left_lb];
        [self addSubview:self.back_btn];
        [self addSubview:self.shoppingCar_btn];
        [self insertSubview:self.shoppingCar_img belowSubview:self.shoppingCar_btn];
        
    }
    return self;
}

@end
