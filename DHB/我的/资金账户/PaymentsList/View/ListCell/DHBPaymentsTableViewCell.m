//
//  DHBPaymentsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define TIME_WIDTH 80.0f
#define MAINVIEW_HEIGHT 60.0F
#define MARGIN 10.0F
#import "DHBPaymentsTableViewCell.h"

@implementation DHBPaymentsTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSize: size];
        [self setBackgroundColor: [UIColor clearColor]];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        ///
        [self addMainView];
        [self addPayTimeLabel];
        [self addPayDepositTypeLabell];
        [self addPayTypeLabel];
        [self addAmountLabel];
        [self addBalanceLabel];
    }
    return self;
}

#pragma mark - 
- (void)addMainView{
    if(!_mainView){
        _mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, self.size.height - MAINVIEW_HEIGHT, self.size.width, MAINVIEW_HEIGHT)];
        [_mainView setBackgroundColor: [UIColor whiteColor]];
        ///顶部分割线
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, 0.5f)];
        [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
        [_mainView addSubview: lineView];
        ///底部分割线
        lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, MAINVIEW_HEIGHT - 0.5f, self.size.width, 0.5f)];
        [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
        [_mainView addSubview: lineView];
    }
    [self addSubview: _mainView];
}

#pragma mark - 
- (void)addPayTimeLabel{
    if(!_payTimeLabel){
        _payTimeLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0.0f, TIME_WIDTH, MAINVIEW_HEIGHT)];
        [_payTimeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_payTimeLabel setTextColor: HEX_RGB(0xd1d1d1)];
        [_payTimeLabel setTextAlignment: NSTextAlignmentCenter];
    }
    [_mainView addSubview: _payTimeLabel];
}

#pragma mark - 预存款类型
- (void)addPayDepositTypeLabell{
    if(!_depositTypeLabel){
        ///分割线
        CGFloat origin_x = _payTimeLabel.frame.origin.x + TIME_WIDTH;
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(origin_x, 10.0f, 1.0f, MAINVIEW_HEIGHT - 20.0f)];
        [lineView setBackgroundColor: HEX_RGB(0xf2f2f2)];
        [_mainView addSubview: lineView];
        ///
        origin_x += lineView.frame.size.width + 10.0f;
        _depositTypeLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, MARGIN, (self.size.width - origin_x) / 3.0f, (MAINVIEW_HEIGHT - 2 * MARGIN) / 2.0f)];
        [_depositTypeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_depositTypeLabel setTextColor: [UIColor TextBlack_Color]];
    }
    [_mainView addSubview: _depositTypeLabel];
}

#pragma mark - 付款方式
- (void)addPayTypeLabel{
    if(!_payTypeLabel){
        CGFloat origin_y = _depositTypeLabel.frame.origin.y + _depositTypeLabel.frame.size.height;
        ///
        _payTypeLabel = [[UILabel alloc] initWithFrame: CGRectMake(_depositTypeLabel.frame.origin.x, origin_y, _depositTypeLabel.frame.size.width, (MAINVIEW_HEIGHT - 2 * MARGIN) / 2.0f)];
        [_payTypeLabel setFont: [UIFont systemFontOfSize: 12.0f]];
        [_payTypeLabel setTextColor: [UIColor TextGray_Color]];
    }
    [_mainView addSubview: _payTypeLabel];
}

#pragma mark - 操作金额
- (void)addAmountLabel{
    if(!_amountLabel){
        CGFloat origin_x = _depositTypeLabel.frame.origin.x + _depositTypeLabel.frame.size.width;
        _amountLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, MARGIN, (self.size.width - origin_x - 15.0f), (MAINVIEW_HEIGHT - 2 * MARGIN) / 2.0f)];
        [_amountLabel setFont: [UIFont systemFontOfSize: 18.0f]];
        [_amountLabel setTextAlignment: NSTextAlignmentRight];
        [_amountLabel setAdjustsFontSizeToFitWidth: YES];
    }
    [_mainView addSubview: _amountLabel];
}

#pragma mark - 余额
- (void)addBalanceLabel{
    if(!_balanceLabel){
        CGFloat origin_y = _amountLabel.frame.origin.y + _amountLabel.frame.size.height;
        _balanceLabel = [[UILabel alloc] initWithFrame: CGRectMake(_amountLabel.frame.origin.x, origin_y, _amountLabel.frame.size.width, (MAINVIEW_HEIGHT - 2 * MARGIN) / 2.0f)];
        [_balanceLabel setFont: [UIFont systemFontOfSize: 10.0f]];
        [_balanceLabel setTextAlignment: NSTextAlignmentRight];
        [_balanceLabel setTextColor: [UIColor TextGray_Color]];
    }
    [_mainView addSubview: _balanceLabel];
}

#pragma mark - 更新数据
- (void)updateViewWithDTO:(DHBPaymentsInfoModuleDTO *) dto{
    if(dto){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"MM月dd日"];
        [_payTimeLabel setText: [formatter stringFromDate: [dto pay_time]]];
        [_depositTypeLabel setText: [dto deposit_type]];
        [_payTypeLabel setText: [dto type_id]];
        if([[dto amount] doubleValue] > 0){
            [_amountLabel setTextColor: HEX_RGB(0x1bb635)];
            [_amountLabel setText: [NSString stringWithFormat: @"+%@",[dto amount]]];
        }
        else if([[dto amount] doubleValue] == 0){
            [_amountLabel setTextColor: [UIColor TextBlack_Color]];
            [_amountLabel setText: [NSString stringWithFormat: @"%@",[dto amount]]];
        }
        else{
            [_amountLabel setTextColor: HEX_RGB(0xf70d1a)];
            [_amountLabel setText: [NSString stringWithFormat: @"%@",[dto amount]]];
        }
        [_balanceLabel setText: [NSString stringWithFormat: @"余额:%@",[dto deposit_balance]]];
    }
}

@end
