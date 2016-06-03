//
//  DHBSearchAddressTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSearchAddressTableViewCell.h"

@implementation DHBSearchAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.listTitleName = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, [UIScreen mainScreen].bounds.size.width-15*2-15*2, 20)];
        self.listTitleName.font = [UIFont systemFontOfSize:15];
        self.listTitleName.textColor = [UIColor TextBlack_Color];
        [self addSubview:self.listTitleName];
        
        self.listSubTitleName = [[UILabel alloc]initWithFrame:CGRectMake(15, 26, [UIScreen mainScreen].bounds.size.width-15*2-15*2, 15)];
        self.listSubTitleName.font = [UIFont systemFontOfSize:13];
        self.listSubTitleName.textColor = [UIColor TextGray_Color];
        [self addSubview:self.listSubTitleName];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
