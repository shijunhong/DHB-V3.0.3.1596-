//
//  DHBProductDetailsCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsDetailsCell.h"
#import "DHBGoodsImgScrollModelView.h"
#import "MultiModuleDTO.h"
#import "GoodsNumberView.h"
#import "OptionModuleDTO.h"
#import "DHBProductView_2.h"
#import "GoodsFieldModuleDTO.h"
@interface DHBGoodsDetailsCell ()<DHBProductView_2Delegate, GoodsNumberViewDelegate>{
}

@end

@implementation DHBGoodsDetailsCell


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

#pragma mark - 商品图片模板
- (void)addFloor_1 {
    DHBEightBannerView *bannerView = [[DHBEightBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    [bannerView setBackgroundColor:[UIColor whiteColor]];
//    bannerView.delegate = self;
    [bannerView updateViewWithDTO:_floorDTO UseingViewBlock:^UIView *(NSObject *obj,int i) {
        NSString *dto = (NSString*)obj;
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, bannerView.frame.size.width, bannerView.frame.size.height)];
        [imageView setBackgroundColor:[UIColor whiteColor]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView.placeholderImage = [UIImage imageNamed:@"invalid"];
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dto]];
        imageView.delegate = self;
        return imageView;
    }];
    [self.contentView addSubview:bannerView];
}
#pragma mark - 商品描述模板
-(void)addFloor_2{
    NSDictionary *dic= [_floorDTO.moduleList safeObjectAtIndex:0];
    
    UILabel *name_lb = [[UILabel alloc] init];
    name_lb.font = [UIFont systemFontOfSize:15];
    name_lb.lineBreakMode = NSLineBreakByWordWrapping;
    name_lb.numberOfLines = 2;
    [name_lb setTextColor:[UIColor TextBlack_Color]];
    [name_lb setText:[dic objectForKey:@"goods_name"]];
    [self.contentView addSubview:name_lb];
    
    UILabel *numAndselling_lb = [[UILabel alloc] init];
    numAndselling_lb.font = [UIFont systemFontOfSize:11];
    numAndselling_lb.lineBreakMode = NSLineBreakByWordWrapping;
    [numAndselling_lb setTextColor:HEX_RGB(0x757575)];
    [numAndselling_lb setText:[NSString stringWithFormat:@"编号：%@   市场价：￥%@",[dic objectForKey:@"goods_num"],[dic objectForKey:@"selling_price"]]];
    [self.contentView addSubview:numAndselling_lb];
    
    name_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    numAndselling_lb.sd_layout.topSpaceToView(name_lb,8.0f).leftEqualToView(name_lb).rightEqualToView(name_lb).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:numAndselling_lb bottomMargin:15.0f];
    TT_RELEASE_SAFELY(name_lb);
    TT_RELEASE_SAFELY(numAndselling_lb);
}

#pragma mark - 规格模板
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
        view.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
        
        UILabel *name_lb = [[UILabel alloc] init];
        name_lb.lineBreakMode = NSLineBreakByWordWrapping;
        name_lb.numberOfLines = 2;
        name_lb.font = [UIFont systemFontOfSize:13];
        name_lb.textColor = [UIColor TextBlack_Color];
        name_lb.text = [NSString stringWithFormat:@"%@",multi.name];
        [view addSubview:name_lb];
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
            CGSize size = [childMulti MultiChildSizefWithType:0];
            if (x_row >= 4)
            {
                x_row = 0;
                y_row = y_row+1;
            }
            if ((int)size.width == (int)S_0_w)
            {
                multi_btn.sd_layout.topSpaceToView(view,5+y_row*(size.height+15)).leftSpaceToView(name_lb,15.0f+x_row*(S_0_w+15)).widthIs(size.width).heightIs(size.height);
                x_row = x_row +1;
            }
            else if ((int)size.width == (int)M_0_w)
            {
                if (x_row >2)
                {
                    x_row = 0;
                    y_row =y_row + 1;
                }
                multi_btn.sd_layout.topSpaceToView(view,5+y_row*(size.height+15)).leftSpaceToView(name_lb,15.0f+x_row*(S_0_w+15)).widthIs(size.width).heightIs(size.height);
                x_row = x_row +2;
            }
            else if ((int)size.width == (int)X_0_w)
            {
                x_row = 0;
                multi_btn.sd_layout.topSpaceToView(view,5+y_row*(size.height+15)).leftSpaceToView(name_lb,15.0f+x_row*(S_0_w+15)).widthIs(size.width).heightIs(size.height);
                x_row = 4;
            }
            
            ///选中状态
//            [multi_btn setSelected: childMulti.is_seleted];
            ///
            [multi_btn setTitle:[NSString stringWithFormat:@"%@",childMulti.name] forState:UIControlStateNormal];
            multi_btn.tag = [childMulti.multiId intValue];
            multi_btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [multi_btn addTarget:self action:@selector(multiAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:multi_btn];
        }
        [view setupAutoHeightWithBottomView:multi_btn bottomMargin:0.0f];
        [view layoutSubviews];
        hight = hight + view.sd_bottomView.bottom+15.0f;
    }
    [self setupAutoHeightWithBottomView:view bottomMargin:view.sd_bottomView.bottom+15.0f];
}

