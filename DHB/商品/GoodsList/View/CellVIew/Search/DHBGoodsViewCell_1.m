//
//  DHBProductViewCell_1.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsViewCell_1.h"

@implementation DHBGoodsViewCell_1

-(DHBSearchBar *)searchBar{
    if (!_searchBar)
    {
        _searchBar = [[DHBSearchBar alloc] initWithFrame:CGRectMake(self.sort_btn.right+15, self.sort_btn.top, SCREEN_WIDTH-15-90, 30)];
    }
    return _searchBar;
}

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor UIViewBackGroundColor]];
    [self.contentView addSubview:self.searchBar];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)Category:(UIButton *)sender {
    
}

@end
