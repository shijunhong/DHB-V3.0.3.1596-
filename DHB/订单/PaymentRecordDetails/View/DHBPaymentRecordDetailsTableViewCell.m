//
//  DHBPaymentRecordDetailsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#define SECTIONVIEW_HEIHGT 8.0f
#import "DHBPaymentRecordDetailsTableViewCell.h"

@implementation DHBPaymentRecordDetailsTableViewCell

#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    _floorDTO = dto;
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
}

#pragma mark -
#pragma mark 样式1（状态和金额）
- (void)addFloor_1{
    DHBPaymentRecordModuleDTO *paymentDTO = [[_floorDTO moduleList] firstObject];
    //状态
    UILabel *statusLabel = [[UILabel alloc] init];
    [statusLabel setTextColor: [UIColor TextBlack_Color]];
    [statusLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [statusLabel setText: [paymentDTO status]];
    [self.contentView addSubview: statusLabel];
    [statusLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, 35.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).autoHeightRatio(0);
    
    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    NSMutableAttributedString *attributteString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat: @"%@ 元", [paymentDTO amount]]];
    [attributteString addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: 40.0f] range: NSMakeRange(0, [attributteString length] - 2)];
    [attributteString addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: 15.0f] range: NSMakeRange([attributteString length] - 2, 2)];
    [attributteString addAttribute: NSForegroundColorAttributeName value: [UIColor TextRed_Color] range: NSMakeRange(0, [attributteString length] - 2)];
    [attributteString addAttribute: NSForegroundColorAttributeName value: HEX_RGB(0xff8888) range: NSMakeRange([attributteString length] - 2, 2)];
    [priceLabel setAttributedText: attributteString];
    [self.contentView addSubview: priceLabel];
    [priceLabel sd_layout].topSpaceToView(statusLabel, 12.0f).leftSpaceToView(self.contentView, MARGIN_LEFT).rightSpaceToView(self.contentView, MARGIN_LEFT).autoHeightRatio(0);
    
    /////底部
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    [bottomView sd_layout].topSpaceToView(priceLabel, 35.0f).leftSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).heightIs(SECTIONVIEW_HEIHGT);
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SECTIONVIEW_HEIHGT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}

