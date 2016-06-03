//
//  DHBFinanceAccountHeaderView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define TOPIMAGEVIEW_HEIGHT 37.0f
#define MARGIN_TOP 41.0F
#define LABEL_HEIGHT 50.0F
#define BUTTON_HEIGHT 40.0F

#import "DHBFinanceAccountHeaderView.h"

@implementation DHBFinanceAccountHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setBackgroundColor: [UIColor TextRed_Color]];
        [self addTopImageView];
        [self addFinanceLabel];
        [self addRechargeButton];
    }
    return self;
}

#pragma mark - 顶部视图
- (void)addTopImageView{
    if(!_topImageView){
        _topImageView = [[UIImageView alloc] initWithFrame: CGRectMake((self.size.width - TOPIMAGEVIEW_HEIGHT) / 2.0f, MARGIN_TOP, TOPIMAGEVIEW_HEIGHT, TOPIMAGEVIEW_HEIGHT)];
        [_topImageView setImage: [UIImage imageNamed: @"account"]];
        ///
        UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, _topImageView.frame.size.height + _topImageView.frame.origin.y + 11.0f, self.size.width, 20.0f)];
        [tipLabel setTextAlignment: NSTextAlignmentCenter];
        [tipLabel setTextColor: HEX_RGB(0xf89c8b)];
        [tipLabel setFont: [UIFont boldSystemFontOfSize: 12.0f]];
        [tipLabel setText: @"预存款余额"];
        [self addSubview: tipLabel];
    }
    [self addSubview: _topImageView];
}

#pragma mark - 资金
- (void)addFinanceLabel{
    if(!_financeLabel){
        CGFloat origin_y = _topImageView.frame.size.height + _topImageView.frame.origin.y + 27.0f;
        _financeLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.size.width, LABEL_HEIGHT)];
        [_financeLabel setTextAlignment: NSTextAlignmentCenter];
    }
    [self addSubview: _financeLabel];
}

#pragma mark - 充值按钮
- (void)addRechargeButton{
    if(!_rechargeButton){
        CGFloat origin_y = _financeLabel.frame.size.height + _financeLabel.frame.origin.y + 58.0f;
        _rechargeButton = [[DHBButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH / 3.0f, origin_y, SCREEN_WIDTH / 3.0F, BUTTON_HEIGHT) style: kDHBButton_StyleValue5];
        [_rechargeButton setTitle: @"立即充值" forState: UIControlStateNormal];
        [_rechargeButton.layer setBorderWidth: 1.0f];
        [_rechargeButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_rechargeButton addTarget: self action: @selector(rechargeButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: _rechargeButton];
}

#pragma mark - 设置资金
- (void)setFinanceLabelText:(NSString *) text{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: text];
    [attributeString addAttribute: NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0, [text length] - 1)];
    [attributeString addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: 30.0f] range: NSMakeRange(0, [text length] - 1)];
    [attributeString addAttribute: NSForegroundColorAttributeName value: HEX_RGB(0xfec1b7) range: NSMakeRange([text length] - 1, 1)];
    [attributeString addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: 13.0f] range: NSMakeRange([text length] - 1, 1)];
    [_financeLabel setAttributedText: attributeString];
}

- (void)rechargeButtonClick:(UIButton *) sender{
    if ([_delegate respondsToSelector:@selector(financeAccountHeaderView_DidRechargeButton:)]) {
        [_delegate financeAccountHeaderView_DidRechargeButton: sender];
    }
}
@end
