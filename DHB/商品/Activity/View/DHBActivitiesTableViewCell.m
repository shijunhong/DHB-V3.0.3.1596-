//
//  DHBActivitiesTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBActivitiesTableViewCell.h"

@implementation DHBActivitiesTableViewCell

-(TTTAttributedLabel *)time_lb{
    if (!_time_lb)
    {
        _time_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, 239, 250, 15)];
        _time_lb .font = [UIFont systemFontOfSize:14];
        _time_lb .lineBreakMode = NSLineBreakByWordWrapping;
        _time_lb .numberOfLines = 0;
        [_time_lb  setTextColor:HEX_RGB(0x333333)];
    }
    return _time_lb;
}

-(TTTAttributedLabel *)content_lb{
    if (!_content_lb)
    {
        _content_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, self.time_lb.frame.origin.y+22, self.bounds.size.width-15, 30)];
        _content_lb.font = [UIFont systemFontOfSize:14];
        _content_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _content_lb.numberOfLines = 0;
        [_content_lb setTextColor:HEX_RGB(0x333333)];
    }
    return _content_lb;
}

-(UIButton *)detail_btn{
    if (!_detail_btn)
    {
        _detail_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, self.state_v.bounds.size.width, self.state_v.bounds.size.height)];
        _detail_btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_detail_btn setTitle:@"查看详细" forState:UIControlStateNormal];
        [_detail_btn setTitleColor:HEX_RGB(0xfe4600) forState:UIControlStateNormal];
        [_detail_btn setHidden:YES];
    }
    return _detail_btn;
}

-(UIImageView *)detail_vi{
    if (!_detail_vi)
    {
        _detail_vi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_xuanze_normal"]];
        _detail_vi.size = CGSizeMake(22, 22);
        _detail_vi.left = self.detail_btn.right-13;
        _detail_vi.centerY = self.detail_btn.centerY;
        [_detail_vi setHidden:YES];
    }
    return _detail_vi;
}

-(UIImageView *)state_vi{
    if (!_state_vi)
    {
        _state_vi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.state_v.bounds.size.width, self.state_v.bounds.size.height)];
        [_state_vi setImage:[UIImage imageNamed:@"pic_yijieshu"]];
        [_state_vi setHidden:YES];
    }
    return _state_vi;
}



- (void)awakeFromNib {
    // Initialization code
    [self.contentView addSubview:self.time_lb ];
    [self.contentView addSubview:self.content_lb];
    [self.state_v addSubview:self.detail_btn];
    [self.state_v addSubview:self.detail_vi];
    [self.state_v addSubview:self.state_vi];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
