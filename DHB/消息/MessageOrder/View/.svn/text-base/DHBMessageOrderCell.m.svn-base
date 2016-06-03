//
//  DHBMessageOrderCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageOrderCell.h"

@implementation DHBMessageOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.name_lb = [UILabel new];
    self.name_lb.textColor = [UIColor TextBlack_Color];
    self.name_lb.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:self.name_lb];
    self.name_lb.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .widthIs(105)
    .heightIs(20);
    
    self.time_lb = [UILabel new];
    self.time_lb.textColor = [UIColor TextGray_Color];
    self.time_lb.font = [UIFont systemFontOfSize:13.0f];
    self.time_lb.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.time_lb];
    self.time_lb.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topEqualToView(self.name_lb)
    .widthIs(200)
    .heightIs(20);
    
    self.content_lb = [UILabel new];
    self.content_lb.textColor = [UIColor TextGray_Color];
    self.content_lb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.content_lb];
    self.content_lb.sd_layout
    .leftEqualToView(self.name_lb)
    .rightEqualToView(self.time_lb)
    .topSpaceToView(self.name_lb, 15)
    .autoHeightRatio(0);
//
    //底部还需要划线
    UIView *bottomView  = [UIView new];
    [bottomView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomView];
    bottomView.sd_layout
    .topSpaceToView(self.content_lb,14.5f)
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15)
    .heightIs(DEFAULT_LINE_HEIGHT);
    
    [self setupAutoHeightWithBottomView:self.content_lb bottomMargin:15];
}

@end
