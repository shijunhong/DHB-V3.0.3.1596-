//
//  DHBPaymentsOptionTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 50.0f
#define MARGIN_LEFT 10.0f
#define IMAGEVIEW_HEIGHT 20.0f
#import "DHBPaymentsOptionTableViewCell.h"

@implementation DHBPaymentsOptionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSize: size];
        [self addValueLabel];
        [self addSelectImageView];
        ///
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(15.0f, CELL_HEIGHT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [lineView setBackgroundColor: [UIColor CellLine_Color]];
        [self addSubview: lineView];
    }
    return self;
}

- (void)addValueLabel{
    if(!_valueLabel){
        _valueLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, self.size.width, self.size.height)];
        [_valueLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_valueLabel setTextColor: [UIColor TextGray_Color]];
    }
    [self addSubview: _valueLabel];
}

- (void)addSelectImageView{
    if(!_selectImageView){
        _selectImageView = [[UIImageView alloc] initWithFrame: CGRectMake(self.size.width - 2 * IMAGEVIEW_HEIGHT, (self.size.height - IMAGEVIEW_HEIGHT) / 2.0f, IMAGEVIEW_HEIGHT, IMAGEVIEW_HEIGHT)];
        [_selectImageView setContentMode: UIViewContentModeScaleAspectFit];
        [_selectImageView setImage: [UIImage imageNamed: @"uncheck"]];
    }
    [self addSubview: _selectImageView];
}

#pragma mark - 
- (void)updateViewWithPayTypeDTO:(DHBPayTypeModuleDTO *)dto{
    [_valueLabel setText: [dto name]];
    if([dto is_select]){
        [_selectImageView setImage: [UIImage imageNamed: @"check.png"]];
        [_valueLabel setTextColor: [UIColor TextRed_Color]];
    }
    else{
        [_selectImageView setImage: [UIImage imageNamed: @"uncheck.png"]];
        [_valueLabel setTextColor: [UIColor grayColor]];
    }
}

- (void)updateViewWithDepositeTypeDTO:(DHBDepositTypeModuleDTO *)dto{
    [_valueLabel setText: [dto name]];
    if([dto is_select]){
        [_selectImageView setImage: [UIImage imageNamed: @"check.png"]];
        [_valueLabel setTextColor: [UIColor TextRed_Color]];
    }
    else{
        [_selectImageView setImage: [UIImage imageNamed: @"uncheck.png"]];
        [_valueLabel setTextColor: [UIColor grayColor]];
    }
}
@end
