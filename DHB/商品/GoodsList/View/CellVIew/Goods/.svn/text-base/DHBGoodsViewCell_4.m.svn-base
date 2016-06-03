//
//  DHBGoodsViewCell_4.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/21.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsViewCell_4.h"
#import "DHBLabel.h"

@implementation DHBGoodsViewCell_4

-(UIView *)main_v{
    if (!_main_v)
    {
        _main_v= [[UIView alloc] init];
        [_main_v setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
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
        _goodsTypeView = [[UIView alloc] initWithFrame: CGRectMake(15.0f - 3.5f, self.image_vi.top + 2.5f, 0.0f, GOODSTYPE_HEIGHT)];
    }
    return _goodsTypeView;
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.image_vi.right+10, 14, SCREEN_WIDTH - (self.image_vi.right + 20.0f), 38.0f)];
        _name_lb.font = [UIFont systemFontOfSize:15.0f];
        _name_lb.lineBreakMode = NSLineBreakByTruncatingTail;
        _name_lb.numberOfLines = 2;
        [_name_lb setTextColor:[UIColor TextBlack_Color]];
    }
    return _name_lb;
}

-(DHBLabel *)price_lb{
    if (!_price_lb)
    {
        _price_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _price_lb.font = [UIFont systemFontOfSize:15.0f];
        _price_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _price_lb.numberOfLines = 0;
        [_price_lb setTextColor:HEX_RGB(0x757575)];
    }
    return _price_lb;
}


-(GoodsNumberView *)goodsNumber{
    if (!_goodsNumber)
    {
        _goodsNumber = [[GoodsNumberView alloc] init];
        [_goodsNumber setDelegate: self];
        
    }
    return _goodsNumber;
}


-(UIView *)units_vi{
    if (!_units_vi)
    {
        _units_vi = [[UIView alloc] init];
        [_units_vi setBackgroundColor:[UIColor clearColor]];
    }
    return _units_vi;
}


-(UIButton *)shoppingCar_btn{
    if (!_shoppingCar_btn)
    {
        _shoppingCar_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.main_v.frame.size.width-15-22, self.main_v.frame.size.height-30-22, 22+15, 22+15)];
        [_shoppingCar_btn addTarget:self action:@selector(shoppingCarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shoppingCar_btn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 15.0f, 15.0f)];
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
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.image_vi];
        [self.contentView addSubview:self.name_lb];
        [self.contentView addSubview:self.main_v];
        [self.main_v addSubview:self.price_lb];
        [self.main_v addSubview:self.goodsNumber];
        [self.main_v addSubview:self.units_vi];
        [self.main_v addSubview:self.shoppingCar_btn];
        [self.main_v addSubview:self.noAvailable_img];
    }
    return self;
}

- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto{
    self.product = dto;
    OptionModuleDTO *option = [dto getSelectOptions];
    
    self.image_vi.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.product.goods_picture]];

    [self.contentView addSubview: self.goodsTypeView];
    [dto showGoodsTypeViewInParentView: self.goodsTypeView shadowView: self.goodsTypeShadowView];
    [self.contentView addSubview: self.goodsTypeShadowView];
    
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
        [paragraphStyle setLineSpacing:1];//调整行间距
        [self.contentView addSubview: self.goodsTypeShadowView];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [name length])];
        self.name_lb.attributedText = attributedString;

    }
    
    self.main_v.sd_layout.topSpaceToView(self.name_lb,6.0f).leftSpaceToView(self.image_vi,10.0f).rightSpaceToView(self.contentView,0.0f).bottomSpaceToView(self.contentView,0.0f);
    
    [self.price_lb setHidden:YES];
    if([[ParameterPublic sharedManagered] client_view_goods_price])
    {
        [self.price_lb setHidden:NO];
        NSString *text = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),option.whole_price,self.product.base_units];
        [self.price_lb setPriceText:text price:option.whole_price $Fount:[UIFont systemFontOfSize:11.0f]];
        self.price_lb.sd_layout.leftSpaceToView(self.main_v,0.0f).topSpaceToView(self.main_v,0.0f).heightIs(20.0f);
        [self.price_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    }
    
    [self.noAvailable_img setHidden:YES];
    [self.shoppingCar_btn setHidden:YES];
    [self.goodsNumber setHidden:YES];
    [self.units_vi removeAllSubviews];
    if (dto.is_out_of_stock)
    {
        //不能负库存订货 ，缺货
        [self.noAvailable_img setHidden:NO];
        self.noAvailable_img.sd_layout.bottomSpaceToView(self.main_v,15.0f).rightSpaceToView(self.main_v,15.0f).widthIs(55.0f).heightIs(25.0f);
    }
    else
    {
        [self.shoppingCar_btn setHidden:NO];
        [self.goodsNumber setHidden:NO];
        if (self.product.in_cart)
        {
            [self.shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingCartConfirm_normal"] forState:UIControlStateNormal];
        }
        else
        {
            [self.shoppingCar_btn setImage:[UIImage imageNamed:@"shoppingcart_normal"] forState:UIControlStateNormal];
        }
        self.shoppingCar_btn.sd_layout.bottomSpaceToView(self.main_v,0.0f).rightSpaceToView(self.main_v,0.0f).widthIs(22.0f+15.0f).heightIs(22.0f+15.0f);
        
        self.goodsNumber.goods = self.product;
        self.goodsNumber.numberTF.text = [NSString stringWithFormat:@"%@",option.number];
        self.goodsNumber.sd_layout.bottomSpaceToView(self.main_v,15.0f).leftSpaceToView(self.main_v,0.0f).widthIs(GoodsNumberDefaultWidth).heightIs(GoodsNumberDefaultHeight);
        
        self.units_vi.sd_layout.centerYEqualToView(self.goodsNumber).leftSpaceToView(self.goodsNumber,8.0f).rightSpaceToView(self.shoppingCar_btn,0.0f).heightIs(25.0f);
        if ([dto CheckIsMoreUnit])
        {
            DHBButton *units_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
            units_btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [units_btn addTarget:self action:@selector(unitsAction:) forControlEvents:UIControlEventTouchUpInside];
            [units_btn setTitle:dto.base_units forState:UIControlStateNormal];
            [units_btn setTitle:dto.container_units forState:UIControlStateSelected];
            [self.units_vi addSubview:units_btn];
            if ([option.units isEqualToString:@"container_units"])
            {
                [units_btn setSelected:YES];
            }
            units_btn.sd_layout.topSpaceToView(self.units_vi,0.0).leftSpaceToView(self.units_vi,0.0f).widthIs([units_btn.titleLabel.text length]*14.0f+25.0f-14.0f).heightIs(25.0f);
        }
        else
        {
            UILabel *units_lb = [[UILabel alloc] init];
            units_lb.font = [UIFont systemFontOfSize:14.0f];
            units_lb.textColor = [UIColor TextBlack_Color];
            if(option.units){
                units_lb.text = ([dto valueForKey:option.units] ? [dto valueForKey:option.units] : @"");
            }
            [self.units_vi addSubview:units_lb];
            units_lb.sd_layout.centerYEqualToView(self.units_vi).leftSpaceToView(self.units_vi,0.0f).widthIs([units_lb.text length]*14.0f).autoHeightRatio(0);
        }
    }
    [self.contentView initLineisBottom:YES];
    
}
- (void)showShoppingCarButton:(BOOL) isShow{}

//单位按钮
-(void)unitsAction:(UIButton*)sender{
    [sender setSelected:!sender.selected];
    GoodsModuleDTO *goods = self.product;
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.units = sender.selected?@"container_units":@"base_units";
    }
    sender.sd_layout.widthIs([sender.selected?goods.container_units:goods.base_units length]*14.0f+25.0f-14.0f);
    [self layoutSubviews];
}

//点击购物车
- (void)shoppingCarAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(DHBGoodsViewCell:didTouchShoppingCar:GoodsModule:)]) {
        [self.delegate DHBGoodsViewCell:self didTouchShoppingCar:sender GoodsModule:self.product];
    }
}

#pragma mark - 
- (void)GoodsNumberView_textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate DHBTableViewCellBeginEditing:self];
}

-(void)GoodsNumberView:(GoodsNumberView*)goodsNumberView changeNum:(NSString *)text{
    GoodsModuleDTO *goods = self.product;
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.number = text;
    }
}

@end
