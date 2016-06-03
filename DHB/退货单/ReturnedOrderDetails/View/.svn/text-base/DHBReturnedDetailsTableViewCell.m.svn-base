//
//  HDBReturnedDetailsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0f
#define TITLE_LABEL_HEIGHT 40.0f
#define ICONIMAGEVIEW_HEIGHT 20.0F
#define BASE_LABEL_HEIGHT 20.0f
#define ARROW_WIDTHANDHEIGHT 20.0f

#import "DHBReturnedDetailsTableViewCell.h"


@implementation DHBReturnedDetailsTableViewCell

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, (TITLE_LABEL_HEIGHT - ICONIMAGEVIEW_HEIGHT) / 2.0F, ICONIMAGEVIEW_HEIGHT, ICONIMAGEVIEW_HEIGHT)];
        [_iconImageView setContentMode: UIViewContentModeScaleAspectFit];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_titleLabel setTextColor: HEX_RGB(0x424242)];
    }
    return _titleLabel;
}

- (UILabel *)subContentLabel{
    if(!_subContentLabel){
        _subContentLabel = [[UILabel alloc] init];
        [_subContentLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [_subContentLabel setTextAlignment: NSTextAlignmentRight];
        [_subContentLabel setTextColor: [UIColor TextGray_Color]];
    }
    return _subContentLabel;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        [_arrowImageView setImage: [UIImage imageNamed: @"arrow"]];
        [_arrowImageView setContentMode: UIViewContentModeScaleAspectFit];
    }
    return _arrowImageView;
}

- (id)initWithFloorDTO: (HomeFloorDTO *)dto style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    }
    return self;
}

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
}


