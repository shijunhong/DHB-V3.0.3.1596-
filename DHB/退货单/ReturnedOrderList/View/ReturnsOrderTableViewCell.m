//
//  ReturnsGoodsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#define BUTTON_HEIGHT 30.0F
#define MARGIN_LEFT 15.0F
#define HEADER_HEIGHT 40.0F
#define CELL_HEIGHT 136.0f
#import "ReturnsOrderTableViewCell.h"

@implementation ReturnsOrderTableViewCell
#pragma mark - getters and setters
#pragma mark bannar图片
- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] init];
        [_bgView setBackgroundColor: [UIColor whiteColor]];
    }
    return _bgView;
}

#pragma mark bannar图片
- (UIImageView *)bannerImageView{
    if(!_bannerImageView){
        _bannerImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"order"]];
        [_bannerImageView.layer setMasksToBounds: YES];
    }
    return _bannerImageView;
}

#pragma mark 订单编号
- (UILabel *)orderIDLabel{
    if(!_orderIDLabel){
        _orderIDLabel = [[UILabel alloc] init];
        [_orderIDLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_orderIDLabel setTextColor: [UIColor TextRed_Color]];
    }
    return _orderIDLabel;
}

#pragma mark 订单状态
- (UILabel *)statusLabel{
    if(!_statusLabel){
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_statusLabel setTextColor: [UIColor TextGray_Color]];
        [_statusLabel setTextAlignment: NSTextAlignmentRight];
    }
    return _statusLabel;
}

#pragma mark 分割线
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor: HEX_RGB(0xf0f0f0)];
    }
    return _lineView;
}

#pragma mark 订单金额
- (UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor: [UIColor TextGray_Color]];
        [_priceLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    return _priceLabel;
}

#pragma mark 商品数量
- (UILabel *)goodsNumLabel{
    if(!_goodsNumLabel){
        _goodsNumLabel = [[UILabel alloc] init];
        [_goodsNumLabel setTextColor: [UIColor TextGray_Color]];
        [_goodsNumLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    return _goodsNumLabel;
}

#pragma mark 下单时间
- (UILabel *)orderTimeLabel{
    if(!_orderTimeLabel){
        _orderTimeLabel = [[UILabel alloc] init];
        [_orderTimeLabel setTextColor: [UIColor TextGray_Color]];
        [_orderTimeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    return _orderTimeLabel;
}

#pragma mark 操作按钮
- (DHBButton *)operateButton{
    if(!_operateButton){
        _operateButton = [[DHBButton alloc] init];
        [_operateButton addTarget: self action: @selector(operateButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _operateButton;
}

#pragma mark - 根据数据模型更新视图
/**
 *  根据数据模型更新视图
 *
 *  @param dto 退货单数据模型
 */
- (void)updateViewWithOrderDTO:(DHBReturnedOrderModuleDTO *)dto{
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    /**
     *  数据更新
     */
    self.returnedOrder = dto;
    [self .orderIDLabel setText: [dto returns_num]];
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"商品数量 %@",[dto returns_details_count]]];
    [self.orderTimeLabel setText:[NSString stringWithFormat:@"下单时间 %@", [dto create_date]]];
    [self.priceLabel setText: [NSString stringWithFormat: @"退货金额 ¥%@", [dto discount_total]]];
    [self.statusLabel setText: [dto status]];
    if([[dto status] isEqualToString: @"待审核"]){
        [self.operateButton setHidden: NO];
        [self.operateButton setButtonStyle: kDHBButton_StyleValue4];
        [self.operateButton setTitle: @"取消退货" forState: UIControlStateNormal];
        [self.operateButton.titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    else if([[dto status] isEqualToString: @"待发货"]){
        [self.operateButton setHidden: NO];
        [self.operateButton setButtonStyle: kDHBButton_StyleValue4];
        [self.operateButton setTitle: @"确认发货" forState: UIControlStateNormal];
        [self.operateButton.titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    else{
        [self.operateButton setHidden: YES];
    }
    
    /**
     *  添加视图约束
     */
    [self.contentView addSubview: self.bgView];
    self.bgView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).widthIs(SCREEN_WIDTH).heightIs(CELL_HEIGHT);
    
    [self.bgView addSubview: self.orderIDLabel];
    self.orderIDLabel.sd_layout.leftSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.bgView, 0.0f).heightIs(HEADER_HEIGHT).widthIs(SCREEN_WIDTH * 2 / 3);
    
    [self.bgView addSubview: self.statusLabel];
    self.statusLabel.sd_layout.rightSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.bgView, 0.0f).widthIs(SCREEN_WIDTH / 3.0f - 2 * MARGIN_LEFT).heightIs(HEADER_HEIGHT);
    
    [self.bgView addSubview: self.lineView];
    self.lineView.sd_layout.leftSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.orderIDLabel, 0.0f).rightSpaceToView(self.bgView, 0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    [self.bgView addSubview: self.priceLabel];
    self.priceLabel.sd_layout.leftSpaceToView(self.bgView, MARGIN_LEFT).rightSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.lineView, MARGIN_LEFT).autoHeightRatio(0);
    
    [self.bgView addSubview: self.goodsNumLabel];
    self.goodsNumLabel.sd_layout.leftSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.priceLabel, 8.0f).widthIs(SCREEN_WIDTH * 2 / 3).autoHeightRatio(0);
    
    [self.bgView addSubview: self.orderTimeLabel];
    self.orderTimeLabel.sd_layout.leftSpaceToView(self.bgView, MARGIN_LEFT).topSpaceToView(self.goodsNumLabel, 8.0f).widthIs(SCREEN_WIDTH * 2.0f / 3.0f).autoHeightRatio(0);
    
    [self.bgView addSubview: self.operateButton];
    self.operateButton.sd_layout.rightSpaceToView(self.bgView , MARGIN_LEFT).heightIs(BUTTON_HEIGHT).bottomSpaceToView(self.bgView, MARGIN_LEFT).widthIs(80.0f);
    //
    [self.bgView setupAutoHeightWithBottomView: self.orderTimeLabel bottomMargin: MARGIN_LEFT];
    
    [self.contentView addSubview: self.bannerImageView];
    self.bannerImageView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, CELL_HEIGHT).rightSpaceToView(self.contentView, 0.0f).heightIs(5.0f).widthIs(SCREEN_WIDTH);
    //
    [self.contentView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self setupAutoHeightWithBottomView: self.bannerImageView bottomMargin: 5.0f];
}

- (void)operateButtonClick:(UIButton *) sender{
    if(_delegate && [_delegate respondsToSelector: @selector(retrunsGoodsTableViewCell_DidOperateButtonClick:)]){
        [_delegate retrunsGoodsTableViewCell_DidOperateButtonClick: self];
    }
}
@end
