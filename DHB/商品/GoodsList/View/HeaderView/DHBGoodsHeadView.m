//
//  DHBGoodsHeadView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/19.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsHeadView.h"

@implementation DHBGoodsHeadView

-(UIButton *)category_btn{
    if (!_category_lb)
    {
        _category_btn = [[UIButton alloc] init];
        [_category_btn addTarget:self action:@selector(categoryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _category_btn;
}

-(UILabel *)category_lb{
    if (!_category_lb)
    {
        _category_lb = [[UILabel alloc] init];
        _category_lb.font = [UIFont systemFontOfSize:15.0f];
        _category_lb.textColor = [UIColor TextGray_Color];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(categoryAction)];
        [_category_lb setUserInteractionEnabled: YES];
        [_category_lb addGestureRecognizer: tap];
    }
    return _category_lb;
}

-(UIButton *)sifting_btn{
    if (!_sifting_btn)
    {
        _sifting_btn = [[UIButton alloc] init];
        _sifting_btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_sifting_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_sifting_btn addTarget:self action:@selector(siftingAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sifting_btn;
}

-(UIButton *)exchangePic_btn{
    if (!_exchangePic_btn)
    {
        _exchangePic_btn = [[UIButton alloc] init];
        [_exchangePic_btn addTarget:self action:@selector(exchangePicAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangePic_btn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.category_btn];
        [self addSubview:self.category_lb];
        [self addSubview:self.sifting_btn];
        [self addSubview:self.exchangePic_btn];
        [self initLineisBottom:YES];
    }
    return self;
}


-(void)updateViewWithDTO:(GoodsListService*)service{
    UIImage *hp_category= [UIImage imageNamed:@"hp_category"];
    [self.category_btn setImage:hp_category forState:UIControlStateNormal];
    self.category_btn.sd_layout.centerYEqualToView(self).leftSpaceToView(self,15.0f).widthIs(10.0f+hp_category.size.width).heightIs(self.height);
    
    UIImage *exchangePic_noml;
    UIImage *exchangePic_sel;
    if (![[ParameterPublic sharedManagered] noPic])
    {
        exchangePic_noml = [UIImage imageNamed:@"list_normal"];
        exchangePic_sel = [UIImage imageNamed:@"img_normal"];
    }
    else
    {
        exchangePic_noml = [UIImage imageNamed:@"img_normal"];
        exchangePic_sel = [UIImage imageNamed:@"list_normal"];
    }
    [self.exchangePic_btn setImage:exchangePic_noml forState:UIControlStateNormal];
    [self.exchangePic_btn setImage:exchangePic_sel forState:UIControlStateSelected];
    self.exchangePic_btn.sd_layout.centerYEqualToView(self).rightSpaceToView(self,0.0f).widthIs(30.0f+exchangePic_noml.size.width).heightIs(self.height);
    
    UIImage *screening_normal = [UIImage imageNamed:@"screening_normal"];
    [self.sifting_btn setImage:screening_normal forState:UIControlStateNormal];
    [self.sifting_btn setTitle:L(@" 筛选") forState:UIControlStateNormal];
    self.sifting_btn.sd_layout.centerYEqualToView(self).rightSpaceToView(self.exchangePic_btn,0.0f).widthIs(30.0f+screening_normal.size.width+15.0f*3).heightIs(self.height);
    
    self.category_lb.text = service.category_id == 0?@"分类":[[ParameterPublic sharedManagered] category].category_name;
    self.category_lb.sd_layout.centerYEqualToView(self).leftSpaceToView(self.category_btn,0.0f).rightSpaceToView(self.sifting_btn,0.0f).heightIs(self.height);
}


- (void)categoryAction{
    [self.delegate DHBGoodsViewCell_didSelectCategory];
}
- (void)siftingAction{
    [self.delegate DHBGoodsViewCell_didSelectSifting];
}

- (void)exchangePicAction{
    [self.delegate DHBGoodsViewCell_didSelectExchangePic];
}
@end
