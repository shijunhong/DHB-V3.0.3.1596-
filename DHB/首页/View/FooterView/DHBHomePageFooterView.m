//
//  DHBHomePageFooterView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define BUTTON_MARGIN 15.0f
#import "DHBHomePageFooterView.h"

@implementation DHBHomePageFooterView

-(UIView *)bottomImageView{
    if (!_bottomImageView)
    {
        _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-15.0f, self.frame.size.width, 15.0f)];
        [_bottomImageView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _bottomImageView.width, DEFAULT_LINE_HEIGHT)];
        [view setBackgroundColor:[UIColor CellLine_Color]];
        [_bottomImageView addSubview:view];
    }
    return _bottomImageView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addGoodsButton];
        //底部还需要划线
        [self addSubview:self.bottomImageView];
    }
    return self;
}

#pragma mark - 添加商品列表按钮
- (void)addGoodsButton{
    if(!_goodsButton){
        _goodsButton = [[UIButton alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height-15.0f)];
        [_goodsButton setTitle: L(@"查看全部商品") forState: UIControlStateNormal];
        _goodsButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_goodsButton setTitleColor:[UIColor TextBlack_Color] forState:UIControlStateNormal];
        [_goodsButton addTarget: self action: @selector(goodsListButtonClick) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: _goodsButton];
}

#pragma mark -
- (void)goodsListButtonClick{
    if([_delegate respondsToSelector: @selector(homePageFooterView_DidGoodsListButtonClick)]){
        [_delegate homePageFooterView_DidGoodsListButtonClick];
    }
}
@end
