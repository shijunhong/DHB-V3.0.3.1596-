//
//  DHBShoppingCarCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShoppingCarCell.h"

@interface DHBShoppingCarCell()<GoodsNumberViewDelegate>
@property(nonatomic,strong)EGOImageViewEx *goods_img;//商品图片
@property(nonatomic,strong)UILabel *goodsNum_lb;//商品编号
@property(nonatomic,strong)UILabel *goodsName_lb;//名称
@property(nonatomic,strong)UILabel *goodsOptions_lb;//规格
@property(nonatomic,strong)TTTAttributedLabel *goodsPrice_lb;//金额
@property(nonatomic,strong)UIView  *line_vi;//万恶的分割线——————————————
@property(nonatomic,strong)UIButton *delete_btn;//删除
@property(nonatomic,strong)UILabel *units_lb;//单位
@property(nonatomic,strong)UILabel *conversion_lb;//换算关系
@property(nonatomic,strong)GoodsNumberView *goodsNumber;//数量控件
@property(nonatomic,strong)UILabel *inventoryNumber_lb;//默认库存
@end

@implementation DHBShoppingCarCell

-(EGOImageViewEx *)goods_img{
    if (!_goods_img)
    {
        _goods_img = [[EGOImageViewEx alloc] init];
        _goods_img.userInteractionEnabled = YES;
        _goods_img.placeholderImage = [UIImage imageNamed:@"invalid2"];
        [self.contentView addSubview:_goods_img];
    }
    return _goods_img;
}

-(UILabel *)goodsNum_lb{
    if (!_goodsNum_lb)
    {
        _goodsNum_lb = [UILabel new];
        _goodsNum_lb.font = [UIFont systemFontOfSize:12.0f];
        _goodsNum_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_goodsNum_lb];
    }
    return _goodsNum_lb;
}

-(UILabel *)goodsName_lb{
    if (!_goodsName_lb)
    {
        _goodsName_lb = [[UILabel alloc] initWithFrame:CGRectMake(15.0f+55.0f+10.0f, 15.0f+11.0f+10.0f,self.contentView.frame.size.width-(15.0f+55.0f+10.0f)-15.0f, 35.0f)];
        _goodsName_lb.font = [UIFont systemFontOfSize:15.0f];
        _goodsName_lb.textColor = [UIColor TextBlack_Color];
        _goodsName_lb.numberOfLines = 2;
        _goodsName_lb.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_goodsName_lb];
    }
    return _goodsName_lb;
}

-(UILabel *)goodsOptions_lb{
    if (!_goodsOptions_lb)
    {
        _goodsOptions_lb = [UILabel new];
        _goodsOptions_lb.font = [UIFont systemFontOfSize:12.0f];
        _goodsOptions_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_goodsOptions_lb];
    }
    return _goodsOptions_lb;
}


-(TTTAttributedLabel *)goodsPrice_lb{
    if (!_goodsPrice_lb)
    {
        _goodsPrice_lb = [TTTAttributedLabel new];
        _goodsPrice_lb.font = [UIFont systemFontOfSize:14.0f];
        _goodsPrice_lb.textColor = [UIColor Money_Color];
        _goodsPrice_lb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_goodsPrice_lb];
    }
    return _goodsPrice_lb;
}

-(UIView *)line_vi{
    if (!_line_vi)
    {
        _line_vi = [UIView new];
        _line_vi.backgroundColor = [UIColor CellLine_Color];
        [self.contentView addSubview:_line_vi];
    }
    return _line_vi;
}

-(UIButton *)delete_btn{
    if (!_delete_btn)
    {
        _delete_btn = [[UIButton alloc] init];
        [_delete_btn setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
        [_delete_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_delete_btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_delete_btn];
    }
    return _delete_btn;
}

-(UILabel *)units_lb{
    if (!_units_lb)
    {
        _units_lb = [UILabel new];
        _units_lb.font = [UIFont systemFontOfSize:11.0f];
        _units_lb.textAlignment = NSTextAlignmentRight;
        _units_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_units_lb];
    }
    return _units_lb;
}

-(UILabel *)conversion_lb{
    if (!_conversion_lb)
    {
        _conversion_lb = [UILabel new];
        _conversion_lb.font = [UIFont systemFontOfSize:11.0f];
        _conversion_lb.textAlignment = NSTextAlignmentRight;
        _conversion_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_conversion_lb];
    }
    return _conversion_lb;
}

