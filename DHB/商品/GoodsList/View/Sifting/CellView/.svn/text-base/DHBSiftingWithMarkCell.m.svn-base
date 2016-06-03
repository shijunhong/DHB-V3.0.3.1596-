//
//  DHBSiftingWithMarkCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/17.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSiftingWithMarkCell.h"
#import "SiftingModuleDTO.h"
@implementation DHBSiftingWithMarkCell

- (UILabel *)brandLabel{
    if(!_brandLabel){
        _brandLabel = [[UILabel alloc] init];
        _brandLabel.font = [UIFont systemFontOfSize:14];
        _brandLabel.textColor = [UIColor TextGray_Color];
        [_brandLabel setTextAlignment: NSTextAlignmentRight];
    }
    return _brandLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_floorDTO != dto)
    {
        _floorDTO = dto;
        self.indexPath = indexPath;
    }
    
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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

//筛选模板
- (void)addFloor_1 {
    int btn_width = SCREEN_WIDTH/4.5;
    int padding =((SCREEN_WIDTH-60)-30-btn_width*3)/2;
    for (int i = 0 ; i<[_floorDTO.moduleList count]; i++)
    {
        TagModuleDTO *tag = [_floorDTO.moduleList safeObjectAtIndex:i];
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15+btn_width*(i%3)+padding*(i%3),15+(i/3)*(38+10), btn_width, 38) style: kDHBButton_StyleValue2];
        [btn setTitle:tag.tag_name forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.tag = i;
        [btn setSelected: tag.is_select];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight-1, SCREEN_WIDTH, 0.5)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
}

- (void)addFloor_2 {
    CGFloat multiple = SCREEN_WIDTH/375;
    UILabel *price_lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH/4.5, 25)];
    price_lb.textColor = [UIColor TextBlack_Color];
    price_lb.text = @"价格";
    price_lb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:price_lb];
    
    UITextField *min_tf = [[UITextField alloc] initWithFrame:CGRectMake(price_lb.right, 15, 60*multiple, 25)];
    [min_tf setBackgroundColor:HEX_RGB(0xf0f0f0)];
    [min_tf setTextColor:HEX_RGB(0x757575)];
    [min_tf setFont:[UIFont systemFontOfSize:14]];
    [min_tf setTextAlignment: NSTextAlignmentCenter];
    [min_tf setTintColor: [UIColor TextRed_Color]];
    min_tf.keyboardType = UIKeyboardTypeDecimalPad;
    min_tf.tag = 1;
    min_tf.delegate = self;
    [self.contentView addSubview:min_tf];
    
    UILabel *label_1 = [[UILabel alloc] initWithFrame:CGRectMake(min_tf.right+5*multiple, 15, 45*multiple, 25)];
    label_1.textColor = [UIColor TextBlack_Color];
    label_1.text = @"元  -";
    label_1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label_1];
    
    UITextField *max_tf = [[UITextField alloc] initWithFrame:CGRectMake(label_1.right, 15, 60*multiple, 25)];
    [max_tf setBackgroundColor:HEX_RGB(0xf0f0f0)];
    [max_tf setTextColor:HEX_RGB(0x757575)];
    [max_tf setFont:[UIFont systemFontOfSize:14]];
    [max_tf setTextAlignment: NSTextAlignmentCenter];
    [max_tf setTintColor: [UIColor TextRed_Color]];
    max_tf.keyboardType = UIKeyboardTypeDecimalPad;
    max_tf.tag = 2;
    max_tf.delegate = self;
    [self.contentView addSubview:max_tf];
    
    UILabel *label_2 = [[UILabel alloc] initWithFrame:CGRectMake(max_tf.right+5*multiple, 15, 14, 25)];
    label_2.textColor = [UIColor TextBlack_Color];
    label_2.text = @"元";
    label_2.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label_2];
    
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight-1, SCREEN_WIDTH, 0.5)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
}


- (void)addFloor_3 {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80.0f, 44)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor TextBlack_Color];
    label.text = @"品牌";
    [self.contentView addSubview:label];
    ///箭头
    UIImageView *image_vi = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-17-15-60, 44-15-18, 22, 22)];
    [image_vi setImage:[UIImage imageNamed:@"ic_arrow_normal"]];
    [self.contentView addSubview:image_vi];
    ///品牌名称
    CGFloat origin_x = label.frame.size.width + label.frame.origin.x + 10.0f;
    [self.brandLabel setFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - (SCREEN_WIDTH - image_vi.frame.origin.x), 44.0f)];
    self.brandLabel.text = @"全部";
    [self.contentView addSubview: self.brandLabel];
}

#pragma mark - 更新品牌
- (void)updateBrandViewWithDTO:(BrandModuleDTO *)dto{
    [self.brandLabel setText: [dto brand_name]];
}

-(void)btnAction:(UIButton *)sender{
    for (NSObject *obj in [[sender superview] subviews]) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)obj;
            [btn setSelected: NO];
        }
    }
    [sender setSelected: YES];
    
//多选代码
//    sender.selected = !sender.selected;
//    if (sender.selected)
//    {
//        sender.layer.borderColor = [UIColor BtnSelectBorder_Color].CGColor;
//        [sender setTitleColor:[UIColor TextRed_Color] forState:UIControlStateNormal];
//    }
//    else
//    {
//        sender.layer.borderColor = [UIColor BtnBorder_Color].CGColor;
//        [sender setTitleColor:[UIColor TextBlack_Color] forState:UIControlStateNormal];
//    }
    
    [self.delegate selectSiftingCell:self markBtnIndex:sender.tag];
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate selectSiftingCell:self textField:textField];
    KeyboardManager.is_shwoCMview = YES;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString: @""])
    {
        NSString *strFormat = @"[0-9]";
        NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strFormat];
        if([string isEqualToString: @"."] && ![[textField text] containsString: @"."])return YES; ///只允许输入一个小数点
        if (![strPredicate evaluateWithObject:string]) return NO;//当不是数字的时候不允许输入
        //判断小数点前的位数不能超过8位,小数点后的位数不能超过2位(注：此时需要判断当前输入的值是在小数点之前还是在小数点之后)
        NSArray *tmpArray = [[textField text] componentsSeparatedByString: @"."];
        BOOL isValidata = YES;
        if ([tmpArray count] <= 1)
        {
            //没有有小数点
            isValidata = [[tmpArray objectAtIndex: 0] length] < 8 ? YES : NO;
        }
        else
        {
            //有小数
            isValidata = [[tmpArray objectAtIndex: 0] length] <= 8 ? YES : NO;
            if([tmpArray count] > 1 && isValidata)
            {
                isValidata = [[tmpArray objectAtIndex: 1] length] < 2 ? YES : NO;
            }
        }
        return isValidata;
    }
    return YES;
}
@end
