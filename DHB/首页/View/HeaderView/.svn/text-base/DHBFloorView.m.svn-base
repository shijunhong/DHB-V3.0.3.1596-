//
//  DHBFloorView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFloorView.h"

@implementation DHBFloorView

-(UILabel *)title_lb{
    if (!_title_lb)
    {
        _title_lb = [[UILabel alloc] init];
        [_title_lb setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:_title_lb];
    }
    return _title_lb;
}

-(UIButton *)right_btn{
    if (!_right_btn)
    {
        _right_btn = [[UIButton alloc] init];
        _right_btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_right_btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _right_btn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.title_lb];
        [self addSubview:self.right_btn];
    }
    return self;
}


-(void)updateViewWithDTO:(HomeFloorDTO *)floorDTO callback:(void (^)())block{
    [self.title_lb setText:floorDTO.floorName];
    [self.title_lb setTextColor:floorDTO.color];
    self.title_lb.sd_layout.centerYEqualToView(self).leftSpaceToView(self,15.0f).autoHeightRatio(0);
    [self.title_lb setSingleLineAutoResizeWithMaxWidth:self.width];
    
    
    UIImage *sp_all = [UIImage imageNamed:@"sp_all"];
    NSString *sp_str = L(@" 全部商品");
    [self.right_btn setImage:sp_all forState:UIControlStateNormal];
    [self.right_btn setTitle:sp_str forState:UIControlStateNormal];
    [self.right_btn setTitleColor:floorDTO.color forState:UIControlStateNormal];
    self.right_btn.sd_layout.centerYEqualToView(self).rightSpaceToView(self,15.0f).heightIs(self.height).widthIs(sp_all.size.width+sp_str.length*15.0f);
    if (block) self.myblock = block;
}

-(void)rightAction:(UIButton*)sender{
    self.myblock();
}

@end
