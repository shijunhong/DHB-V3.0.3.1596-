//
//  DHBShowInvoiceCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShowInvoiceCell.h"

@implementation DHBShowInvoiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [[UILabel alloc] init];
        [_name_lb setFont: [UIFont systemFontOfSize: 15.0f]];
        [_name_lb setTextColor: [UIColor TextBlack_Color]];
    }
    return _name_lb;
}

-(UILabel *)value_lb{
    if (!_value_lb)
    {
        _value_lb = [[UILabel alloc] init];
        [_value_lb setTextAlignment:NSTextAlignmentRight];
        [_value_lb setFont: [UIFont systemFontOfSize: 13.0f]];
        [_value_lb setTextColor: [UIColor TextGray_Color]];
    }
    return _value_lb;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.name_lb];
        [self.contentView addSubview:self.value_lb];
    }
    return self;
}

- (void)updateView:(NSDictionary*)dto{
    self.name_lb.text = [dto EncodeStringFromDicWithKey:@"name"];
    self.name_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    [self.name_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    self.value_lb.text = [dto EncodeStringFromDicWithKey:@"value"];
    self.value_lb.sd_layout.topSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).leftSpaceToView(self.name_lb,15.0f).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.value_lb bottomMargin:15.0f];
}

@end
