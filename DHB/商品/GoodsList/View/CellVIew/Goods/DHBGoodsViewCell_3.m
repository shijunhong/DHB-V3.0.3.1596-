//
//  DHBGoodsViewCell_3.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#import "DHBGoodsViewCell_3.h"
#import "OptionModuleDTO.h"

@implementation DHBGoodsViewCell_3

-(UIView *)main_v{
    if (!_main_v)
    {
        _main_v= [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,130.0f)];
        [_main_v setBackgroundColor:[UIColor whiteColor]];
        //底部还需要划线
        [_main_v initLineisBottom:YES];
    }
    return _main_v;
}

- (UIView *)goodsTypeView{
    if(!_goodsTypeView){
        _goodsTypeView = [[UIView alloc] init];
    }
    return _goodsTypeView;
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 15.0f, self.contentView.width-30.0f, 50.0f)];
        _name_lb.font = [UIFont systemFontOfSize:15];
        _name_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _name_lb.numberOfLines = 2;
        [_name_lb setTextColor:[UIColor TextBlack_Color]];
        [self.main_v addSubview:self.name_lb];
    }
    [_name_lb addSubview: self.goodsTypeView];
    return _name_lb;
}


-(UILabel *)sku_lb{
    if (!_sku_lb)
    {
        CGFloat origin_y = self.price_lb.frame.origin.y - 23.0f;
        _sku_lb = [[UILabel alloc] initWithFrame:CGRectMake(15, origin_y, SCREEN_WIDTH - 30.0f, 20.0f)];
        _sku_lb.font = [UIFont systemFontOfSize:13];
        [_sku_lb setTextColor:[UIColor TextGray_Color]];
        [self.main_v addSubview: self.sku_lb];
    }
    return _sku_lb;
}


-(TTTAttributedLabel *)price_lb{
    if (!_price_lb)
    {
        _price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, self.main_v.bounds.size.height - 32.0f, 180, 15)];
        _price_lb.font = [UIFont systemFontOfSize:15];
        _price_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _price_lb.numberOfLines = 0;
        [_price_lb setTextColor:HEX_RGB(0x757575)];
        [self.main_v addSubview:self.price_lb];
    }
    return _price_lb;
}




-(UIButton *)shoppingCar_btn{
    if (!_shoppingCar_btn)
    {
        _shoppingCar_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.main_v.frame.size.width-15-25, self.main_v.frame.size.height-15-25, 22+19, 22+19)];
        [_shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingcart_normal"] forState:UIControlStateNormal];
        [_shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingcart_focused"] forState:UIControlStateSelected];
        [_shoppingCar_btn addTarget:self action:@selector(shoppingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoppingCar_btn;
}


-(UIImageView *)noAvailable_img{
    if (!_noAvailable_img)
    {
        _noAvailable_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 25)];
        [_noAvailable_img setImage:[UIImage imageNamed:@"lack"]];
    }
    return _noAvailable_img;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        [self.contentView addSubview:self.main_v];
    }
    return self;
}

- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto{
    self.product = dto;
    
    [dto showGoodsTypeViewInParentView:self.goodsTypeView shadowView: nil];
    [self.name_lb setFrame:CGRectMake(15.0f, 15.0f, self.contentView.width-30.0f, 50.0f)];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",dto.goods_name]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing: 5.0f];
    [paragraphStyle setFirstLineHeadIndent:self.goodsTypeView.width];///首行缩进
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [dto.goods_name length])];
    self.name_lb.attributedText = attri;
    [self.name_lb sizeToFit];
    [self.name_lb setFrame:CGRectMake(15.0f, 15.0f, self.contentView.width-30.0f, self.name_lb.height)];
//    self.name_lb.sd_layout.topSpaceToView(self.main_v,15.0f).leftSpaceToView(self.main_v,15.0f).rightSpaceToView(self.main_v,15.0f).heightIs(self.name_lb.height);
    
    ///商品价格
    if([[ParameterPublic sharedManagered] client_view_goods_price])
    {
        NSString *text = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),dto.whole_price,self.product.base_units];
        WS(weakSelf);
        [self.price_lb setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"￥%@",dto.whole_price] options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[HEX_RGB(0xff0000) CGColor] range:redRange];
            
            NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
            UIFont *RMBFont = [UIFont systemFontOfSize:11.0f];
            CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
            if (RMBfont) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
                CFRelease(RMBfont);
            }
            
            NSRange unitRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",weakSelf.product.base_units] options:NSCaseInsensitiveSearch];
            UIFont *unitsFont = [UIFont systemFontOfSize:14.0f];
            CTFontRef unitsfont = CTFontCreateWithName((__bridge CFStringRef)unitsFont.fontName, unitsFont.pointSize, NULL);
            if (unitsfont) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)unitsfont range:unitRange];
                CFRelease(unitsfont);
            }
            
            return mutableAttributedString;
        }];
    }
    ///规格
    if(dto.price_count > 0){
        [self.sku_lb setText:[NSString stringWithFormat:@"%lu 种规格",(unsigned long)dto.price_count]];
    }
    else{
        [self.sku_lb setText: @""];
    }
    
    [self.shoppingCar_btn removeFromSuperview];
    [self.noAvailable_img removeFromSuperview];
    if (dto.is_out_of_stock)
    {
        //不能负库存订货 ，缺货
        [self.main_v addSubview:self.noAvailable_img];
        self.noAvailable_img.sd_layout.centerYEqualToView(self.price_lb).rightSpaceToView(self.main_v,15.0f).widthIs(55.0f).heightIs(25.0f);
    }
    else
    {
        if (self.product.in_cart)
        {
            [self.shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingCartConfirm_normal"] forState:UIControlStateNormal];
        }
        else
        {
            [self.shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingcart_normal"] forState:UIControlStateNormal];
        }
        [self.main_v addSubview:self.shoppingCar_btn];
    }
}


//点击购物车
- (void)shoppingCarAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(DHBGoodsViewCell:didTouchShoppingCar:GoodsModule:)]) {
        [self.delegate DHBGoodsViewCell:self didTouchShoppingCar:sender GoodsModule:self.product];
    }
}
@end
