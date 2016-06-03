//
//  OrderListTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell
-(UIView *)topLine{
    if (!_topLine)
    {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor CellLine_Color];
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

-(UIImageView *)orderStatus_img{
    if (!_orderStatus_img)
    {
        _orderStatus_img =[UIImageView new];
        _orderStatus_img.image = [UIImage imageNamed:@"label"];
        [self.contentView addSubview:_orderStatus_img];
    }
    return _orderStatus_img;
}

-(UILabel *)orderNum_lb{
    if (!_orderNum_lb)
    {
        _orderNum_lb = [UILabel new];
        _orderNum_lb.font = [UIFont systemFontOfSize:15.0f];
        _orderNum_lb.textColor = [UIColor TextRed_Color];
        [self.contentView addSubview:_orderNum_lb];
    }
    return _orderNum_lb;
}

-(UILabel *)orderStatus_lb{
    if (!_orderStatus_lb)
    {
        _orderStatus_lb = [UILabel new];
        _orderStatus_lb.font = [UIFont systemFontOfSize:15.0f];
        _orderStatus_lb.textColor = [UIColor TextGray_Color];
        _orderStatus_lb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_orderStatus_lb];
    }
    return _orderStatus_lb;
}

-(UIView *)cutLine{
    if (!_cutLine)
    {
        _cutLine = [UIView new];
        _cutLine.backgroundColor = [UIColor CellLine_Color];
        [self.contentView addSubview:_cutLine];
    }
    return _cutLine;
}

-(UILabel *)orderPrice_lb{
    if (!_orderPrice_lb)
    {
        _orderPrice_lb = [UILabel new];
        _orderPrice_lb.font = [UIFont systemFontOfSize:14.0f];
        _orderPrice_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_orderPrice_lb];
    }
    return _orderPrice_lb;
}

-(UILabel *)goodsNum_lb{
    if (!_goodsNum_lb)
    {
        _goodsNum_lb = [UILabel new];
        _goodsNum_lb.font = [UIFont systemFontOfSize:14.0f];
        _goodsNum_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_goodsNum_lb];
    }
    return _goodsNum_lb;
}

-(UILabel *)orderDate_lb{
    if (!_orderDate_lb)
    {
        _orderDate_lb = [UILabel new];
        _orderDate_lb.font = [UIFont systemFontOfSize:14.0f];
        _orderDate_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_orderDate_lb];
    }
    return _orderDate_lb;
}

-(DHBButton *)pay_btn{
    if (!_pay_btn)
    {
        _pay_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
        _pay_btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_pay_btn setTitle:@"付款" forState:UIControlStateNormal];
        [_pay_btn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_pay_btn];
    }
    return _pay_btn;
}

-(UIView *)bottom_vi{
    if (!_bottom_vi)
    {
        _bottom_vi = [UIView new];
        _bottom_vi.backgroundColor = [UIColor UIViewBackGroundColor];
        [self.contentView addSubview:_bottom_vi];
        UIImageView *bottom_img = [UIImageView new];
        bottom_img.image = [UIImage imageNamed:@"order"];
        [_bottom_vi addSubview:bottom_img];
        bottom_img.sd_layout.topSpaceToView(_bottom_vi,0.0f).leftSpaceToView(_bottom_vi,0.0f).rightSpaceToView(_bottom_vi,0.0f).heightIs(6.0f);
    }
    return _bottom_vi;
}

- (void)updateViewWithOrderDTO:(OrderModuleDTO *)dto{
    self.order = dto;
    
    self.topLine.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    self.orderNum_lb.text = dto.orders_num;
    if ([dto.orders_type isEqualToString:@"特批价"])
    {
        self.orderStatus_img.sd_layout.topSpaceToView(self.contentView,16.0f).leftSpaceToView(self.contentView,15.0f).widthIs(36.0f).heightIs(16.0f);
        self.orderNum_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,56.0f).autoHeightRatio(0);
    }
    else
    {
        TTVIEW_RELEASE_SAFELY(self.orderStatus_img);
        self.orderNum_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    }
    [self.orderNum_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    self.orderStatus_lb.text = dto.status;
    self.orderStatus_lb.sd_layout.topSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).widthIs(150.0f).autoHeightRatio(0);
    
    self.cutLine.sd_layout.topSpaceToView(self.orderNum_lb,15.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    self.orderPrice_lb.text = [NSString stringWithFormat:@"订单金额 ￥%@",dto.discount_total];
    self.orderPrice_lb.sd_layout.topSpaceToView(self.cutLine,15.0f).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f+60.0f).autoHeightRatio(0);
    
    self.goodsNum_lb.text = [NSString stringWithFormat:@"商品数量 %ld种",(long)dto.goods_count];
    self.goodsNum_lb.sd_layout.topSpaceToView(self.orderPrice_lb,8.0f).leftEqualToView(self.orderPrice_lb).rightEqualToView(self.orderPrice_lb).autoHeightRatio(0);
    
    self.orderDate_lb.text = [NSString stringWithFormat:@"下单时间 %@",dto.create_date];
    self.orderDate_lb.sd_layout.topSpaceToView(self.goodsNum_lb,8.0f).leftEqualToView(self.goodsNum_lb).rightEqualToView(self.goodsNum_lb).autoHeightRatio(0);
    
    if ([dto.is_pay isEqualToString:@"F"])
    {
        [self.pay_btn setHidden:YES];
    }
    else if([dto.is_pay isEqualToString:@"T"])
    {
        [self.pay_btn setHidden:NO];
        self.pay_btn.sd_layout.bottomEqualToView(self.orderDate_lb).rightSpaceToView(self.contentView,15.0f).widthIs(60.0f).heightIs(30.0f);
    }
    
    self.bottom_vi.sd_layout.topSpaceToView(self.orderDate_lb,15.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(14.0f);
    
    [self setupAutoHeightWithBottomView:self.bottom_vi bottomMargin:0.0f];
}

-(void)payAction:(UIButton*)sender{
    [self.delegate OrderListTableViewCell:self withOrder:self.order];
}
@end
