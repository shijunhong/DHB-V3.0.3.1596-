//
//  DHBOptionTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOptionTableViewCell.h"
#import "GoodsModuleDTO.h"
#import "OptionModuleDTO.h"
#import "MultiModuleDTO.h"
@implementation DHBOptionTableViewCell


- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_floorDTO != dto)
    {
        _floorDTO = dto;
    }
    self.indexPath = indexPath;
    //移除旧的视图
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        objc_msgSend(self, selectorMethod);
    }
}

//商品图片模板
- (void)addFloor_1 {
    GoodsModuleDTO *goods = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageViewEx *goods_img = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(20,20,50,50)];
    goods_img.userInteractionEnabled = YES;
    goods_img.placeholderImage = [UIImage imageNamed:@"invalid2"];
    goods_img.delegate = self;
    goods_img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", goods.goods_picture]];
    goods_img.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:goods_img];
    
    TTTAttributedLabel *name_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(goods_img.right+11, goods_img.top, SCREEN_WIDTH-(goods_img.right+11)-13-60, 25)];
    name_lb.font = [UIFont systemFontOfSize:13];
    name_lb.lineBreakMode = NSLineBreakByWordWrapping;
    name_lb.numberOfLines = 2;
    [name_lb setTextColor:[UIColor TextBlack_Color]];
    [name_lb setText:goods.goods_name];
    [name_lb sizeToFit];
    [self.contentView addSubview:name_lb];
    
    TTTAttributedLabel *mun_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    mun_lb.font = [UIFont systemFontOfSize:13];
    mun_lb.lineBreakMode = NSLineBreakByWordWrapping;
    mun_lb.numberOfLines = 0;
    [mun_lb setTextColor:[UIColor TextGray_Color]];
    [mun_lb setText:[NSString stringWithFormat:@"编号：%@", goods.goods_num]];
    [self.contentView addSubview:mun_lb];
    mun_lb.sd_layout.topSpaceToView(goods_img,-15.0f).leftEqualToView(name_lb).rightSpaceToView(self.contentView,15.0f).heightIs(15.0f);
}

//阶梯价
- (void)addFloor_2 {
    
    
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    OptionModuleDTO *option = [goods getSelectOptions];
    
    CGFloat hight = 0.0f;
    UIView *price_vi;
    if (!option || [option.number_price count] == 0)//无规格，或有规格，无阶梯价
    {
        price_vi = [UIView new];
        [self.contentView addSubview:price_vi];
        price_vi.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,20.0f).rightSpaceToView(self.contentView,15.0f).heightIs(15.0f);
        
        NSString *price = option?option.whole_price:goods.whole_price;
        TTTAttributedLabel *price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        price_lb.font = [UIFont systemFontOfSize:15.0f];
        [price_lb setTextColor:[UIColor Money_Color]];
        [price_vi addSubview:price_lb];
        [price_lb setText:[NSString stringWithFormat:@"%@%@/%@",L(@"￥"),price,goods.base_units] afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange grayRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",goods.base_units] options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
            NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:11];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:RMBRange];
                CFRelease(font);
            }
            return mutableAttributedString;
        }];
        price_lb.sd_layout.topSpaceToView(price_vi,0.0f).leftSpaceToView(price_vi,0.0f).widthRatioToView(price_vi,1).autoHeightRatio(0);
    }
    else
    {
        for (int i = 0; i<[option.number_price count]; i++)
        {
            NSDictionary *price_dic = [option.number_price safeObjectAtIndex:i];
            NSString *price = [price_dic EncodeStringFromDicWithKey:@"price"];
            
            price_vi = [UIView new];
            [self.contentView addSubview:price_vi];
            price_vi.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,20.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
            
            TTTAttributedLabel *price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
            price_lb.font = [UIFont systemFontOfSize:15.0f];
            [price_lb setTextColor:[UIColor Money_Color]];
            [price_vi addSubview:price_lb];
            [price_lb setText:[NSString stringWithFormat:@"%@%@/%@",L(@"￥"),price,goods.base_units] afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                NSRange grayRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",goods.base_units] options:NSCaseInsensitiveSearch];
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
                NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
                UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:11];
                CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
                if (font) {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:RMBRange];
                    CFRelease(font);
                }
                return mutableAttributedString;
            }];
            float priceWidth = [price_lb.text sizeWithFont:price_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 15.0f)].width;
            price_lb.sd_layout.topSpaceToView(price_vi,0.0f).leftSpaceToView(price_vi,0.0f).widthIs(priceWidth).autoHeightRatio(0);
            
            
            UILabel *num_lb = [UILabel new];
            num_lb.font = [UIFont systemFontOfSize:13];
            num_lb.textColor = [UIColor TextGray_Color];
            [price_vi addSubview:num_lb];
            [num_lb setText:[NSString stringWithFormat:@"%@ ~ %@%@",[price_dic objectForKey:@"start"],[price_dic EncodeStringFromDicWithKey:@"end"],goods.base_units]];
            if (![price_dic EncodeStringFromDicWithKey:@"end"] || [[price_dic EncodeStringFromDicWithKey:@"end"] isEqualToString:@""])
            {
                [num_lb setText:[NSString stringWithFormat:@"≥ %@%@",[price_dic objectForKey:@"start"],goods.base_units]];
            }
            num_lb.sd_layout.topSpaceToView(price_vi,1.0f).leftSpaceToView(price_lb,25.0f).rightSpaceToView(price_vi,0.0f).autoHeightRatio(0);
            
            [price_vi setupAutoHeightWithBottomView:price_lb bottomMargin:0.0f];
            [price_vi layoutSubviews];
            hight = hight + price_vi.sd_bottomView.bottom+8.0f;
        }
    }
    //  底部还需要划线
    UIView *bottomView = [[UIImageView alloc] init];
    [bottomView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomView];
    bottomView.sd_layout.topSpaceToView(price_vi,price_vi.sd_bottomView.bottom+8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0.0f];
}

