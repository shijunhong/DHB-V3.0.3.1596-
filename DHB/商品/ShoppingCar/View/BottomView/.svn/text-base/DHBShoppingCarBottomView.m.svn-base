//
//  DHBShoppingCarBottomView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/29.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShoppingCarBottomView.h"

@implementation DHBShoppingCarBottomView

-(DHBLabel *)total_lb{
    if (!_total_lb)
    {
        _total_lb = [[DHBLabel alloc] initWithFrame:CGRectZero];
        _total_lb.font = [UIFont systemFontOfSize:15.0f];
        [_total_lb setTextColor:[UIColor TextGray_Color]];
        [_total_lb setText:@"合计："];
    }
    return _total_lb;
}

-(UILabel *)goods_lb{
    if (!_goods_lb)
    {
        _goods_lb = [[UILabel alloc] init];
        _goods_lb.font = [UIFont systemFontOfSize:13.0f];
        [_goods_lb setTextColor:[UIColor TextGray_Color]];
        [_goods_lb setText:@"商品："];
    }
    return _goods_lb;
}


-(DHBButton *)shopping_btn{
    if (!_shopping_btn)
    {
        _shopping_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue1];
    }
    return _shopping_btn;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self)
    {
        //顶部还需要划线
        [self initLineisBottom:NO];
        
        [self setBackgroundColor:HEX_RGB(0xf2f2f2)];
        [self addSubview:self.total_lb];
        [self addSubview:self.goods_lb];
        [self addSubview:self.shopping_btn];
        [self layout:ShoppingBottom];
    }
    return self;
}

-(void)layout:(BottomType)type{
    switch (type)
    {
        case ShoppingBottom:
            self.shopping_btn.sd_layout.topSpaceToView(self,0.5f).rightSpaceToView(self,0.0f).widthIs(150.0f*Multiple).heightIs(self.height-.5f);
            self.total_lb.sd_layout.topSpaceToView(self,8.0f).leftSpaceToView(self,15.0f).rightSpaceToView(self.shopping_btn,8.0f).autoHeightRatio(0);
            [self.goods_lb setHidden:NO];
            self.goods_lb.sd_layout.topSpaceToView(self.total_lb,5.0f).leftEqualToView(self.total_lb).rightEqualToView(self.total_lb).autoHeightRatio(0);
            break;
        case OrderBottom:
            self.total_lb.sd_layout.topSpaceToView(self,15.0f).leftSpaceToView(self,15.0f).rightSpaceToView(self.shopping_btn,8.0f).autoHeightRatio(0);
            [self.goods_lb setHidden:YES];
            break;
            
        default:
            break;
    }
    [self layoutSubviews];
}

-(void)setBottomViewContent:(NSDictionary *)dic layoutType:(BottomType)type{
    self.bottom_type = type;
    switch (type)
    {
        case ShoppingBottom:
            [self updateShoppingBottom:dic];
            break;
        case OrderBottom:
            [self updateOrderBottom:dic];
            break;
        default:
            break;
    }
    [self layout:type];
    
}

/**
 *  购物车底部视图赋值
 */
-(void)updateShoppingBottom:(NSDictionary *)dic{
    NSString *price = [NSString formatDecimal:[[dic EncodeNumberFromDicWithKey:@"total_price"] doubleValue] cnt:[[ParameterPublic sharedManagered] price_accuracy]];
    NSString *total_price = [NSString stringWithFormat:@"合计: %@%@",L(@"￥"),price];
    [self.total_lb setPriceText:total_price price:price $Fount:[UIFont systemFontOfSize:11.0f]];
    
    NSString *total_num = [NSString stringWithFormat:@"商品: %ld",(long)[[dic objectForKey:@"total_num"] integerValue]];
    [self.goods_lb setText:total_num];
    
    [self.shopping_btn setTitle:@"提交" forState:UIControlStateNormal];
}

/**
 *  订单底部视图赋值
 *
 *  @param dic
 */
-(void)updateOrderBottom:(NSDictionary *)dic{
    NSString *price = [NSString formatDecimal:[[dic EncodeNumberFromDicWithKey:@"total_price"] doubleValue] cnt:[[ParameterPublic sharedManagered] price_accuracy]];
    NSString *total_price = [NSString stringWithFormat:@"订单金额：%@%@",L(@"￥"),price];
    [self.total_lb setPriceText:total_price price:price $Fount:[UIFont systemFontOfSize:11.0f]];
    
    [self.shopping_btn setTitle:@"确认订单" forState:UIControlStateNormal];
}

@end
