//
//  DHBPaymentHistoryCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentHistoryCell.h"

@implementation DHBPaymentHistoryCell

-(DHBLabel *)date_lb{
    if (!_date_lb) {
        _date_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _date_lb.font = [UIFont systemFontOfSize:14.0f];
        _date_lb.textColor = HEX_RGB(0xd1d1d1);
        _date_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _date_lb;
}

-(DHBLabel *)type_lb{
    if (!_type_lb) {
        _type_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _type_lb.font = [UIFont systemFontOfSize:14.0f];
        _type_lb.textColor = [UIColor TextBlack_Color];
    }
    return _type_lb;
}

-(DHBLabel *)payType_lb{
    if (!_payType_lb) {
        _payType_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _payType_lb.font = [UIFont systemFontOfSize:12.0f];
        _payType_lb.textColor = [UIColor TextGray_Color];
    }
    return _payType_lb;
}

-(DHBLabel *)amount_lb{
    if (!_amount_lb) {
        _amount_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _amount_lb.font = [UIFont systemFontOfSize: 18.0f];
        _amount_lb.textAlignment = NSTextAlignmentRight;
    }
    return _amount_lb;
}

-(DHBLabel *)state_lb{
    if (!_state_lb) {
        _state_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _state_lb.font = [UIFont systemFontOfSize: 10.0f];
        _state_lb.textAlignment = NSTextAlignmentRight;
    }
    return _state_lb;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self.contentView setBackgroundColor: [UIColor clearColor]];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        ///
        [self.contentView addSubview:self.date_lb];
        [self.contentView addSubview:self.type_lb];
        [self.contentView addSubview:self.payType_lb];
        [self.contentView addSubview:self.amount_lb];
        [self.contentView addSubview:self.state_lb];
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(80.0f, 10.0f, 1.0f, 60.0f - 20.0f)];
        [lineView setBackgroundColor: HEX_RGB(0xf2f2f2)];
        [self.contentView addSubview:lineView];
        [self.contentView initLineisBottom:NO];
        [self.contentView initSectionViewTop_bottom:NO isHigth:DEFAULT_SECTION_HEIGHT];
    }
    return self;
}


- (void)updateViewWithDTO:(DHBPayHistoryInfoModuleDTO *) dto{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM月dd日"];
    self.date_lb.text = [formatter stringFromDate: [dto create_date]];
    self.date_lb.sd_layout.topSpaceToView(self.contentView,20.0f).leftSpaceToView(self.contentView,10.0f).widthIs(65.0f).autoHeightRatio(0);
    
    CGFloat lb_high = (60.0f-2*10.0f)/2.0f;
    [self.type_lb setText:dto.incexp_id];
    self.type_lb.sd_layout.topSpaceToView(self.contentView,10.0f).leftSpaceToView(self.date_lb,20.0f).heightIs(lb_high).widthIs(150.0f);
    
    [self.payType_lb setText:dto.type_id];
    self.payType_lb.sd_layout.topSpaceToView(self.type_lb,0.0f).leftEqualToView(self.type_lb).heightIs(lb_high).widthIs(150.0f);
    
    if([dto.status isEqualToString:@"已确认"])
    {
        [self.amount_lb setTextColor:HEX_RGB(0x333333)];
        [self.state_lb setTextColor:HEX_RGB(0x333333)];
    }
    else if([dto.status isEqualToString:@"已取消"])
    {
        [self.amount_lb setTextColor:HEX_RGB(0x9e9e9e)];
        [self.state_lb setTextColor:HEX_RGB(0x9e9e9e)];
    }
    else if([dto.status isEqualToString:@"待确认"])
    {
        [self.amount_lb setTextColor:HEX_RGB(0xffaa00)];
        [self.state_lb setTextColor:HEX_RGB(0xffaa00)];
    }
    
    [self.amount_lb setText:dto.amount];
    self.amount_lb.sd_layout.topEqualToView(self.type_lb).rightSpaceToView(self.contentView,15.0f).heightIs(lb_high).leftSpaceToView(self.type_lb,0.0f);
    
    [self.state_lb setText:dto.status];
    self.state_lb.sd_layout.topEqualToView(self.payType_lb).rightEqualToView(self.amount_lb).heightIs(lb_high).leftSpaceToView(self.payType_lb,0.0f);
}

@end
