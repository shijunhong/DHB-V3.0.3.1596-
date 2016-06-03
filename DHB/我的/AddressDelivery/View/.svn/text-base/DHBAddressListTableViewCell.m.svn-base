//
//  DHBAddressListTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN 15.0f
#import "DHBAddressListTableViewCell.h"

@implementation DHBAddressListTableViewCell
#pragma mark - init
- (UILabel *)name_lb{
    if(!_name_lb){
        _name_lb = [[UILabel alloc] init];
        [_name_lb setTextColor: [UIColor TextBlack_Color]];
        [_name_lb setFont: [UIFont systemFontOfSize: 15.0f]];
        [self.contentView addSubview:_name_lb];
    }
    return _name_lb;
}

- (UILabel *)phone_lb{
    if(!_phone_lb){
        _phone_lb = [[UILabel alloc] init];
        [_phone_lb setTextColor: [UIColor TextBlack_Color]];
        [_phone_lb setFont: [UIFont systemFontOfSize: 15.0f]];
        [self.contentView addSubview:_phone_lb];
    }
    return _phone_lb;
}

- (UILabel *)address_lb{
    if(!_address_lb){
        _address_lb = [[UILabel alloc] init];
        [_address_lb setTextColor: [UIColor TextGray_Color]];
        [_address_lb setNumberOfLines: 2];
        [_address_lb setLineBreakMode: NSLineBreakByTruncatingTail];
        [_address_lb setFont: [UIFont systemFontOfSize: 14.0f]];
        [self.contentView addSubview:_address_lb];
    }
    return _address_lb;
}

- (UIView *)topLineView{
    if(!_topLineView){
        _topLineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [_topLineView setBackgroundColor: [UIColor CellLine_Color]];
        [self.contentView addSubview:_topLineView];
    }
    return _topLineView;
}


- (UIImageView *)default_img{
    if(!_default_img){
        _default_img = [[UIImageView alloc] init];
        [_default_img setImage: [UIImage imageNamed: @"recom2"]];
        [self.contentView addSubview:_default_img];
    }
    return _default_img;
}

-(UIButton *)update_btn{
    if (!_update_btn)
    {
        _update_btn = [[UIButton alloc] init];
        [_update_btn setBackgroundColor:[UIColor clearColor]];
        [_update_btn addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_update_btn];
    }
    return _update_btn;
}

- (UIImageView *)arrow_img{
    if(!_arrow_img){
        _arrow_img = [[UIImageView alloc] init];
        [_arrow_img setContentMode: UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_arrow_img];
    }
    return _arrow_img;
}


- (UIView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [_bottomLine setBackgroundColor: [UIColor CellLine_Color]];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}


- (void)updateView:(AddressModuleDTO*)address{
    self.address = address;
    
    ///顶部分割线
    self.topLineView.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,-40.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    ///箭头，修改img
    if (self.is_orderSelct)
    {
        [self.arrow_img setImage:[UIImage imageNamed:@"edit"]];
        self.arrow_img.sd_layout.rightSpaceToView(self.contentView, MARGIN).heightIs(16.0f).widthIs(16.0f).centerYEqualToView(self.contentView);
    }
    else
    {
        [self.arrow_img setImage:[UIImage imageNamed:@"arrow"]];
        self.arrow_img.sd_layout.rightSpaceToView(self.contentView, 8.0f).heightIs(22.0f).widthIs(22.0f).centerYEqualToView(self.contentView);
    }
    
    ///收货人名称
    self.default_img.sd_layout.leftSpaceToView(self.contentView, MARGIN).topSpaceToView(self.contentView, MARGIN).widthIs(40).heightIs(20);
    if([address.is_default isEqualToString:@"F"])
    {
        [self.default_img setHidden:YES];
        self.default_img.sd_layout.widthIs(0).leftSpaceToView(self.contentView,0.0f);
    }
    self.name_lb.text = address.contact;
    float nameWidth = [self.name_lb.text sizeWithFont:self.name_lb.font constrainedToSize:CGSizeMake(MAXFLOAT,15.0f)].width;
    self.name_lb.sd_layout.leftSpaceToView(self.default_img, MARGIN).topSpaceToView(self.contentView, MARGIN).widthIs(nameWidth).autoHeightRatio(0.0f);
    
    ///收货人联系方式
    self.phone_lb.text = address.phone;
    self.phone_lb.sd_layout.leftSpaceToView(self.name_lb,MARGIN).topSpaceToView(self.contentView, MARGIN).rightSpaceToView(self.arrow_img,MARGIN).autoHeightRatio(0);
    
    ///收货地址
    self.address_lb.text = [NSString stringWithFormat:@"%@,%@（%@）",address.address,address.address_detail,address.consignee];
    self.address_lb.sd_layout.leftSpaceToView(self.contentView, MARGIN).rightSpaceToView(self.arrow_img,MARGIN).topSpaceToView(self.name_lb, MARGIN).autoHeightRatio(0);
    
    //底部
    self.bottomLine.sd_layout.topSpaceToView(self.address_lb, MARGIN).leftSpaceToView(self.contentView, -40.0f).rightSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    //修改btn
    self.update_btn.sd_layout.topSpaceToView(self.contentView,MARGIN).leftEqualToView(self.arrow_img).rightSpaceToView(self.contentView,0.0f).bottomSpaceToView(self.bottomLine,MARGIN);
    
    [self setupAutoHeightWithBottomView: self.bottomLine bottomMargin:0.0f];
}


-(void)updateAction:(UIButton*)sender{
    [self.delegate DHBAddressListTableViewCell:self onClickupdate:sender];
}
@end
