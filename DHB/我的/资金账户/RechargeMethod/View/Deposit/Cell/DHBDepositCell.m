//
//  DHBDepositCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDepositCell.h"

@implementation DHBDepositCell

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [UILabel new];
        _name_lb.textColor = [UIColor TextBlack_Color];
        _name_lb.font = [UIFont systemFontOfSize:14.0f];
    }
    return _name_lb;
}


-(TTTAttributedLabel *)value_lb{
    if (!_value_lb)
    {
        _value_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _value_lb.textColor = [UIColor TextBlack_Color];
        _value_lb.textAlignment = NSTextAlignmentRight;
        _value_lb.font = [UIFont systemFontOfSize:14.0f];
    }
    return _value_lb;
}

-(UIView *)bottom_l{
    if (!_bottom_l)
    {
        _bottom_l = [UIView new];
        _bottom_l.backgroundColor = [UIColor CellLine_Color];
    }
    return _bottom_l;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.name_lb];
        [self.contentView addSubview:self.value_lb];
        [self.contentView addSubview:self.bottom_l];
    }
    return self;
}

- (void)updateViewWithData:(NSDictionary *)dto{
    self.name_lb.text = [dto EncodeStringFromDicWithKey:@"name"];
    self.name_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs([self.name_lb.text length]*14.0f).autoHeightRatio(0);
    
    self.value_lb.text =[dto EncodeStringFromDicWithKey:@"value"];
    self.value_lb.sd_layout.topEqualToView(self.name_lb).leftSpaceToView(self.name_lb,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    
    self.bottom_l.sd_layout.topSpaceToView(self.name_lb,15.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    [self setupAutoHeightWithBottomView:self.bottom_l bottomMargin:0.0f];
}

@end
