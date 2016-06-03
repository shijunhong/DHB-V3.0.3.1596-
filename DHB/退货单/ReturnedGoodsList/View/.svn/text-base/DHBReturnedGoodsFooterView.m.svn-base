//
//  DHBReturnedGoodsFooterView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0F
#import "DHBReturnedGoodsFooterView.h"

@implementation DHBReturnedGoodsFooterView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setBackgroundColor: [UIColor whiteColor]];
        ///
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(mainViewClick)];
        [self addGestureRecognizer: tap];
        ///
        [self addTitleLabel];
        [self addOrderIdLabel];
    }
    return self;
}

- (void)addTitleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, self.size.width / 3.0f, self.size.height)];
        [_titleLabel setText: @"相关订单"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    [self addSubview: _titleLabel];
}

- (void)addOrderIdLabel{
    if(!_orderIDLabel){
        CGFloat origin_x = _titleLabel.frame.size.width + _titleLabel.frame.origin.x;
        _orderIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.size.width - origin_x - self.size.height, self.size.height)];
        [_orderIDLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [_orderIDLabel setTextAlignment: NSTextAlignmentRight];
        [_orderIDLabel setTextColor: [UIColor TextGray_Color]];
        //箭头
        origin_x = _orderIDLabel.frame.size.width + _orderIDLabel.frame.origin.x + 10.0f;
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, 10.0f, self.size.height - 20.0f, self.size.height - 20.0f)];
        [arrowImageView setImage: [UIImage imageNamed: @"arrow"]];
        [arrowImageView setContentMode: UIViewContentModeScaleAspectFit];
        [self addSubview: arrowImageView];
    }
    [self addSubview: _orderIDLabel];
}

- (void)mainViewClick{
    if([_delegate respondsToSelector: @selector(returnedGoodsFooterView_DidCilck:)]){
        [_delegate returnedGoodsFooterView_DidCilck: self.section];
    }
}
@end