//规格模板
- (void)addFloor_3{
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    if (![[ParameterPublic sharedManagered] client_view_goods_price])
    {
        //顶部部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [topImageView setBackgroundColor:[UIColor CellLine_Color]];
        [self.contentView addSubview:topImageView];
        TT_RELEASE_SAFELY(topImageView);
    }
    CGFloat hight = 15.0f;
    UIView *view;
    for (int i = 0; i<[goods.multi_data count]; i++)
    {
        MultiModuleDTO *multi = [goods.multi_data safeObjectAtIndex:i];
        view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,20.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
        
        UILabel *name_lb = [UILabel new];
        name_lb.lineBreakMode = NSLineBreakByWordWrapping;
        name_lb.numberOfLines = 2;
        name_lb.font = [UIFont systemFontOfSize:13.0f];
        name_lb.textColor = [UIColor TextBlack_Color];
        name_lb.text = [NSString stringWithFormat:@"%@",multi.name];
        [view addSubview: name_lb];
        name_lb.sd_layout.topSpaceToView(view,0.0f).leftSpaceToView(view,0.0f).widthIs(35.0f).heightIs(35.0f);
        int x_row = 0;
        int y_row = 0;
        DHBButton *multi_btn;
        for (int j = 0; j<[multi.options count]; j++)
        {
            MultiChildModuleDTO *childMulti = [multi.options safeObjectAtIndex:j];
            
            multi_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue2];
            if (childMulti.is_disEnable)
            {
                [multi_btn setSelected:NO];
            }
            else
            {
                [multi_btn setSelected:childMulti.is_seleted];
            }
            [multi_btn setEnabled:!childMulti.is_disEnable];
            [view addSubview:multi_btn];

            CGSize size = [childMulti MultiChildSizefWithType:1];
            if ((int)size.width == (int)S_1_w)
            {
                multi_btn.sd_layout.topSpaceToView(view,5+y_row*(size.height+15)).leftSpaceToView(name_lb,15.0f+x_row*(S_1_w+15)).widthIs(size.width).heightIs(size.height);
                x_row = x_row +1;
            }
            else if ((int)size.width == (int)X_1_w)
            {
                if(x_row > 0)
                {
                    y_row = y_row+1;
                }
                x_row = 0;
                multi_btn.sd_layout.topSpaceToView(view,5+y_row*(size.height+15)).leftSpaceToView(name_lb,15.0f+x_row*(S_1_w+15)).widthIs(size.width).heightIs(size.height);
                x_row = 3;
            }
            
            if (x_row == 3)
            {
                x_row = 0;
                y_row = y_row+1;
            }
            
            [multi_btn setSelected:childMulti.is_seleted];
            [multi_btn setTitle:[NSString stringWithFormat:@"%@",childMulti.name] forState:UIControlStateNormal];
            multi_btn.tag = [childMulti.multiId intValue];
            multi_btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [multi_btn addTarget:self action:@selector(multiAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [view setupAutoHeightWithBottomView:multi_btn bottomMargin:0.0f];
        [view layoutSubviews];
        hight = hight + view.sd_bottomView.bottom+15.0f;
    }
    [self setupAutoHeightWithBottomView:view bottomMargin:view.sd_bottomView.bottom+15.0f];
}



//数量模板
- (void)addFloor_4{
    CGFloat multiple = 1;
    if ([SystemInfo is_iPhone_5])
    {
        multiple = 0.3;
    }
    GoodsModuleDTO *goods = [_floorDTO.moduleList safeObjectAtIndex:0];
    OptionModuleDTO *option = [goods getSelectOptions];
    
    UILabel *count_lb =[[UILabel alloc] init];
    count_lb.font = [UIFont systemFontOfSize:13.0f];
    count_lb.textColor = [UIColor TextBlack_Color];
    count_lb.text = @"数量";
    [self.contentView addSubview:count_lb];
    count_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,20.0f).widthIs(35.0f).autoHeightRatio(0);
    
    GoodsNumberView *goodsNumber = [[GoodsNumberView alloc] init];
    goodsNumber.delegate = self;
    goodsNumber.goods = goods;
    goodsNumber.numberTF.text = [NSString stringWithFormat:@"%@",option.number?option.number:@""];
    [self.contentView addSubview:goodsNumber];
    goodsNumber.sd_layout.centerYEqualToView(count_lb).leftSpaceToView(count_lb,15.0f).widthIs(GoodsNumberDefaultWidth).heightIs(GoodsNumberDefaultHeight);
    
    if ([goods CheckIsMoreUnit])
    {
        DHBButton *units_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue6];
        units_btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [units_btn setTitle:goods.base_units forState:UIControlStateNormal];
        [units_btn setTitle:goods.container_units forState:UIControlStateSelected];
        [units_btn addTarget:self action:@selector(unitsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:units_btn];
        if ([option.units isEqualToString:@"container_units"])
        {
            [units_btn setSelected:YES];
        }
        units_btn.sd_layout.centerYEqualToView(goodsNumber).leftSpaceToView(goodsNumber,8.0f).widthIs([units_btn.titleLabel.text length]*14.0f+25.0f-14.0f).heightIs(25.0f);
    }
    else
    {
        UILabel *units_lb = [[UILabel alloc] init];
        units_lb.font = [UIFont systemFontOfSize:14.0f];
        units_lb.textColor = [UIColor TextBlack_Color];
        units_lb.text = option?[goods valueForKey:option.units]:@"";
        [self.contentView addSubview:units_lb];
        units_lb.sd_layout.centerYEqualToView(goodsNumber).leftSpaceToView(goodsNumber,8.0f).widthIs([units_lb.text length]*14.0f).autoHeightRatio(0);
    }
    
    NSString * kucun;
    UILabel *kucun_lb =[UILabel new];
    [kucun_lb setFont:[UIFont systemFontOfSize:12.0f]];
    [kucun_lb setAdjustsFontSizeToFitWidth: YES];
    [kucun_lb setTextColor:[UIColor TextGray_Color]];
    [self.contentView addSubview:kucun_lb];
    if ([[ParameterPublic sharedManagered] show_inventory])
    {        
        kucun = [NSString stringWithFormat:@"(库存：%@)",[goods getSelectAvailable]];
        [kucun_lb setText:kucun];
    }
    float kucunWidth = [kucun sizeWithFont:kucun_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 12.0f)].width;
    kucun_lb.sd_layout.topSpaceToView(goodsNumber,8.0f).leftSpaceToView(self.contentView,20.0f).widthIs(kucunWidth).autoHeightRatio(0);
    if (![[ParameterPublic sharedManagered] show_inventory])//不显示库存
    {
        [kucun_lb setHidden:YES];
    }
    
    UILabel *minOrder_lb = [UILabel new];
    [minOrder_lb setFont:[UIFont systemFontOfSize:12.0f]];
    [minOrder_lb setTextColor:[UIColor TextGray_Color]];
    [minOrder_lb setAdjustsFontSizeToFitWidth: YES];
    [minOrder_lb setText:[NSString stringWithFormat:@"(起订: %@%@)",goods.min_order,[goods valueForKey:goods.order_units]]];
    [self.contentView addSubview:minOrder_lb];
    float minOrderWidth = [minOrder_lb.text sizeWithFont:minOrder_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 12.0f)].width;
    minOrder_lb.sd_layout.topEqualToView(kucun_lb).leftSpaceToView(kucun_lb,8.0f).widthIs(minOrderWidth).autoHeightRatio(0);
    
    if (![goods.container_units isEqualToString:@""])
    {
        UILabel *conversion_lb = [UILabel new];
        [conversion_lb setFont:[UIFont systemFontOfSize:12.0f]];
        [conversion_lb setTextColor:[UIColor TextGray_Color]];
        [conversion_lb setAdjustsFontSizeToFitWidth: YES];
        [conversion_lb setText:[NSString stringWithFormat:@"(1%@ = %@%@)",goods.container_units,goods.conversion_number,goods.base_units]];
        [self.contentView addSubview:conversion_lb];
        float conversionWidth = [conversion_lb.text sizeWithFont:conversion_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 12.0f)].width;
        conversion_lb.sd_layout.topEqualToView(kucun_lb).leftSpaceToView(minOrder_lb,8.0f).widthIs(conversionWidth).autoHeightRatio(0);
    }
    
    [self setupAutoHeightWithBottomView:minOrder_lb bottomMargin:8.0f];
}


