//
//  DHBLogisticsCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/12.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLogisticsCell.h"

@implementation DHBLogisticsCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)updateDataWithDto:(NSDictionary*)dto{
    [self.contentView removeAllSubviews];
    
    self.circle_vi = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 14, 14)];
    self.circle_vi.layer.cornerRadius =CGRectGetHeight([self.circle_vi bounds])/2;
    self.circle_vi.layer.borderWidth = 1;
    self.circle_vi.layer.borderColor = HEX_RGB(0xf8f8f8).CGColor;
    [self.circle_vi setBackgroundColor:HEX_RGB(0xd7d7d7)];
    [self.contentView addSubview:self.circle_vi];
    self.circle_vi.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,15.0f).widthIs(14.0f).heightIs(14.0f);
    
    self.content_lb = [UILabel new];
    self.content_lb.font = [UIFont systemFontOfSize:14.0f];
    self.content_lb.textColor = [UIColor TextGray_Color];
    self.content_lb.text = [dto EncodeStringFromDicWithKey:@"context"];
    [self.contentView addSubview:self.content_lb];
    self.content_lb.sd_layout.topEqualToView(self.circle_vi).leftSpaceToView(self.circle_vi,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    
    self.time_lb = [UILabel new];
    self.time_lb.font = [UIFont systemFontOfSize:13.0f];
    self.time_lb.textColor = [UIColor TextGray_Color];
    self.time_lb.text = [dto EncodeStringFromDicWithKey:@"time"];
    [self.contentView addSubview:self.time_lb];
    self.time_lb.sd_layout.topSpaceToView(self.content_lb,8.0f).leftEqualToView(self.content_lb).rightEqualToView(self.content_lb).autoHeightRatio(0);
    
    if ([[dto EncodeStringFromDicWithKey:@"is_red"] boolValue])
    {
        self.circle_vi.layer.borderColor = HEX_RGB(0xffc197).CGColor;
        self.circle_vi.backgroundColor = HEX_RGB(0xfe4600);
        self.content_lb.textColor = [UIColor TextRed_Color];
        self.time_lb.textColor = [UIColor TextRed_Color];
    }
    
    if ([[dto EncodeStringFromDicWithKey:@"is_line"] boolValue])
    {
        self.line_vi = [[UIView alloc] initWithFrame:CGRectMake(21, 25, 1, 90)];
        [self.line_vi setBackgroundColor:HEX_RGB(0xd7d7d7)];
        [self.contentView addSubview:self.line_vi];
        self.line_vi.sd_layout.topSpaceToView(self.circle_vi,0.0f).centerXEqualToView(self.circle_vi).widthIs(1.0f).heightIs(90.0f);
        [self setupAutoHeightWithBottomView:self.line_vi bottomMargin:0.0f];
    }
    else
    {
        [self setupAutoHeightWithBottomView:self.time_lb bottomMargin:90.0f];
    }
}

@end
