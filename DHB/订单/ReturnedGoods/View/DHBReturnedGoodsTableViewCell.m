//
//  DHBReturnedGoodsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedGoodsTableViewCell.h"

@implementation DHBReturnedGoodsTableViewCell


-(EGOImageViewEx *)image_vi{
    if (!_image_vi)
    {
        _image_vi= [[EGOImageViewEx alloc] initWithFrame:CGRectMake(15,15,55,55)];
        _image_vi.userInteractionEnabled = YES;
        _image_vi.placeholderImage = [UIImage imageNamed:@"invalid"];
        [self.contentView addSubview:_image_vi];
    }
    return _image_vi;
}

-(UILabel *)num_lb{
    if (!_num_lb)
    {
        _num_lb = [[UILabel alloc] initWithFrame:CGRectMake(80, 14, 200, 15)];
        _num_lb.textColor = [UIColor TextGray_Color];
        _num_lb.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_num_lb];
    }
    return _num_lb;
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, SCREEN_WIDTH-95, 40)];
        _name_lb.lineBreakMode = NSLineBreakByWordWrapping;
        _name_lb.numberOfLines = 2;
        _name_lb.textColor = [UIColor TextBlack_Color];
        _name_lb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_name_lb];
    }
    return _name_lb;
}

-(TTTAttributedLabel *)price_lb{
    if (!_price_lb)
    {
        _price_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200-15, 70, 200, 20)];
        _price_lb.font = [UIFont systemFontOfSize:15];
        _price_lb.textColor = [UIColor TextRed_Color];
        _price_lb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_price_lb];
    }
    return _price_lb;
}

-(UIButton *)select_btn{
    if (!_select_btn)
    {
        _select_btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 97, 30, 36)];
        [_select_btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_select_btn];
    }
    return _select_btn;
}

-(UILabel *)units_lb{
    if (!_units_lb)
    {
        _units_lb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-15, 97, 20, 36)];
        _units_lb.textColor = [UIColor TextGray_Color];
        _units_lb.font = [UIFont systemFontOfSize:13];
        _units_lb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_units_lb];
    }
    return _units_lb;
}

-(UILabel *)returnnum_lb{
    if (!_returnnum_lb)
    {
        _returnnum_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.goodnum_vi.left-100, 97, 90, 36)];
        _returnnum_lb.font = [UIFont systemFontOfSize:14];
        _returnnum_lb.textColor = [UIColor TextRed_Color];
        _returnnum_lb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_returnnum_lb];
    }
    return _returnnum_lb;
}

-(GoodsNumberView *)goodnum_vi{
    if (!_goodnum_vi)
    {
        _goodnum_vi = [[GoodsNumberView alloc] initWithFrame:CGRectMake(self.units_lb.left-112*Multiple,97+6, GoodsNumberDefaultWidth, GoodsNumberDefaultHeight)];
        _goodnum_vi.delegate =self;
        [self.contentView addSubview:_goodnum_vi];
    }
    return _goodnum_vi;
}

-(UIView *)middle_line{
    if (!_middle_line)
    {
        _middle_line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 97, SCREEN_WIDTH, 1)];
        [_middle_line setBackgroundColor:[UIColor CellLine_Color]];
        [self.contentView addSubview:_middle_line];
    }
    return _middle_line;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIImageView alloc] init];
        [_bottomView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        [self.contentView addSubview:_bottomView];
        UIView *bottomTop_line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomTop_line setBackgroundColor:[UIColor CellLine_Color]];
        [_bottomView addSubview:bottomTop_line];
    }
    return _bottomView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)updateViewWithGoods:(OrdersgoodsModuleDTO*)ordersgoods{
    self.ordersgoods = ordersgoods;
    GoodsModuleDTO *goods = ordersgoods.goods;
    
    self.image_vi.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", goods.goods_picture]];
    self.image_vi.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(55.0f).heightIs(55.0f);
    
    self.num_lb.text = [NSString stringWithFormat:@"编号：%@",goods.goods_num];
    self.num_lb.sd_layout.topEqualToView(self.image_vi).leftSpaceToView(self.image_vi,8.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    
    self.name_lb.text = goods.goods_name;
    
    [self.price_lb setText:[NSString stringWithFormat:@"%@%@",L(@"￥"),ordersgoods.orders_price] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *RMBFont = [UIFont systemFontOfSize:11];
        CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
        if (RMBfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
            CFRelease(RMBfont);
        }
        return mutableAttributedString;
    }];
    self.price_lb.sd_layout.topSpaceToView(self.name_lb,8.0f).rightSpaceToView(self.contentView,15.0f).leftSpaceToView(self.image_vi,8.0f).autoHeightRatio(0);
    
    self.middle_line.sd_layout.topSpaceToView(self.price_lb,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
   
    if (ordersgoods.is_select)
    {
        [self.select_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [self.contentView setBackgroundColor:[UIColor UIViewBackGroundColor]];
    }
    else
    {
        [self.select_btn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    self.select_btn.sd_layout.topSpaceToView(self.middle_line,0.0f).leftSpaceToView(self.contentView,8.0f).widthIs(30.0f).heightIs(30.0f);
    
    self.units_lb.text = goods.base_units;
    float unitsWidth = [self.units_lb.text sizeWithFont:self.units_lb.font constrainedToSize:CGSizeMake(MAXFLOAT, 13.0f)].width;
    self.units_lb.sd_layout.topSpaceToView(self.middle_line,8.0f).rightSpaceToView(self.contentView,15.0f).widthIs(unitsWidth).autoHeightRatio(0);
    
    self.goodnum_vi.goods = ordersgoods.goods;
    self.goodnum_vi.numberTF.text = [NSString formatDecimal:ordersgoods.orders_number cnt:[[ParameterPublic sharedManagered] quantitative_accuracy]];
    self.goodnum_vi.max_num = ordersgoods.orders_number;
    self.goodnum_vi.sd_layout.topSpaceToView(self.middle_line,2.0f).rightSpaceToView(self.units_lb,8.0f).widthIs(GoodsNumberDefaultWidth).heightIs(GoodsNumberDefaultHeight);
    
    self.returnnum_lb.text = [NSString stringWithFormat:@"可退：%@",[NSString formatDecimal:ordersgoods.orders_number cnt:[[ParameterPublic sharedManagered] quantitative_accuracy]]];
    self.returnnum_lb.sd_layout.topSpaceToView(self.middle_line,8.0f).rightSpaceToView(self.goodnum_vi,8.0f).leftSpaceToView(self.select_btn,8.0f).autoHeightRatio(0);
    
    self.bottomView.sd_layout.topSpaceToView(self.goodnum_vi,2.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_SECTION_HEIGHT);
    
    [self setupAutoHeightWithBottomView:self.bottomView bottomMargin:0.0f];
}


-(void)selectAction:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"uncheck"]])
    {
        [sender setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [self.contentView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        self.ordersgoods.goods.number = self.goodnum_vi.numberTF.text;
        self.ordersgoods.is_select = YES;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.ordersgoods.is_select = NO;
    }
    [self.delegate DHBReturnedGoodsTableViewCell:self is_select:self.ordersgoods];
}

#pragma mark GoodsNumberViewDelegate

-(void)GoodsNumberView:(GoodsNumberView*)goodsNumberView changeNum:(NSString *)text{
    [self.delegate DHBReturnedGoodsTableViewCell:self is_select:self.ordersgoods];
}

-(void)GoodsNumberView_textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate DHBTableViewCellBeginEditing:self];
}

@end