-(GoodsNumberView *)goodsNumber{
    if (!_goodsNumber)
    {
        _goodsNumber = [[GoodsNumberView alloc] initWithFrame:CGRectMake(0, 0, 110, 25)];
        _goodsNumber.delegate = self;
        [self.contentView addSubview:_goodsNumber];
    }
    return _goodsNumber;
}

-(UILabel *)inventoryNumber_lb{
    if (!_inventoryNumber_lb)
    {
        _inventoryNumber_lb = [UILabel new];
        _inventoryNumber_lb.font = [UIFont systemFontOfSize:13.0f];
        _inventoryNumber_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_inventoryNumber_lb];
    }
    return _inventoryNumber_lb;
}

-(UILabel *)goodsCount_lb{
    if (!_goodsCount_lb)
    {
        _goodsCount_lb = [UILabel new];
        _goodsCount_lb.font = [UIFont systemFontOfSize:13.0f];
        _goodsCount_lb.textAlignment = NSTextAlignmentRight;
        _goodsCount_lb.textColor = [UIColor TextRed_Color];
        [_goodsCount_lb setHidden:NO];
        [_goodsCount_lb setBackgroundColor: [UIColor clearColor]];
        [self.contentView insertSubview: _goodsCount_lb belowSubview: self.delete_btn];
    }
    return _goodsCount_lb;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layout];
    }
    return self;
}