#pragma mark -
#pragma mark 样式2（付款单详细信息）
- (void)addFloor_2{
    DHBPaymentRecordModuleDTO *paymentDTO = [[_floorDTO moduleList] firstObject];
    ///类型
    UILabel *typeLabel = [[UILabel alloc] init];
    [typeLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [typeLabel setText: @"类型"];
    [typeLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: typeLabel];
    [typeLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, 25.0f).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    UILabel *typeValueLabel = [[UILabel alloc] init];
    [typeValueLabel setTextColor: [UIColor TextGray_Color]];
    [typeValueLabel setText: [paymentDTO incexp_id]];
    [typeValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [typeValueLabel setTextAlignment: NSTextAlignmentRight];
    [self.contentView addSubview: typeValueLabel];
    [typeValueLabel sd_layout].topSpaceToView(self.contentView, 25.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    
    ///支付方式
    UILabel *payLabel = [[UILabel alloc] init];
    [payLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [payLabel setText: @"支付方式"];
    [payLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: payLabel];
    [payLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(typeLabel, 12.0f).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    UILabel *payValueLabel = [[UILabel alloc] init];
    [payValueLabel setTextColor: [UIColor TextGray_Color]];
    [payValueLabel setText: [paymentDTO type_id]];
    [payValueLabel setTextAlignment: NSTextAlignmentRight];
    [payValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: payValueLabel];
    [payValueLabel sd_layout].topEqualToView(payLabel).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    
    ///关联单号
    UILabel *linkOrderLabel = [[UILabel alloc] init];
    [linkOrderLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [linkOrderLabel setText: @"关联单号"];
    [linkOrderLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: linkOrderLabel];
    [linkOrderLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(payLabel, 12.0f).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    UILabel *linkOrderValueLabel = [[UILabel alloc] init];
    [linkOrderValueLabel setTextColor: [UIColor TextRed_Color]];
    [linkOrderValueLabel setText: [paymentDTO orders_num]];
    [linkOrderValueLabel setTextAlignment: NSTextAlignmentRight];
    [linkOrderValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: linkOrderValueLabel];
    [linkOrderValueLabel sd_layout].topEqualToView(linkOrderLabel).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    
    ///付款时间
    UILabel *payTimeLabel = [[UILabel alloc] init];
    [payTimeLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [payTimeLabel setText: @"提交时间"];
    [payTimeLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: payTimeLabel];
    [payTimeLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(linkOrderLabel, 12.0f).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    UILabel *payTimeValueLabel = [[UILabel alloc] init];
    [payTimeValueLabel setTextColor: [UIColor TextGray_Color]];
    [payTimeValueLabel setText: [paymentDTO receipts_date]];
    [payTimeValueLabel setTextAlignment: NSTextAlignmentRight];
    [payTimeValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: payTimeValueLabel];
    [payTimeValueLabel sd_layout].topEqualToView(payTimeLabel).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    
    ///确认收款时间
    UILabel *receiveTimeLabel = [[UILabel alloc] init];
    [receiveTimeLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [receiveTimeLabel setText: @"审核确认时间"];
    [receiveTimeLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: receiveTimeLabel];
    [receiveTimeLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(payTimeLabel, 12.0f).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    UILabel *receiveTimeValueLabel = [[UILabel alloc] init];
    [receiveTimeValueLabel setTextColor: [UIColor TextGray_Color]];
    [receiveTimeValueLabel setText: [paymentDTO update_date]];
    [receiveTimeValueLabel setTextAlignment: NSTextAlignmentRight];
    [receiveTimeValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: receiveTimeValueLabel];
    [receiveTimeValueLabel sd_layout].topEqualToView(receiveTimeLabel).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs((SCREEN_WIDTH - 2 * MARGIN_LEFT) / 2.0f).autoHeightRatio(0);
    
    ///收款账户
    UILabel *accountLabel = [[UILabel alloc] init];
    [accountLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [accountLabel setText: @"收款账户"];
    [accountLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: accountLabel];
    [accountLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(receiveTimeLabel, 12.0f).widthIs(80.0f).autoHeightRatio(0);
    UILabel *accountValueLabel = [[UILabel alloc] init];
    [accountValueLabel setTextColor: [UIColor TextGray_Color]];
    [accountValueLabel setText: [paymentDTO account_number]];
    [accountValueLabel setTextAlignment: NSTextAlignmentRight];
    [accountValueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: accountValueLabel];
    [accountValueLabel sd_layout].topEqualToView(accountLabel).rightSpaceToView(self.contentView, MARGIN_LEFT).widthIs(SCREEN_WIDTH - 2 * MARGIN_LEFT - 80.0f).autoHeightRatio(0);
    
    ///收款银行
    UILabel *bankLabel = [[UILabel alloc] init];
    [bankLabel setText: [paymentDTO bank_name]];
    [bankLabel setTextColor: [UIColor TextGray_Color]];
    [bankLabel setTextAlignment: NSTextAlignmentRight];
    [bankLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: bankLabel];
    [bankLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(accountLabel, 12.0f).widthIs(SCREEN_WIDTH - 2 * MARGIN_LEFT).autoHeightRatio(0);

    ///收款姓名
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setText: [paymentDTO account_name]];
    [nameLabel setTextColor: [UIColor TextGray_Color]];
    [nameLabel setTextAlignment: NSTextAlignmentRight];
    [nameLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [self.contentView addSubview: nameLabel];
    [nameLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(bankLabel, 12.0f).widthIs(SCREEN_WIDTH - 2 * MARGIN_LEFT).autoHeightRatio(0);
    
    /////底部section
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    [bottomView sd_layout].topSpaceToView(nameLabel, 25.0f).leftSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).heightIs(SECTIONVIEW_HEIHGT);
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SECTIONVIEW_HEIHGT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}

#pragma mark -
#pragma mark 样式3（备注）
- (void)addFloor_3{
    DHBPaymentRecordModuleDTO *paymentDTO = [[_floorDTO moduleList] firstObject];
    ///备注
    UILabel *remarksLabel = [[UILabel alloc] init];
    [remarksLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [remarksLabel setText: _floorDTO.floorName];
    [remarksLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: remarksLabel];
    [remarksLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, 15.0f).widthIs(SCREEN_WIDTH - 2 * MARGIN_LEFT).autoHeightRatio(0);
    
    DHBTextField *remarkstextField = [[DHBTextField alloc] init];
    [remarkstextField setStyle: kDHBTextField_MaxInputStyle];
    [remarkstextField showCancelButton: NO];
    [remarkstextField setText: [paymentDTO remark]];
    [remarkstextField setEnabled: NO];
    [self.contentView addSubview: remarkstextField];
    [remarkstextField sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(remarksLabel, 15.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs(40.0f);
    
    /////底部section
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    [bottomView sd_layout].topSpaceToView(remarkstextField, 15.0f).leftSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).heightIs(SECTIONVIEW_HEIHGT);
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SECTIONVIEW_HEIHGT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}

#pragma mark -
#pragma mark 样式4（凭证图片）
- (void)addFloor_4{
    DHBPaymentRecordModuleDTO *paymentDTO = [[_floorDTO moduleList] firstObject];
    ///凭证图片
    UILabel *voucherLabel = [[UILabel alloc] init];
    [voucherLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [voucherLabel setText: _floorDTO.floorName];
    [voucherLabel setTextColor: [UIColor TextBlack_Color]];
    [self.contentView addSubview: voucherLabel];
    [voucherLabel sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, 15.0f).widthIs(SCREEN_WIDTH - 2 * MARGIN_LEFT).autoHeightRatio(0);
    
    _voucherImageView = [[EGOImageView alloc] init];
    [_voucherImageView setImageURL: [NSURL URLWithString: [paymentDTO resource]]];
//    [_voucherImageView setDelegate: self];
    [self.contentView addSubview: _voucherImageView];
    [_voucherImageView sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(voucherLabel, 15.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs([[paymentDTO resource] length] > 0 ? SCREEN_WIDTH - 2 * MARGIN_LEFT : 0);
//    [voucherImageView layoutSubviews];
    
    /////底部section
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    [bottomView sd_layout].topSpaceToView(_voucherImageView, 15.0f).leftSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).heightIs(30.0f);
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}

- (void)imageViewLoadedImage:(SNUIImageView *)imageView{
//    [_voucherImageView sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(voucherLabel, 15.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs([[paymentDTO resource] length] > 0 ? SCREEN_WIDTH - 2 * MARGIN_LEFT : 0);
//    UIImage *image = [imageView image];
//    [self.contentView addSubview: _voucherImageView];
//    [_voucherImageView sd_layout].leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(voucherLabel, 15.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).autoHeightRatio();
}
@end
