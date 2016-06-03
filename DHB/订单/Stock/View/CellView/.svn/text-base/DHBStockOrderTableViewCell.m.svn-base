//
//  DHBStockOrderTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBStockOrderTableViewCell.h"

@implementation DHBStockOrderTableViewCell

- (void)updateViewWithDTO:(ShipsModuleDTO *)ships{
    [self.contentView removeAllSubviews];
    
    self.icon_iv = [[UIImageView alloc] init];
    [self.icon_iv setImage:[UIImage imageNamed:@"dck"]];
    [self.contentView addSubview:self.icon_iv];
    self.icon_iv.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(19.0f).heightIs(19.0f);
    
    self.name_lb = [UILabel new];
    self.name_lb.font = [UIFont systemFontOfSize:14.0f];
    self.name_lb.textColor = [UIColor TextBlack_Color];
    [self.contentView addSubview:self.name_lb];
    self.name_lb.text = @"待出库商品";
    self.name_lb.sd_layout.centerYEqualToView(self.icon_iv).leftSpaceToView(self.icon_iv,15.0f).widthIs(70.0f).autoHeightRatio(0);
    
    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:arrow_img];
    arrow_img.sd_layout.centerYEqualToView(self.name_lb).rightSpaceToView(self.contentView,10.0f).widthIs(22.0f).heightIs(22.0f);

    self.type_lb = [UILabel new];
    self.type_lb.font = [UIFont systemFontOfSize:13.0f];
    self.type_lb.textColor = [UIColor TextGray_Color];
    [self.contentView addSubview:self.type_lb];
    self.type_lb.text = [NSString stringWithFormat:@"%ld种",(long)ships.goodscount];
    self.type_lb.sd_layout.centerYEqualToView(self.name_lb).rightSpaceToView(arrow_img,5.0f).autoHeightRatio(0);
    [self.type_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    UIView *bottom_v = [UIView new];
    bottom_v.backgroundColor = [UIColor UIViewBackGroundColor];
    [self.contentView addSubview:bottom_v];
    bottom_v.sd_layout.topSpaceToView(self.name_lb,15.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    [self setupAutoHeightWithBottomView:bottom_v bottomMargin:0.0f];
}

@end