//规格按钮
-(void)multiAction:(DHBButton*)sender{
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    [goods updateMultiDisEnableWithMultiId:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    if ([goods getReverMutiWithChildMultiId:[NSString stringWithFormat:@"%ld",(long)sender.tag]])
    {
        [goods getMultiChildWithChildMultiId:[NSString stringWithFormat:@"%ld",(long)sender.tag]].is_seleted = NO;
        for (MultiModuleDTO *multi_i in goods.multi_data)
        {
            if (![[goods getMultiWithChildMultiId:[NSString stringWithFormat:@"%ld",(long)sender.tag]].multiId isEqualToString:multi_i.multiId])
            {
                for (MultiChildModuleDTO *multi_ic in multi_i.options)
                {
                    multi_ic.is_disEnable = NO;
                }
            }
        }
    }
    else
    {
        [goods updateMultiSelectWithMultiId:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    [self.delegate selectMulti:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}

//单位按钮
-(void)unitsAction:(UIButton*)sender{    
    [sender setSelected:!sender.selected];
    GoodsModuleDTO *goods = [_floorDTO.moduleList safeObjectAtIndex:0];
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.units = sender.selected?@"container_units":@"base_units";
    }
    sender.sd_layout.widthIs([sender.selected?goods.container_units:goods.base_units length]*14.0f+25.0f-14.0f);
    [self layoutSubviews];
}

#pragma mark -  GoodsNumberViewDelegate
-(void)GoodsNumberView:(GoodsNumberView*)goodsNumberView changeNum:(NSString *)text{
    GoodsModuleDTO *goods = [_floorDTO.moduleList safeObjectAtIndex:0];
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.number = text;
    }
}

#pragma mark - EGOImageViewDelegate
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error{
    [imageView setImage:[UIImage imageNamed:@"invalid2"]];
}
@end