#pragma mark -
#pragma mark 样式1（退货状态）
- (void)addFloor_1{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [mainView setBackgroundColor: [_floorDTO color]];
    [self.contentView addSubview: mainView];
    //图标
    [self.iconImageView setImage: [UIImage imageNamed: @"ddzt"]];
    [mainView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 3.0F, TITLE_LABEL_HEIGHT)];
    [mainView addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //状态
    CGFloat origin_x = self.titleLabel.frame.size.width + self.frame.origin.x;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - ARROW_WIDTHANDHEIGHT - 2 * MARGIN_LEFT, TITLE_LABEL_HEIGHT)];
    [statusLabel setTextColor: [UIColor TextGray_Color]];
    [statusLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [statusLabel setText: [order status]];
    [statusLabel setTextAlignment: NSTextAlignmentRight];
    [mainView addSubview: statusLabel];
    //箭头
    origin_x = statusLabel.frame.size.width + statusLabel.frame.origin.x + MARGIN_LEFT;
    [self.arrowImageView setFrame: CGRectMake(origin_x, (TITLE_LABEL_HEIGHT - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
    [mainView addSubview: self.arrowImageView];
    //退单号单号
    CGFloat origin_y = self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
    _orderIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [_orderIDLabel setTextColor: [UIColor TextGray_Color]];
    [_orderIDLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [_orderIDLabel setText: [NSString stringWithFormat: @"退单号：%@", [order returns_num]]];
    [mainView addSubview: _orderIDLabel];
    //下单时间
    origin_y = _orderIDLabel.frame.size.height + _orderIDLabel.frame.origin.y;
    _orderTimeLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [_orderTimeLabel setTextColor: [UIColor TextGray_Color]];
    [_orderTimeLabel setText: [NSString stringWithFormat: @"下单时间：%@", [order create_date]]];
    [_orderTimeLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [mainView addSubview: _orderTimeLabel];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, mainView.frame.size.height - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [mainView addSubview: lineView];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, mainView.frame.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [mainView addSubview: lineView];
}

#pragma mark -
#pragma mark 样式2（退货清单）
- (void)addFloor_2{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    //图标
    [self.iconImageView setTop: (_floorDTO.hight - ICONIMAGEVIEW_HEIGHT) / 2.0f];
    [self.iconImageView setImage: [UIImage imageNamed: @"spqd"]];
    [self.contentView addSubview: self.iconImageView];
    
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 2.0F, _floorDTO.hight)];
    [self.titleLabel setText: [_floorDTO floorName]];
    [self.contentView addSubview: self.titleLabel];
    //子内容
    CGFloat origin_x = self.titleLabel.frame.size.width + MARGIN_LEFT;
    [self.subContentLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - ARROW_WIDTHANDHEIGHT - 2 * MARGIN_LEFT,  _floorDTO.hight)];
    [self.subContentLabel setText: [NSString stringWithFormat: @"%@种", [order returns_details_count]]];
    [self.contentView addSubview: self.subContentLabel];
    //箭头
    origin_x = self.subContentLabel.frame.size.width + self.subContentLabel.frame.origin.x + MARGIN_LEFT;
    [self.arrowImageView setFrame: CGRectMake(origin_x, ( _floorDTO.hight - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
    [self.contentView addSubview: self.arrowImageView];
    //下划线
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式3(退货金额)
- (void)addFloor_3{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [mainView setBackgroundColor: [UIColor whiteColor]];
    [self.contentView addSubview: mainView];
    //图标
    [self.iconImageView setImage: [UIImage imageNamed: @"ddje"]];
    [mainView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 5.0f, SCREEN_WIDTH / 2.0F, _floorDTO.hight / 2.0f - 5.0f)];
    [self.titleLabel setText: [_floorDTO floorName]];
    [mainView addSubview: self.titleLabel];
    //退货金额
    CGFloat origin_x = self.titleLabel.frame.size.width + MARGIN_LEFT;
    [self.subContentLabel setFrame: CGRectMake(origin_x, 5.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight / 2.0f - 5.0f)];
    [self.subContentLabel setTextColor: [UIColor Money_Color]];
    [self.subContentLabel setText: [NSString stringWithFormat: @"¥%@",[order discount_total]]];
    [mainView addSubview: self.subContentLabel];
    //子标题
    CGFloat origin_y = self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.titleLabel.left + 2.0f, origin_y, SCREEN_WIDTH / 2.0F, _floorDTO.hight / 2.0f - 5.0f)];
    [subTitleLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [subTitleLabel setTextColor: [UIColor TextGray_Color]];
    [subTitleLabel setText: @"商品金额"];
    [mainView addSubview: subTitleLabel];
    //商品金额
    origin_x = subTitleLabel.frame.size.width + subTitleLabel.frame.origin.x + MARGIN_LEFT;
    UILabel *priceLable = [[UILabel alloc]  initWithFrame: CGRectMake(origin_x, origin_y, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight / 2.0f - 5.0f)];
    [priceLable setTextColor: [UIColor TextGray_Color]];
    [priceLable setText: [NSString stringWithFormat: @"¥%@",[order returns_total]]];
    [priceLable setTextAlignment: NSTextAlignmentRight];
    [priceLable setFont: [UIFont systemFontOfSize: 12.0f]];
    [self.contentView addSubview: priceLable];
    //下划线
    [self initLineisBottom: NO];
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式4（备注视图）
- (void)addFloor_4{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    ///主视图
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [mainView setBackgroundColor: [_floorDTO color]];
    [self.contentView addSubview: mainView];
    ///图标
    [self.iconImageView setTop: MARGIN_LEFT / 2.0f + (TITLE_LABEL_HEIGHT - ICONIMAGEVIEW_HEIGHT) / 2.0f];
    [self.iconImageView setImage: [UIImage imageNamed: @"bz"]];
    [mainView addSubview: self.iconImageView];
    //标题
    CGFloat origin_x = self.iconImageView.right + MARGIN_LEFT;
    [self.titleLabel setFrame: CGRectMake(origin_x, MARGIN_LEFT / 2.0f, SCREEN_WIDTH / 2.0f, TITLE_LABEL_HEIGHT)];
    [self.titleLabel setTextColor: [UIColor TextGray_Color]];
    [self.titleLabel setText: [_floorDTO floorName]];
    [mainView addSubview: self.titleLabel];
    if([[order returns_reason] length] > 0){
        //内容
        CGFloat origin_y = self.titleLabel.frame.origin.y + TITLE_LABEL_HEIGHT;
        _contentLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, origin_y, SCREEN_WIDTH - origin_x - MARGIN_LEFT, mainView.frame.size.height - origin_y - MARGIN_LEFT)];
        [_contentLabel setNumberOfLines: 2];
        [_contentLabel setLineBreakMode: NSLineBreakByTruncatingTail];
        [_contentLabel setText: [order returns_reason]];
    }
    else{
        origin_x = SCREEN_WIDTH / 2.0f;
        _contentLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight)];
        [_contentLabel setTextAlignment: NSTextAlignmentRight];
        [_contentLabel setText: @"无"];
    }
    [_contentLabel setTextColor: [UIColor TextGray_Color]];
    [_contentLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [mainView addSubview: _contentLabel];
    //下划线
    [self initLineisBottom: NO];
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式5(退货附件)
- (void)addFloor_5{
     DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    //图标
    [self.iconImageView setTop: (_floorDTO.hight - ICONIMAGEVIEW_HEIGHT) / 2.0f];
    [self.iconImageView setImage: [UIImage imageNamed: @"ddfj"]];
    [self.contentView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 2.0F, _floorDTO.hight)];
    [self.contentView addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //子内容
    CGFloat origin_x = self.titleLabel.frame.size.width + MARGIN_LEFT;
    [self.subContentLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight)];
    NSString *numberStr = [[order attachmentNumber] integerValue] > 0 ? [NSString stringWithFormat: @"%@个", [order attachmentNumber]] : @"无";
    if(![numberStr isEqualToString: @"无"]){
        //箭头(当操作日志不为0的时候，显示箭头)
        [self.arrowImageView setFrame: CGRectMake(SCREEN_WIDTH - MARGIN_LEFT - ARROW_WIDTHANDHEIGHT, (_floorDTO.hight - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
        [self.contentView addSubview: self.arrowImageView];
        //
        [self.subContentLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT - self.arrowImageView.size.width, _floorDTO.hight)];
    }
    [self.subContentLabel setText: numberStr];
    [self.contentView addSubview: self.subContentLabel];
    //下划线
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式6(操作日志)
- (void)addFloor_6{
//    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    //图标
    [self.iconImageView setTop: (_floorDTO.hight - ICONIMAGEVIEW_HEIGHT) / 2.0f];
    [self.iconImageView setImage: [UIImage imageNamed: @"ccrz"]];
    [self.contentView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 2.0F, _floorDTO.hight)];
    [self.contentView addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //子内容
//    CGFloat origin_x = self.titleLabel.frame.size.width + MARGIN_LEFT;
//    [self.subContentLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight)];
//    NSString *logStr = [[order log_returns] count] > 0 ? [NSString stringWithFormat: @"%ld", (long)[[order log_returns] count]] : @"无";
//    if(![logStr isEqualToString: @"无"]){
//        //箭头(当操作日志不为0的时候，显示箭头)
//        [self.arrowImageView setFrame: CGRectMake(SCREEN_WIDTH - MARGIN_LEFT - ARROW_WIDTHANDHEIGHT, (_floorDTO.hight - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
//        [self addSubview: self.arrowImageView];
//        //
//        [self.subContentLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT - self.arrowImageView.size.width, _floorDTO.hight)];
//    }
//    [self.subContentLabel setText: logStr];
//    [self addSubview: self.subContentLabel];
    
    //箭头
    [self.arrowImageView setFrame: CGRectMake(SCREEN_WIDTH - MARGIN_LEFT - ARROW_WIDTHANDHEIGHT, (_floorDTO.hight - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
    [self.contentView addSubview: self.arrowImageView];
    //下划线
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式7（收货人信息）
- (void)addFloor_7{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [mainView setBackgroundColor: [UIColor whiteColor]];
    [self.contentView addSubview: mainView];
    //图标
    [self.iconImageView setImage: [UIImage imageNamed: @"shr"]];
    [mainView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 2.0F, TITLE_LABEL_HEIGHT)];
    [mainView addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //收货人
    CGFloat origin_y = self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * MARGIN_LEFT - self.iconImageView.right, BASE_LABEL_HEIGHT)];
    [infoLabel setText: [NSString stringWithFormat: @"%@      %@", [order returns_consignee], [order returns_phone]]];
    [infoLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [infoLabel setTextColor: [UIColor TextGray_Color]];
    [mainView addSubview: infoLabel];
    //地址
    origin_y += BASE_LABEL_HEIGHT;
    UILabel *addressLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * MARGIN_LEFT - self.iconImageView.right, _floorDTO.hight - origin_y - MARGIN_LEFT)];
    [addressLabel setText: [order returns_address]];
    [addressLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [addressLabel setTextColor: [UIColor TextGray_Color]];
    [mainView addSubview: addressLabel];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, _floorDTO.hight - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xf8f8f8)];
    [mainView addSubview: lineView];
}

#pragma mark -
#pragma mark 样式8（物流）
- (void)addFloor_8{
    DHBReturnsOrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [mainView setBackgroundColor: [_floorDTO color]];
    [self.contentView addSubview: mainView];
    //图标
    [self.iconImageView setImage: [UIImage imageNamed: @"psfs"]];
    [mainView addSubview: self.iconImageView];
    //标题
    [self.titleLabel setFrame: CGRectMake(self.iconImageView.right + MARGIN_LEFT, 0.0f, SCREEN_WIDTH / 2.0F, TITLE_LABEL_HEIGHT)];
    [mainView addSubview: self.titleLabel];
    [self.titleLabel setText: @"物流"];

    //箭头
    [self.arrowImageView setFrame: CGRectMake(SCREEN_WIDTH - ARROW_WIDTHANDHEIGHT - MARGIN_LEFT, (TITLE_LABEL_HEIGHT - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
    [mainView addSubview: self.arrowImageView];
    //物流公司
    CGFloat origin_y = self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
    UILabel *companyLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.titleLabel.left, origin_y, 60.0f, BASE_LABEL_HEIGHT)];
    [companyLabel setTextColor: [UIColor TextGray_Color]];
    [companyLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [companyLabel setText:  @"物流公司:"];
    [mainView addSubview: companyLabel];
    CGFloat origin_x = companyLabel.frame.size.width + companyLabel.frame.origin.x;
    UILabel *companyValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, origin_y, SCREEN_WIDTH - origin_x -2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [companyValueLabel setTextColor: [UIColor TextGray_Color]];
    [companyValueLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    if([[[order deliveryMethodDTO ] send_company] length] > 0){
        [companyValueLabel setText:  [[order deliveryMethodDTO ] send_company]];
        [companyValueLabel setTextAlignment: NSTextAlignmentLeft];
    }
    else{
        [companyValueLabel setText: @"/"];
        [companyValueLabel setTextAlignment: NSTextAlignmentRight];
    }
    [mainView addSubview: companyValueLabel];
    
    //物流单号
    origin_y = companyLabel.frame.size.height + companyLabel.frame.origin.y;
    UILabel *deliveryIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.titleLabel.left, origin_y, 60.0f, BASE_LABEL_HEIGHT)];
    [deliveryIDLabel setTextColor: [UIColor TextGray_Color]];
    [deliveryIDLabel setText: @"物流单号:"];
    [deliveryIDLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [mainView addSubview: deliveryIDLabel];
    //
    origin_x = deliveryIDLabel.frame.size.width + deliveryIDLabel.frame.origin.x;
    UILabel *deliveryIDValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, origin_y, SCREEN_WIDTH - origin_x -2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [deliveryIDValueLabel setTextColor: [UIColor TextGray_Color]];
    [deliveryIDValueLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    if([[[order deliveryMethodDTO ] send_no] length] > 0){
        [deliveryIDValueLabel setText:  [[order deliveryMethodDTO ] send_no]];
        [deliveryIDValueLabel setTextAlignment: NSTextAlignmentLeft];
    }
    else{
        [deliveryIDValueLabel setText: @"/"];
        [deliveryIDValueLabel setTextAlignment: NSTextAlignmentRight];
    }
    [mainView addSubview: deliveryIDValueLabel];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, mainView.frame.size.height - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [mainView addSubview: lineView];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, mainView.frame.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [mainView addSubview: lineView];
}
@end
