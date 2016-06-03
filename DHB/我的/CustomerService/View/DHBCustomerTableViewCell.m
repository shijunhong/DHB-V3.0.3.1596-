//
//  DHBCustomerTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/5/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0f
#import "DHBCustomerTableViewCell.h"

@implementation DHBCustomerTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSize: size];
        [self addIconImageView];
        [self addNameLabel];
        [self addContactLabel];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - 添加icon图片
- (void)addIconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, (2.5 * MARGIN_LEFT) / 2.0f, self.size.height - 2 * MARGIN_LEFT, self.size.height - 2.5 * MARGIN_LEFT)];
        [_iconImageView setContentMode: UIViewContentModeScaleAspectFit];
    }
    [self addSubview: _iconImageView];
}

#pragma mark - 添加客服姓名
- (void)addNameLabel{
    if(!_nameLabel){
        CGFloat origin_x = _iconImageView.frame.size.width + _iconImageView.frame.origin.x + MARGIN_LEFT;
        _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.size.width / 3.0f, self.size.height)];
        [_nameLabel setTextColor:[UIColor TextBlack_Color]];
        [_nameLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    [self addSubview: _nameLabel];
}

#pragma mark - 添加客服联系方式
- (void)addContactLabel{
    if(!_contactLabel){
        CGFloat origin_x = _nameLabel.frame.size.width + _nameLabel.frame.origin.x + MARGIN_LEFT;
        _contactLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.size.width - origin_x - MARGIN_LEFT, self.size.height)];
        [_contactLabel setTextAlignment: NSTextAlignmentRight];
        [_contactLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    [self addSubview: _contactLabel];
}

#pragma mark -
- (void)updateviewWithDTO:(DHBCustomerModuleDTO *) DTO{
    [_nameLabel setText: [DTO name]];
    [_contactLabel setText: [DTO contactMethod]];
    if([[DTO type] isEqualToString: @"个人QQ"] || [[DTO type] isEqualToString:@"企业QQ"]){
        [_iconImageView setImage: [UIImage imageNamed: @"qq_gray"]];
        [_contactLabel setTextColor: [UIColor TextRed_Color]];
    }
    else if([[DTO type] isEqualToString: @"旺旺"]){
        [_iconImageView setImage: [UIImage imageNamed: @"ww_gray"]];
        [_contactLabel setTextColor: [UIColor TextGray_Color]];
    }
    else if([[DTO type] isEqualToString: @"微信"]){
        [_iconImageView setImage: [UIImage imageNamed: @"wechat_gray"]];
        [_contactLabel setTextColor: [UIColor TextGray_Color]];
    }
    else if([[DTO type] isEqualToString: @"电话"]){
        [_iconImageView setImage: [UIImage imageNamed: @"dh_gray"]];
        [_contactLabel setTextColor: [UIColor TextRed_Color]];
    }
}
@end