- (void)layout
{
    //顶部
    [self.contentView initLineisBottom:NO];
    
    self.goods_img.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(55.0f).heightIs(55.0f);
    
    self.goodsNum_lb.sd_layout.topEqualToView(self.goods_img).leftSpaceToView(self.goods_img,10.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    
    self.goodsName_lb.frame = CGRectMake(15.0f+55.0f+10.0f, 15.0f+11.0f+5.0f,SCREEN_WIDTH-(15.0f+55.0f+10.0f)-15.0f, 35.0f);
    
    self.goodsOptions_lb.sd_layout.topSpaceToView(self.goods_img,0.0f).leftEqualToView(self.goodsName_lb).widthIs(200.0f).autoHeightRatio(0);
    
    self.line_vi.sd_layout.topSpaceToView(self.goods_img,29.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(0.5f);
    
    self.delete_btn.sd_layout.topSpaceToView(self.line_vi,7.0f).leftSpaceToView(self.contentView,5.0f).widthIs(40.0f).heightIs(22.0f);
    
    self.conversion_lb.sd_layout.topSpaceToView(self.line_vi,14.0f).rightSpaceToView(self.contentView,15.0f).widthIs(11.0f).autoHeightRatio(0);
    
    self.units_lb.sd_layout.topSpaceToView(self.line_vi,12.0f).rightSpaceToView(self.conversion_lb,0.0f).widthIs(11.0f).autoHeightRatio(0);
    
    self.goodsNumber.sd_layout.topSpaceToView(self.line_vi,4.0f).rightSpaceToView(self.units_lb,10.0f).widthIs(GoodsNumberDefaultWidth).heightIs(GoodsNumberDefaultHeight);
    
    self.inventoryNumber_lb.sd_layout.centerYEqualToView(self.goodsNumber).rightSpaceToView(self.goodsNumber,15.0f).widthIs(0.0f).autoHeightRatio(0);
    
    self.goodsCount_lb.sd_layout.topSpaceToView(self.goodsNumber, 5.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView, 15.0f).autoHeightRatio(0);
    
    [self.contentView initSectionView];
}

- (void)updateViewWithGoodsDTO:(GoodsModuleDTO *)dto{
    
    self.goods = dto;
    
    self.goods_img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dto.goods_picture]];
    
    self.goodsNum_lb.text = [NSString stringWithFormat:@"编号：%@",dto.goods_num];
    
    self.goodsName_lb.frame = CGRectMake(15.0f+55.0f+10.0f, 15.0f+11.0f+5.0f,SCREEN_WIDTH-(15.0f+55.0f+10.0f)-15.0f, 35.0f);
    self.goodsName_lb.text = dto.goods_name;
    [self.goodsName_lb sizeToFit];
    
    
    NSString *conversion_str = [NSString formatDecimal:[dto.conversion_number doubleValue]*[dto.number doubleValue] cnt:0];
    self.conversion_lb.text = [dto.units isEqualToString:@"container_units"]?[NSString stringWithFormat:@"(%@%@)",conversion_str,dto.base_units]:@"";
    self.conversion_lb.sd_layout.topSpaceToView(self.line_vi,12.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    [self.conversion_lb setSingleLineAutoResizeWithMaxWidth:200.0f];
    
    self.units_lb.sd_layout.topSpaceToView(self.line_vi,12.0f).rightSpaceToView(self.conversion_lb,0.0f).widthIs([[dto valueForKey:dto.units] length]*11.0f).autoHeightRatio(0);
    self.units_lb.text = [dto valueForKey:dto.units];
    
    NSMutableString *options_name = [NSMutableString string];
    for (int i = 0; i<[dto.multi_data count]; i++)
    {
        NSDictionary *dic = [dto.multi_data safeObjectAtIndex:i];
        if([[dto.multi_data safeObjectAtIndex:i] isKindOfClass: [NSDictionary class]]){
            if (!i)
            {
                [options_name appendString:[NSString stringWithFormat:@"%@",[dic EncodeStringFromDicWithKey:@"options_name"]]];
            }
            else
            {
                [options_name appendString:[NSString stringWithFormat:@",%@",[dic EncodeStringFromDicWithKey:@"options_name"]]];
            }
        }
    }
    self.goodsOptions_lb.text = options_name;
    
    double p = [[dto getnumberPrice:[NSString stringWithFormat:@"%lf",[dto.units isEqualToString:@"base_units"]?[dto.number doubleValue]:[dto.conversion_number doubleValue]*[dto.number doubleValue]] price_id:dto.price_id] doubleValue];//价格
    NSString *price = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),[NSString formatDecimal:p cnt:[[ParameterPublic sharedManagered] price_accuracy]],dto.base_units];
    [self.goodsPrice_lb setText:price afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange grayRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",dto.base_units] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:11.0f];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:RMBRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    self.goodsPrice_lb.sd_layout.topSpaceToView(self.goods_img,0.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    [self.goodsPrice_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    self.goodsNumber.goods = dto;
    self.goodsNumber.numberTF.text = dto.number;
    
    NSMutableString *goodCount = [NSMutableString string];
    if (![dto.min_number isEqualToString:@""]&&dto.min_number)
    {
        if([dto.number doubleValue] < [dto.min_order doubleValue])
        {
            [goodCount appendString:[NSString stringWithFormat:@"起订:%@",dto.min_number]];
        }
    }
    if (![dto.available_number isEqualToString:@""]&&dto.available_number)
    {
        [goodCount appendString:[NSString stringWithFormat:@"  库存:%@",dto.available_number]];
    }
    self.goodsCount_lb.text = goodCount;
    if([goodCount length] > 0){
        [self.goodsCount_lb setHidden: NO];
        self.delete_btn.sd_layout.topSpaceToView(self.line_vi, 16.0f);
    }
    else{
        [self.goodsCount_lb setHighlighted: YES];
        self.delete_btn.sd_layout.topSpaceToView(self.line_vi, 7.0f);
    }
    
    self.inventoryNumber_lb.text = ([dto.available_number isEqualToString:@""]||!dto.available_number)&&dto.inventory_number?[NSString stringWithFormat:@"库存:%@",dto.inventory_number]:@"";
    self.inventoryNumber_lb.sd_layout.autoHeightRatio(0);
    [self.inventoryNumber_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    if (![[ParameterPublic sharedManagered] show_inventory])//不显示库存
    {
        [self.inventoryNumber_lb setHidden:YES];
    }
    
    [self setupAutoHeightWithBottomView:self.goodsCount_lb bottomMargin:5.0f+DEFAULT_SECTION_HEIGHT];
}


- (void)deleteAction:(UIButton *)sender {
    [self.delegate goodsDelete:self.goods];
}

#pragma mark GoodsNumberViewDelegate
-(void)GoodsNumberView:(GoodsNumberView *)goodsNumberView changeNum:(NSString *)text{
    NSString *conversion_str = [NSString formatDecimal:[self.goods.conversion_number doubleValue]*[self.goods.number doubleValue] cnt:0];
    self.conversion_lb.text = [self.goods.units isEqualToString:@"container_units"]?[NSString stringWithFormat:@"(%@%@)",conversion_str,self.goods.base_units]:@"";
    [self.delegate goodsNumberViewChanged:goodsNumberView];
}

- (void)GoodsNumberView_textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate DHBTableViewCellBeginEditing:self];
}
@end
