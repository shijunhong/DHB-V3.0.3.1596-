//
//  DHBMessageContentCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageContentCell.h"


@interface DHBMessageContentCell ()
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *topView;

@end

@implementation DHBMessageContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)head_img{
    if (!_head_img)
    {
        _head_img= [[UIImageView alloc] init];
        _head_img.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_head_img];
    }
    return _head_img;
}


-(UILabel *)time_lb{
    if (!_time_lb)
    {
        _time_lb = [[UILabel alloc] init];
        _time_lb.font = [UIFont systemFontOfSize:13];
        _time_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_time_lb];
    }
    return _time_lb;
}

-(TTTAttributedLabel *)content_lb{
    if (!_content_lb)
    {
        _content_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _content_lb.font = [UIFont systemFontOfSize:15.0f];
        _content_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _content_lb.numberOfLines = 0;
        _content_lb.textColor = [UIColor TextBlack_Color];
        [self.contentView addSubview:_content_lb];
    }
    return _content_lb;
}


-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:HEX_RGB(0xf0f0f0)];
        UIView *bottomTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomTopView setBackgroundColor:[UIColor CellLine_Color]];
        [_bottomView addSubview:bottomTopView];
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

-(UIView *)topView{
    if (!_topView)
    {
        _topView = [[UIImageView alloc] init];
        [_topView setBackgroundColor:[UIColor CellLine_Color]];
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)updateViewWithMessageDTO:(NSDictionary *)msg{
    if ([[msg objectForKey:@"is_manager"] isEqualToString:@"T"])
    {
        [self.head_img setImage:[UIImage imageNamed:@"admin"]];
        self.head_img.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(30.0f).heightIs(30.0f);
        
        [self.time_lb setTextAlignment: NSTextAlignmentLeft];
        [self.content_lb setTextAlignment:NSTextAlignmentLeft];
        self.time_lb.sd_layout.topEqualToView(self.head_img).leftSpaceToView(self.head_img,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);

        [self.content_lb setTextAlignment:NSTextAlignmentLeft];
        self.content_lb.sd_layout.topSpaceToView(self.time_lb,5.0f).leftEqualToView(self.time_lb).rightEqualToView(self.time_lb).autoHeightRatio(0);
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [self.head_img setImage:[UIImage imageNamed:@"user"]];
        self.head_img.sd_layout.topSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).widthIs(30.0f).heightIs(30.0f);
        
        [self.time_lb setTextAlignment:NSTextAlignmentRight];
        self.time_lb.sd_layout.topEqualToView(self.head_img).rightSpaceToView(self.head_img,15.0f).leftSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
        
        [self.content_lb setTextAlignment:NSTextAlignmentRight];
        [self.contentView setBackgroundColor:HEX_RGB(0xf7fcff)];
        self.content_lb.sd_layout.topSpaceToView(self.time_lb,5.0f).rightEqualToView(self.time_lb).leftEqualToView(self.time_lb).autoHeightRatio(0);
    }
    self.time_lb.text = [msg objectForKey:@"create_date"];
    [self.content_lb setText:[msg objectForKey:@"content"]];
    
    //底部还需要划线
    self.bottomView.sd_layout.topSpaceToView(self.content_lb,15.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(8.0f);
    
    //顶部还需要划线
    self.topView.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(0.5);
    
    [self setupAutoHeightWithBottomView:self.bottomView bottomMargin:0.0f];
}


@end
