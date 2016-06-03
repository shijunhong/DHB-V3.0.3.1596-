//
//  DHBPaymentRecordListCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentRecordListCell.h"
#import "OrderModuleDTO.h"

@implementation DHBPaymentRecordListCell
#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto whitIndex:(NSIndexPath*)index{
    _floorDTO = dto;
    _index = index;
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

#pragma mark 样式1（金额）
- (void)addFloor_1{
    OrderModuleDTO *order = [self.floorDTO.moduleList safeObjectAtIndex:0];
    
    //应付金额
    UILabel *discountLabel = [[UILabel alloc] init];
    [discountLabel setTextColor: [UIColor TextBlack_Color]];
    [discountLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [discountLabel setText: @"应付金额"];
    [self.contentView addSubview: discountLabel];
    discountLabel.sd_layout
    .topSpaceToView(self.contentView, 15.0f)
    .leftSpaceToView(self.contentView, 15.0f)
    .widthIs(15.0*4)
    .autoHeightRatio(0);
    
    //应付金额 金额
    UILabel *discount_lb = [[UILabel alloc] init];
    [discount_lb setTextColor: [UIColor Money_Color]];
    [discount_lb setFont: [UIFont systemFontOfSize: 14.0f]];
    [discount_lb setTextAlignment:NSTextAlignmentRight];
    [discount_lb setText: [NSString stringWithFormat:@"%@%@",L(@"￥"),order.discount_total]];
    [self.contentView addSubview: discount_lb];
    discount_lb.sd_layout
    .topEqualToView(discountLabel)
    .rightSpaceToView(self.contentView, 15.0f)
    .widthIs(([order.discount_total length]+1)*15.0f)
    .autoHeightRatio(0);
    
    
    //已付金额
    UILabel *paidLabel = [[UILabel alloc] init];
    [paidLabel setTextColor: [UIColor TextBlack_Color]];
    [paidLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [paidLabel setText: @"已付金额"];
    [self.contentView addSubview: paidLabel];
    paidLabel.sd_layout
    .topSpaceToView(discountLabel, 10.0f)
    .leftEqualToView(discountLabel)
    .widthIs(15.0*4)
    .autoHeightRatio(0);
    
    //已付金额 金额
    UILabel *paid_lb = [[UILabel alloc] init];
    [paid_lb setTextColor: [UIColor Money_Color]];
    [paid_lb setFont: [UIFont systemFontOfSize: 14.0f]];
    [paid_lb setTextAlignment:NSTextAlignmentRight];
    [paid_lb setText: [NSString stringWithFormat:@"%@%@",L(@"￥"),order.account_paid]];
    [self.contentView addSubview: paid_lb];
    paid_lb.sd_layout
    .topEqualToView(paidLabel)
    .rightSpaceToView(self.contentView, 15.0f)
    .widthIs(([order.discount_total length]+1)*15.0f)
    .autoHeightRatio(0);
    
    
    //待付金额
    UILabel *notpaidLable = [[UILabel alloc] init];
    [notpaidLable setTextColor: [UIColor TextBlack_Color]];
    [notpaidLable setFont: [UIFont systemFontOfSize: 15.0f]];
    [notpaidLable setText: @"待付金额"];
    [self.contentView addSubview: notpaidLable];
    notpaidLable.sd_layout
    .topSpaceToView(paidLabel, 10.0f)
    .leftEqualToView(discountLabel)
    .widthIs(15.0*4)
    .autoHeightRatio(0);
    
    //待付金额 金额
    UILabel *notpaid_lb = [[UILabel alloc] init];
    [notpaid_lb setTextColor: [UIColor Money_Color]];
    [notpaid_lb setFont: [UIFont systemFontOfSize: 14.0f]];
    [notpaid_lb setTextAlignment:NSTextAlignmentRight];
    [notpaid_lb setText: [NSString stringWithFormat:@"%@%@",L(@"￥"),order.account_notpaid]];
    [self.contentView addSubview: notpaid_lb];
    notpaid_lb.sd_layout
    .topEqualToView(notpaidLable)
    .rightSpaceToView(self.contentView, 15.0f)
    .widthIs(([order.discount_total length]+1)*15.0f)
    .autoHeightRatio(0);
    
    
    /////底部
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    bottomView.sd_layout
    .topSpaceToView(notpaidLable, 15.0f)
    .leftSpaceToView(self.contentView, 0.0f)
    .rightSpaceToView(self.contentView, 0.0f)
    .heightIs(8.0f);
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}

#pragma mark 样式2（付款信息）
- (void)addFloor_2{
    NSArray *arr = [self.floorDTO.moduleList safeObjectAtIndex:0];
    NSDictionary *data = [arr safeObjectAtIndex:self.index.row];
    
    NSString * type = [data EncodeStringFromDicWithKey:@"type_id"];
    UILabel *payType_lb = [UILabel new];
    [payType_lb setTextColor:[UIColor TextBlack_Color]];
    [payType_lb setFont:[UIFont systemFontOfSize:15.0f]];
    [payType_lb setText:type];
    [self.contentView addSubview:payType_lb];
    payType_lb.sd_layout.leftSpaceToView(self.contentView,15.0f).topSpaceToView(self.contentView,15.0f).widthIs([type length]*150.f).autoHeightRatio(0);
    
    UIImageView *image_vi = [UIImageView new];
    [image_vi setImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:image_vi];
    image_vi.sd_layout.topSpaceToView(self.contentView,14.0f).rightSpaceToView(self.contentView, 10.0f).widthIs(22.0f).heightIs(22.0f);
    
    NSString *status = [data EncodeStringFromDicWithKey:@"status"];
    UILabel *status_lb = [UILabel new];
    [status_lb setFont:[UIFont systemFontOfSize:15.0f]];
    [status_lb setTextColor:[UIColor TextBlack_Color]];
    if ([status isEqualToString:@"已确定"])
    {
        [status_lb setTextColor:HEX_RGB(0xff8921)];
    }
    else if ([status isEqualToString:@"已确认"])
    {
        [status_lb setTextColor:HEX_RGB(0x37bc49)];
    }
    [status_lb setText:status];
    [status_lb setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:status_lb];
    status_lb.sd_layout.topEqualToView(payType_lb).rightSpaceToView(image_vi,3.0f).widthIs([status length]*15.0f).autoHeightRatio(0);
    
    NSString *time = [data EncodeStringFromDicWithKey:@"create_date"];
    UILabel *time_lb = [UILabel new];
    [time_lb setTextColor:[UIColor TextGray_Color]];
    [time_lb setFont:[UIFont systemFontOfSize:14.0f]];
    [time_lb setText:time];
    [self.contentView addSubview:time_lb];
    time_lb.sd_layout.topSpaceToView(payType_lb,35.0f).leftEqualToView(payType_lb).widthIs([time length]*14.0f).autoHeightRatio(0);
    
    NSString *amount = [data EncodeStringFromDicWithKey:@"amount"];
    UILabel *amount_lb = [UILabel new];
    [amount_lb setTextColor:[UIColor TextGray_Color]];
    [amount_lb setFont:[UIFont systemFontOfSize:14.0f]];
    [amount_lb setTextAlignment:NSTextAlignmentRight];
    [amount_lb setText:[NSString stringWithFormat:@"%@%@",L(@"￥"),amount]];
    [self.contentView addSubview:amount_lb];
    amount_lb.sd_layout.topEqualToView(time_lb).rightSpaceToView(self.contentView,15.0f).widthIs(([amount length]+1)*14.0f).autoHeightRatio(0);
    
    
    //顶部
    UIView *toplineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [toplineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [self.contentView addSubview: toplineView];
    /////底部
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: bottomView];
    bottomView.sd_layout
    .topSpaceToView(time_lb, 15.0f)
    .leftSpaceToView(self.contentView, 0.0f)
    .rightSpaceToView(self.contentView, 0.0f)
    .heightIs(8.0f);
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xd8d8d8)];
    [bottomView addSubview: lineView];
    ///cell自适应高度
    [self setupAutoHeightWithBottomView: bottomView bottomMargin: 0.0f];
}
@end
