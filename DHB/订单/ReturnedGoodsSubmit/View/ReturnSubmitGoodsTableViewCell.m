//
//  ReturnSubmitGoodsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ReturnSubmitGoodsTableViewCell.h"



@implementation ReturnSubmitGoodsTableViewCell

-(EGOImageViewEx *)goods_img{
    if (!_goods_img)
    {
        _goods_img = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0, self.image_vi.frame.size.width, self.image_vi.frame.size.height)];
        _goods_img.placeholderImage = [UIImage imageNamed:@"invalid2"];
        [self.image_vi addSubview:_goods_img];
    }
    return _goods_img;
}

-(TTTAttributedLabel *)options_lb{
    if (!_options_lb)
    {
        _options_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, self.options_vi.frame.size.width, self.options_vi.frame.size.height)];
        _options_lb.font = [UIFont systemFontOfSize:13];
        _options_lb.textColor = [UIColor TextGray_Color];
        [self.options_vi addSubview:_options_lb];
    }
    return _options_lb;
}

-(TTTAttributedLabel *)price_lb{
    if (!_price_lb)
    {
        _price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, self.price_vi.frame.size.width, self.price_vi.frame.size.height)];
        _price_lb.font = [UIFont systemFontOfSize:14];
        _price_lb.textColor = [UIColor TextRed_Color];
        [_price_lb setTextAlignment:NSTextAlignmentRight];
        [self.price_vi addSubview:_price_lb];
    }
    return _price_lb;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateCellData:(OrdersgoodsModuleDTO*)ordergoods{
    TT_RELEASE_SAFELY(self.ordersgoods);
    self.ordersgoods = ordergoods;
    
    self.goods_img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", ordergoods.goods.goods_picture]];
    self.goodsname_lb.text = ordergoods.goods.goods_name;
    self.goodsnum_lb.text = [NSString stringWithFormat:@"编号：%@",ordergoods.goods.goods_num];
    
    NSString *price = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),ordergoods.orders_price,ordergoods.goods.base_units];
    [self.price_lb setText:price afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"￥%@",ordergoods.orders_price] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[HEX_RGB(0xff0000) CGColor] range:redRange];
        
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *RMBFont = [UIFont systemFontOfSize:11];
        CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
        if (RMBfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
            CFRelease(RMBfont);
        }
        
        NSRange unitRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",ordergoods.goods.base_units] options:NSCaseInsensitiveSearch];
        UIFont *unitsFont = [UIFont systemFontOfSize:14];
        CTFontRef unitsfont = CTFontCreateWithName((__bridge CFStringRef)unitsFont.fontName, unitsFont.pointSize, NULL);
        if (unitsfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)unitsfont range:unitRange];
            CFRelease(unitsfont);
        }
        return mutableAttributedString;
    }];
    
    NSMutableString *options = [NSMutableString string];
    for (NSDictionary *multi in ordergoods.goods.multi_data)
    {
        [options appendString:[NSString stringWithFormat:@"%@,",[multi EncodeStringFromDicWithKey:@"options_name"]]];
    }
    options = [[NSMutableString alloc] initWithString:[options substringToIndex:([options length]>0?[options length]-1:[options length])]];
    self.options_lb.text = options;
    
}

@end
