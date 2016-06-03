//
//  DHBOperatingLogTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#import "DHBOperatingLogTableViewCell.h"
@implementation DHBOperatingLogTableViewCell

- (UILabel *)time_lb{
    if(!_time_lb){
        _time_lb = [[UILabel alloc] init];
        [_time_lb setFont: [UIFont systemFontOfSize: 14.0f]];
        [_time_lb setTextColor: [UIColor TextGray_Color]];
    }
    return _time_lb;
}

- (UILabel *)type_lb{
    if(!_type_lb){
        _type_lb = [[UILabel alloc] init];
        [_type_lb setFont: [UIFont systemFontOfSize: 15.0f]];
        [_type_lb setTextColor: [UIColor TextBlack_Color]];
    }
    return _type_lb;
}

- (UILabel *)content_lb{
    if(!_content_lb){
        _content_lb = [[UILabel alloc] init];
        [_content_lb setFont: [UIFont systemFontOfSize: 15.0f]];
        [_content_lb setTextColor: [UIColor TextBlack_Color]];
    }
    return _content_lb;
}

- (UIView *)bottomLineView{
    if(!_bottomLineView){
        _bottomLineView = [[UIView alloc] init];
        [_bottomLineView setBackgroundColor: [UIColor CellLine_Color]];
    }
    return _bottomLineView;
}

- (id)init{
    self = [super init];
    if(self){}
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){}
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
    }
    return self;
}

- (void)updateView:(LogordersModuleDTO*)log{
    ////时间Label
    [self.contentView addSubview: self.time_lb];
    self.time_lb.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, MARGIN_LEFT).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs(20.0f);
    ///类型
    [self.contentView addSubview: self.type_lb];
    self.type_lb.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.time_lb, MARGIN_LEFT).rightSpaceToView(self.contentView, MARGIN_LEFT).autoHeightRatio(0);
    
    if([[log remark] length] > 0){
        ///内容
        [self.contentView addSubview: self.content_lb];
        self.content_lb.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.type_lb, 10.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).autoHeightRatio(0);
        ///分割线
        [self.contentView addSubview: self.bottomLineView];
        self.bottomLineView.sd_layout.topSpaceToView(self.content_lb, MARGIN_LEFT).leftSpaceToView(self.contentView, MARGIN_LEFT).rightSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    }
    else{
        ///分割线
        [self.contentView addSubview: self.bottomLineView];
        self.bottomLineView.sd_layout.topSpaceToView(self.type_lb, MARGIN_LEFT).leftSpaceToView(self.contentView, MARGIN_LEFT).rightSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    }
    //
    [self setupAutoHeightWithBottomView: self.bottomLineView bottomMargin: 0.0f];
    
    /////填充内容
    [self.time_lb setText:[NSString stringWithFormat:@"%@",log.create_date]];
    [self.type_lb setText:log.operation];
    self.content_lb.text = log.remark;
}
@end
