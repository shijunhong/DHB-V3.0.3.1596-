//
//  DHBProductViewCell_2.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//  hight 114

#import "DHBGoodsViewCell_2.h"
#import "OptionModuleDTO.h"
@implementation DHBGoodsViewCell_2

-(UIView *)main_v{
    if (!_main_v)
    {
        [self setBackgroundColor: [UIColor UIViewBackGroundColor]];
        _main_v= [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,130.0f)];
        [_main_v setBackgroundColor: [UIColor whiteColor]];
        //底部还需要划线
        [_main_v initLineisBottom:YES];
        ///
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didSelectRow)];
        [tap setCancelsTouchesInView: NO];
        [_main_v setUserInteractionEnabled: YES];
        [_main_v addGestureRecognizer: tap];
    }
    return _main_v;
}



-(EGOImageViewEx *)image_vi{
    if (!_image_vi)
    {
        _image_vi= [[EGOImageViewEx alloc] initWithFrame:CGRectMake(15,15,100,100)];
        _image_vi.contentMode = UIViewContentModeScaleAspectFit;
        _image_vi.userInteractionEnabled = NO;
        _image_vi.placeholderImage = [UIImage imageNamed:@"invalid"];
        _image_vi.delegate = self;
        [self.main_v addSubview:self.image_vi];
    }
    return _image_vi;
}

- (UIImageView *)goodsTypeShadowView{
    if(!_goodsTypeShadowView){
        _goodsTypeShadowView = [[UIImageView alloc] initWithFrame: CGRectMake(self.image_vi.left - 3.5f, self.goodsTypeView.bottom - 0.8f, 3.5f, 6.0f)];
    }
    return _goodsTypeShadowView;
}

- (UIView *)goodsTypeView{
    if(!_goodsTypeView){
        _goodsTypeView = [[UIView alloc] initWithFrame: CGRectMake(15.0f - 3.5f, self.image_vi.top + 5.0f, 0.0f, GOODSTYPE_HEIGHT)];
    }
    return _goodsTypeView;
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.image_vi.right+10, 5, SCREEN_WIDTH - (self.image_vi.right + 20.0f), 60.0f)];
        _name_lb.font = [UIFont systemFontOfSize:15];
        _name_lb.lineBreakMode = NSLineBreakByTruncatingTail;
        _name_lb.numberOfLines = 2;
        [_name_lb setTextColor:[UIColor TextBlack_Color]];
        
        [self.main_v addSubview:self.name_lb];
    }
    return _name_lb;
}

-(TTTAttributedLabel *)options_lb{
    if (!_options_lb)
    {
        _options_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(self.name_lb.left, self.price_lb.top-10-10, 150, 15)];
        _options_lb.font = [UIFont systemFontOfSize:12];
        [_options_lb setTextColor:[UIColor TextGray_Color]];
    }
    return _options_lb;
}

-(TTTAttributedLabel *)price_lb{
    if (!_price_lb)
    {
        _price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(self.image_vi.right+10, self.main_v.bounds.size.height- 32, 180, 15)];
        _price_lb.font = [UIFont systemFontOfSize:15];
        _price_lb.lineBreakMode = NSLineBreakByWordWrapping;
//        _price_lb.numberOfLines = 0;
        [_price_lb setTextColor:HEX_RGB(0x757575)];
        [self.main_v addSubview:self.price_lb];
    }
    return _price_lb;
}


-(UIButton *)shoppingCar_btn{
    if (!_shoppingCar_btn)
    {
        _shoppingCar_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.main_v.frame.size.width-15-25, self.main_v.frame.size.height-15-25, 22+19, 22+19)];
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

-(UILabel *)num_lb{
    if (!_num_lb)
    {
        _num_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.main_v.frame.size.width-15-25, self.main_v.frame.size.height-15-25, 22+19, 22+19)];
        _num_lb.font = [UIFont systemFontOfSize:13];
        _num_lb.textColor = [UIColor TextGray_Color];
        [self.main_v addSubview:_num_lb];
        [_num_lb setHidden:YES];
    }
    return _num_lb;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.main_v];
    }
    return self;
}

- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto{
    self.product = dto;
    self.image_vi.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.product.goods_picture]];

    [self.main_v addSubview: self.goodsTypeView];
    [dto showGoodsTypeViewInParentView: self.goodsTypeView shadowView: self.goodsTypeShadowView];
    [self.main_v addSubview: self.goodsTypeShadowView];
    
    
    if (dto.goods_name)
    {
        NSMutableString *name = [[NSMutableString alloc] initWithString:dto.goods_name];
        if (name.length< 16)
        {
            [name appendString:@"\n"];
        }
        [self.name_lb setText:name];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:name];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [name length])];
        self.name_lb.attributedText = attributedString;
    }
    
//    OptionModuleDTO *option =  [dto.options_data safeObjectAtIndex:0];
    if([[ParameterPublic sharedManagered] client_view_goods_price])
    {
        WS(weakSelf)
        NSString *text = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),dto.whole_price,self.product.base_units];
        [self.price_lb setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"￥%@",dto.whole_price] options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor Money_Color] CGColor] range:redRange];
            
            NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
            UIFont *RMBFont = [UIFont systemFontOfSize:11];
            CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
            if (RMBfont) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
                CFRelease(RMBfont);
            }
            
            NSRange unitRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",weakSelf.product.base_units] options:NSCaseInsensitiveSearch];
            UIFont *unitsFont = [UIFont systemFontOfSize:14];
            CTFontRef unitsfont = CTFontCreateWithName((__bridge CFStringRef)unitsFont.fontName, unitsFont.pointSize, NULL);
            if (unitsfont) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)unitsfont range:unitRange];
                CFRelease(unitsfont);
            }
            
            return mutableAttributedString;
        }];
    }
    if(dto.price_count > 0){
        [self.options_lb setText:[NSString stringWithFormat:@"%lu 种规格",(unsigned long)dto.price_count]];
    }
    else{
        [self.options_lb setText: @""];
    }
    [self.main_v addSubview:self.options_lb];
    
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

#pragma mark - EGOImageViewDelegate
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error{
    [imageView setImage:[UIImage imageNamed:@"invalid"]];
}

- (void)showShoppingCarButton:(BOOL) isShow{
    [self.shoppingCar_btn setHidden: !isShow];
}

#pragma mark -
- (void)didSelectRow{
    if([_delegate respondsToSelector: @selector(DHBGoodsViewCell_didSelectRow:)]){
        [_delegate DHBGoodsViewCell_didSelectRow: self];
    }
}
@end
