//
//  DHBMemberCenterTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define TITLE_MARGIN_LEFT 15.0f
#define SUBTITLE_MARGIN_RIGHT 30.0f
#define IMAGE_MARGIN 15.0f
#import "DHBMemberCenterTableViewCell.h"

@implementation DHBMemberCenterTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setFrame: CGRectMake(0.0f, 0.0f, size.width, size.height)];
        [self addTitleLable];
        [self addSubTitleLabel];
        [self addPhotoImageView];
        [self addArrowImageView];
        [self setAccessoryType: UITableViewCellAccessoryNone];
        [self addTopLineView];
//        [self addBottomLineView];
        [self initLineisBottom: YES];
    }
    return self;
}

- (void)addTitleLable{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(TITLE_MARGIN_LEFT, 0.0f, self.frame.size.width / 2.0f, self.frame.size.height)];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
    }
    [self addSubview: _titleLabel];
}

- (void)addSubTitleLabel{
    CGFloat origin_x = _titleLabel.frame.size.width + _titleLabel.frame.origin.x;
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.frame.size.width - origin_x - SUBTITLE_MARGIN_RIGHT, self.frame.size.height)];
        [_subTitleLabel setTextAlignment: NSTextAlignmentRight];
        [_subTitleLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [_subTitleLabel setTextColor: [UIColor TextGray_Color]];
    }
    [self addSubview: _subTitleLabel];
}

- (void)addPhotoImageView{
    if(!_photoImageView){
        _photoImageView = [[UIImageView alloc] initWithFrame: CGRectMake(IMAGE_MARGIN, IMAGE_MARGIN, CELL_HEIGHT1 - 2 * IMAGE_MARGIN, CELL_HEIGHT1 - 2 * IMAGE_MARGIN)];
        [_photoImageView setImage: [UIImage imageNamed: @"user2"]];
        ///默认隐藏
        [_photoImageView setHidden: YES];
    }
    [self addSubview: _photoImageView];
}

- (void)addArrowImageView{
    if(!_arrowimageView){
        CGFloat origin_x = self.size.width - SUBTITLE_MARGIN_RIGHT;
        _arrowimageView = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, 0.0f, SUBTITLE_MARGIN_RIGHT / 1.3f, self.size.height)];
        [_arrowimageView setContentMode: UIViewContentModeScaleAspectFit];
        [_arrowimageView setImage: [UIImage imageNamed: @"arrow"]];
    }
    [self addSubview: _arrowimageView];
}

- (void)addTopLineView{
    if(!_topLineView){
        _topLineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 0.5f)];
        [_topLineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    }
    [self addSubview: _topLineView];
}
@end
