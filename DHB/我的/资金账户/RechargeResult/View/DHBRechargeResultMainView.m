//
//  DHBRechargeResultMainView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define IMAGEVIEW_HEIGHT 100.0F
#define LABEL_HEIGHT 20.0F
#define BUTTON_HEIGHT 40.0F
#import "DHBRechargeResultMainView.h"


@interface DHBRechargeResultMainView ()
@property(nonatomic,strong)UIImageView *resultImageView;
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UILabel *rechargeLabel;
@property(nonatomic,strong)UILabel *paytpyeLabel;
@end

@implementation DHBRechargeResultMainView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addResultView];
        [self addBackButton];
    }
    return self;
}

#pragma mark - 结果页面
- (void)addResultView{
    self.resultImageView = [[UIImageView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - IMAGEVIEW_HEIGHT) / 2.0f, IMAGEVIEW_HEIGHT, IMAGEVIEW_HEIGHT, IMAGEVIEW_HEIGHT)];
    [self.resultImageView setContentMode: UIViewContentModeScaleAspectFit];
    [self.resultImageView setImage: [UIImage imageNamed: @"Succe"]];
    [self addSubview: self.resultImageView];
    //提示
    CGFloat origin_y = self.resultImageView.frame.origin.y + IMAGEVIEW_HEIGHT + LABEL_HEIGHT;
    self.tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, LABEL_HEIGHT)];
    [self.tipLabel setTextColor: [UIColor TextBlack_Color]];
    [self.tipLabel setTextAlignment: NSTextAlignmentCenter];
    [self.tipLabel setFont: [UIFont systemFontOfSize: 16.0f]];
    [self addSubview: self.tipLabel];
    //充值金额
    origin_y += LABEL_HEIGHT * 2.0f;
    self.rechargeLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, LABEL_HEIGHT)];
    [self.rechargeLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [self.rechargeLabel setTextAlignment: NSTextAlignmentCenter];
    [self addSubview: self.rechargeLabel];
    //余额
    origin_y += LABEL_HEIGHT;
    self.paytpyeLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, LABEL_HEIGHT)];
    [self.paytpyeLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [self.paytpyeLabel setTextAlignment: NSTextAlignmentCenter];
    [self addSubview: self.paytpyeLabel];
}


-(void)updateMainViewDate:(BOOL) is_haveOrder{
    if(is_haveOrder){
        [self.tipLabel setText: @"支付成功, 请耐心等待确认收款"];
    }
    else{
        [self.tipLabel setText: @"正在努力为您的账户充值, 请耐心等待"];
    }
    NSMutableAttributedString *attributteString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本次支付：¥%@",self.amount]];
    [attributteString addAttribute: NSForegroundColorAttributeName value: [UIColor TextGray_Color] range: NSMakeRange(0, 5)];
    [attributteString addAttribute: NSForegroundColorAttributeName value: [UIColor TextRed_Color] range: NSMakeRange(5, [attributteString length] - 5)];
    [self.rechargeLabel setAttributedText: attributteString];
    
//    attributteString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"支付方式：%@",self.type.paytype]];
//    [attributteString addAttribute: NSForegroundColorAttributeName value: [UIColor TextGray_Color] range: NSMakeRange(0, 6)];
//    [attributteString addAttribute: NSForegroundColorAttributeName value: [UIColor TextRed_Color] range: NSMakeRange(6, [attributteString length] - 6)];
//    [self.paytpyeLabel setAttributedText: attributteString];
    [self.paytpyeLabel setText:[NSString stringWithFormat:@"支付方式：%@",self.type.paytype]];
}

#pragma mark - 返回按钮
- (void)addBackButton{
    DHBButton *backButton = [[DHBButton alloc] initWithFrame: CGRectMake(20.0f, self.size.height - BUTTON_HEIGHT - 20.0f, SCREEN_WIDTH - 40.0f, BUTTON_HEIGHT) style: kDHBButton_StyleValue3];
    [backButton setTitle: @"确定" forState: UIControlStateNormal];
    [backButton addTarget: self action: @selector(backButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: backButton];
}

#pragma mark - 返回按钮点击事件
- (void)backButtonClick:(UIButton *) button{
    if([_delegate respondsToSelector: @selector(rechargeResultMainView_DidBackButtonClick:)]){
        [_delegate rechargeResultMainView_DidBackButtonClick: button];
    }
}
@end