#pragma mark - 数量模板
- (void)addFloor_4{
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    OptionModuleDTO *option = [goods getSelectOptions];
    UILabel *count_lb =[[UILabel alloc] init];
    count_lb.font = [UIFont systemFontOfSize:13.0f];
    count_lb.textColor = [UIColor TextBlack_Color];
    count_lb.text = @"数量";
    [self.contentView addSubview:count_lb];
    count_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(35.0f).autoHeightRatio(0);
    
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
        units_btn.width = [units_btn.titleLabel.text length]*14.0f+25.0f-14.0f;
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
    
    
    UILabel *kucun_lb =[UILabel new];
    [kucun_lb setFont:[UIFont systemFontOfSize:12.0f]];
    [kucun_lb setAdjustsFontSizeToFitWidth: YES];
    [kucun_lb setTextColor:[UIColor TextGray_Color]];
    [self.contentView addSubview:kucun_lb];
    [kucun_lb setText:[NSString stringWithFormat:@"(库存：%@)",[goods getSelectAvailable]]];
    kucun_lb.sd_layout.topSpaceToView(goodsNumber,8.0f).leftEqualToView(goodsNumber).autoHeightRatio(0);
    [kucun_lb setSingleLineAutoResizeWithMaxWidth:self.contentView.width];

    
    UILabel *minOrder_lb = [UILabel new];
    [minOrder_lb setFont:[UIFont systemFontOfSize:12.0f]];
    [minOrder_lb setTextColor:[UIColor TextGray_Color]];
    [minOrder_lb setAdjustsFontSizeToFitWidth: YES];
    [minOrder_lb setText:[NSString stringWithFormat:@"(起订: %@%@)",goods.min_order,[goods valueForKey:goods.order_units]]];
    [self.contentView addSubview:minOrder_lb];
    if ([[ParameterPublic sharedManagered] show_inventory])//显示库存
    {
        minOrder_lb.sd_layout.topEqualToView(kucun_lb).leftSpaceToView(kucun_lb,8.0f).autoHeightRatio(0);
    }
    else
    {
        [kucun_lb setHidden:YES];
        minOrder_lb.sd_layout.topEqualToView(kucun_lb).leftEqualToView(goodsNumber).autoHeightRatio(0);
    }
    [minOrder_lb setSingleLineAutoResizeWithMaxWidth:self.contentView.width];
    if (![goods.container_units isEqualToString:@""])
    {
        UILabel *conversion_lb = [UILabel new];
        [conversion_lb setFont:[UIFont systemFontOfSize:12.0f]];
        [conversion_lb setTextColor:[UIColor TextGray_Color]];
        [conversion_lb setAdjustsFontSizeToFitWidth: YES];
        [conversion_lb setText:[NSString stringWithFormat:@"(1%@ = %@%@)",goods.container_units,goods.conversion_number,goods.base_units]];
        [self.contentView addSubview:conversion_lb];
        conversion_lb.sd_layout.topEqualToView(kucun_lb).leftSpaceToView(minOrder_lb,8.0f).autoHeightRatio(0);
        [conversion_lb setSingleLineAutoResizeWithMaxWidth:self.contentView.width];
    }
    
    //底部还需要划线
    UIView *bottomView = [[UIImageView alloc] init];
    [bottomView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomView];
    bottomView.sd_layout.topSpaceToView(minOrder_lb,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0.0f];
    
}

#pragma mark - 促销模板
- (void)addFloor_5{
    UIView *chuXiaoCell = [[[NSBundle mainBundle] loadNibNamed:@"DHBGoodsChuXiaoCell" owner:self options:nil] objectAtIndex:0];
    [self.contentView addSubview:chuXiaoCell];
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
}

#pragma mark - 活动模板
- (void)addFloor_6{
    UIView *activityCell = [[[NSBundle mainBundle] loadNibNamed:@"DHBGoodsDetailsActivityCell" owner:self options:nil] objectAtIndex:0];
    NSDictionary *dic= [_floorDTO.moduleList safeObjectAtIndex:self.indexPath.row];
    NSString *imageName;
    if ([[dic objectForKey:@"name"] isEqualToString:@"满赠"])
    {
        imageName =@"mz";
    }
    else if ([[dic objectForKey:@"name"] isEqualToString:@"套装"])
    {
        imageName =@"tz";
    }
    [self.activity_img setImage:[UIImage imageNamed:imageName]];
    [self.describe_lb setText:[dic objectForKey:@"content"]];
    [self.contentView addSubview:activityCell];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 10, 22, 22)];
    [image setImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:image];
    
    //顶部部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, _floorDTO.hight - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH-15, DEFAULT_LINE_HEIGHT)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
    
    if (_floorDTO.floors == self.indexPath.row+1)
    {
        UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight, SCREEN_WIDTH-30, 30)];
        [bottomImageView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:bottomImageView];
        
        //顶部部还需要划线
        UIView *bottom_v = [[UIImageView alloc] initWithFrame:CGRectMake(0, bottomImageView.bounds.size.height - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottom_v setBackgroundColor:[UIColor CellLine_Color]];
        [bottomImageView addSubview:bottom_v];
        TT_RELEASE_SAFELY(bottom_v);
        TT_RELEASE_SAFELY(bottomImageView);
        
        //顶部部还需要划线
        UIView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight+30, SCREEN_WIDTH, 16)];
        [bottomView setBackgroundColor:HEX_RGB(0xf0f0f0)];
        [self.contentView addSubview:bottomView];
        TT_RELEASE_SAFELY(bottomView);
    }
}

