//
//  DHBCategoryTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#import "DHBCategoryTableViewCell.h"

@implementation DHBCategoryTableViewCell
- (UILabel *)categoryName_lb{
    if(!_categoryName_lb){
        _categoryName_lb = [[UILabel alloc] init];
        [_categoryName_lb setTextColor: [UIColor TextBlack_Color]];
        [_categoryName_lb setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _categoryName_lb;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
    }
    return _arrowImageView;
}

-(UIView *)left_vi{
    if (!_left_vi) {
        _left_vi = [[UIView alloc] init];
        [_left_vi setBackgroundColor:HEX_RGB(0xfe4600)];
    }
    return _left_vi;
}

- (id)init{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.categoryName_lb];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.left_vi];
    }
    return self;
}

#pragma mark -

-(void)updateViewWithDTO:(CategoryModuleDTO*)catagory{
    UIImage *arrow = [UIImage imageNamed: @"arrow"];
    [self.arrowImageView setHidden:YES];
    if (catagory.category_count>0)
    {
        [self.arrowImageView setHidden:NO];
        [self.arrowImageView setImage: arrow];
        self.arrowImageView.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView,15.0f).widthIs(arrow.size.width).heightIs(arrow.size.height);
    }
    
    self.categoryName_lb.text = catagory.name;
    self.categoryName_lb.sd_layout.leftSpaceToView(self.contentView,15.0f).centerYEqualToView(self.contentView).rightSpaceToView(self.arrowImageView,8.0f).heightIs(35.0f);
    
    [self.left_vi setHidden:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    if (catagory.is_select)
    {
        [self.left_vi setHidden:NO];
        self.left_vi.sd_layout.topSpaceToView(self.contentView,0.0f).bottomSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,0.0f).widthIs(5.0f);
        [self setBackgroundColor:HEX_RGB(0xffffff)];
    }
}


-(void)moveArrow:(BOOL)ismove childWidht:(CGFloat)widht{
    if (ismove) {
         [self.arrowImageView setRight:self.contentView.right-widht-8.0f];
    }
    else
    {
        [self.arrowImageView setRight:self.contentView.right-8.0f];
    }
    self.categoryName_lb.sd_layout.rightSpaceToView(self.arrowImageView,5.0f);
}

@end