#pragma mark - 介绍模板
- (void)addFloor_7{
    NSDictionary *dic = [_floorDTO.moduleList safeObjectAtIndex:0];
    for (int i  = 0; i<[[dic objectForKey:@"field"] count]; i++)
    {
        GoodsFieldModuleDTO *field= [[dic objectForKey:@"field"] safeObjectAtIndex:i];
        TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, 15+(10+12)*i, SCREEN_WIDTH, 12)];
        label.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"%@: %@",field.name,field.value];
        [label setText:str afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange grayRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@:",field.name] options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
            return mutableAttributedString;
        }];
        [self.contentView addSubview: label];
    }
    
    if (!self.webView)
    {
        self.webView =[dic objectForKey:@"web"];
    }
    self.webView.scrollView.userInteractionEnabled = NO;
    [self.contentView addSubview: self.webView];
    /**
     *  当没有商品介绍的时候提示用户暂无商品介绍
     */
    if([[dic objectForKey:@"field"] count] == 0 ){
        if (![dic objectForKey:@"content"] || [[dic objectForKey:@"content"] isEqualToString:@""])
        {
            [[DHBNoDataView sharedManagered] showMessageInParentView: self.contentView message: @"暂无商品介绍"];
        }
        else if (self.webView.height <= 1)
        {
            [[DHBNoDataView sharedManagered] showMessageInParentView: self.contentView message: @"商品加载中..."];
        }
    }
}

#pragma mark - 相关商品
- (void)addFloor_8{
    NSDictionary *dic = [_floorDTO.moduleList safeObjectAtIndex:0];
    if ([[dic objectForKey:@"goods"] count]>0&&dic)
    {
        NSMutableArray *products = [NSMutableArray array];
        for (int i = 0; i<2; i++)
        {
            //添加每列数据 模板为2件商品并排
            GoodsModuleDTO * goods = [[dic objectForKey:@"goods"] safeObjectAtIndex:self.indexPath.row*2+i];
            if (goods)
            {
                [products addObject:goods];
            }
        }
        DHBProductView_2 *productView = [[DHBProductView_2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        productView.delegate = self;
        [productView updateViewWithDTO:products];
        [self.contentView addSubview:productView];
        //底部还需要划线
        UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
        [self.contentView addSubview:bottomImageView];
        TT_RELEASE_SAFELY(bottomImageView);
    }
    else{
        [[DHBNoDataView sharedManagered] showMessageInParentView: self message: @"暂无相关商品"];
    }
}

#pragma mark - 阶梯价
-(void)addFloor_9{
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    OptionModuleDTO *option = [goods getSelectOptions];
    
    CGFloat hight = 0.0f;
    UIView *price_vi;
    if (!option || [option.number_price count] == 0)//无规格，或有规格，无阶梯价
    {
        price_vi = [UIView new];
        [self.contentView addSubview:price_vi];
        price_vi.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).heightIs(15.0f);
        
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
            price_vi.sd_layout.topSpaceToView(self.contentView,hight).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
            
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
//            float priceWidth = [price_lb.text sizeWithFont:price_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 15.0f)].width;
            price_lb.sd_layout.topSpaceToView(price_vi,0.0f).leftSpaceToView(price_vi,0.0f).autoHeightRatio(0);
            [price_lb setSingleLineAutoResizeWithMaxWidth:self.contentView.width];
            
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

#pragma mark - 规格按钮 buttonAction
-(void)multiAction:(UIButton*)sender{
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
#pragma mark - 单位按钮
-(void)unitsAction:(UIButton*)sender{
    [sender setSelected:!sender.selected];
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.units = sender.selected?@"container_units":@"base_units";
    }
    sender.sd_layout.widthIs([sender.selected?goods.container_units:goods.base_units length]*14.0f+25.0f-14.0f);
    [self layoutSubviews];
}

#pragma mark DHBProductView_2Delegate 相关商品点击
-(void)productSelected_2DTO:(GoodsModuleDTO *)product{
    if ([_delegate respondsToSelector:@selector(selectGoods:)])
    {
        [self.delegate selectGoods:product];
    }
}

#pragma mark -  GoodsNumberViewDelegate
-(void)GoodsNumberView_textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate DHBTableViewCellBeginEditing:self];
}

-(void)GoodsNumberView:(GoodsNumberView*)goodsNumberView changeNum:(NSString *)text{
    GoodsModuleDTO *goods = [[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"goods"];
    OptionModuleDTO *option =  [goods getSelectOptions];
    if (option)
    {
        option.number = text;
    }
}
@end
