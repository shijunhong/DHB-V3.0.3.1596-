//
//  DHBShoppingCarOrderTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#define TITLE_WIDTH 80.0f
#define TITLE_HEIGHT 45.0f
#import "DHBShoppingCarOrderTableViewCell.h"

@implementation DHBShoppingCarOrderTableViewCell
#pragma mark - init
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor: [UIColor Money_Color]];
        [_priceLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_priceLabel setTextAlignment: NSTextAlignmentRight];
    }
    return _priceLabel;
}

- (UILabel *)invoiceTypeLabel{
    if(!_invoiceTypeLabel){
        _invoiceTypeLabel = [[UILabel alloc] init];
        [_invoiceTypeLabel setTextColor: [UIColor TextGray_Color]];
        [_invoiceTypeLabel setTextAlignment: NSTextAlignmentRight];
        [_invoiceTypeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    return _invoiceTypeLabel;
}

- (UILabel *)sendTimeLabel{
    if(!_sendTimeLabel){
        _sendTimeLabel = [[UILabel alloc] init];
        [_sendTimeLabel setTextColor: [UIColor TextGray_Color]];
        [_sendTimeLabel setTextAlignment: NSTextAlignmentRight];
        [_sendTimeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    }
    return _sendTimeLabel;
}

- (DHBTextField *)deliveryTextField{
    if(!_deliveryTextField){
        _deliveryTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(TITLE_WIDTH + 3* MARGIN_LEFT, 5.0f, SCREEN_WIDTH / 2.0f, 30.0f) style: kDHBTextField_MaxInputStyle];
        [_deliveryTextField setFont: [UIFont systemFontOfSize: 13.0f]];
        [_deliveryTextField setPlaceholder: @"如：快递、物流、上门自提、送货上门"];
        [_deliveryTextField setDHB_Delegate: self];
        [_deliveryTextField showCancelButton: NO];
    }
    return _deliveryTextField;
}

- (UILabel *)receiveNameLabel{
    if(!_receiveNameLabel){
        _receiveNameLabel = [[UILabel alloc] init];
        [_receiveNameLabel setTextColor: [UIColor TextGray_Color]];
        [_receiveNameLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    }
    return _receiveNameLabel;
}

- (UILabel *)phoneLabel{
    if(!_phoneLabel){
//        UIImageView *phoneIconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, origin_y, ICON_HEIGHT, ICON_HEIGHT)];
//        [phoneIconImageView setBackgroundColor: [UIColor redColor]];
//        [phoneIconImageView setContentMode: UIViewContentModeScaleAspectFit];
//        [self addSubview: phoneIconImageView];
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setTextColor: [UIColor TextGray_Color]];
        [_phoneLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel{
    if(!_addressLabel){
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor: [UIColor TextGray_Color]];
        [_addressLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    }
    return _addressLabel;
}

- (DHBTextView *)remarksTextView{
    if(!_remarksTextView){
        _remarksTextView = [[DHBTextView alloc] init];
        [_remarksTextView setTintColor: [UIColor TextRed_Color]];
        [_remarksTextView setTextColor: [UIColor TextGray_Color]];
        [_remarksTextView setPlaceholder: @"备注：可填写您与供货商达成的协议"];
        [_remarksTextView setFont: [UIFont systemFontOfSize: 14.0f]];
        [_remarksTextView.layer setCornerRadius: 3.0f];
        [_remarksTextView.layer setBorderColor: HEX_RGB(0xe7e7e7).CGColor];
        [_remarksTextView setDelegate: self];
        [_remarksTextView setReturnKeyType: UIReturnKeyDone];
        [_remarksTextView.layer setBorderWidth: 1.0f];
    }
    return _remarksTextView;
}

- (RBCustomDatePickerView *)datepicker{
    if(!_datepicker){
        _datepicker = [[RBCustomDatePickerView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DATEPICKER_HEIGHT)];
        [_datepicker setDelegate: self];
    }
    return _datepicker;
}

#pragma mark - 更新视图
- (void)updateViewWithDTO: (HomeFloorDTO *) dto{
    [self.layer setMasksToBounds: YES];
    self.floor = dto;
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //更新视图
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    [self.contentView setBackgroundColor: [UIColor whiteColor]];
    [self setBackgroundColor: [UIColor whiteColor]];
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
}

#pragma mark -
#pragma mark 商品金额
- (void)addFloor_1{
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.contentView addSubview: self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).widthIs(TITLE_WIDTH).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT);
    [self.titleLabel setText: @"商品金额"];
    
    ///金额
    [self.contentView addSubview: self.priceLabel];
    if(userInfoDTO)
        [self.priceLabel setText: [NSString  stringWithFormat:@"%@%@",L(@"￥"), userInfoDTO.total_price]];
    self.priceLabel.sd_layout.widthIs(SCREEN_WIDTH / 2.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT);
    
    [self.contentView initLineisBottom:YES];
    
    [self setAccessoryType: UITableViewCellAccessoryNone];
    //
    [self setupAutoHeightWithBottomView: self.titleLabel bottomMargin: DEFAULT_LINE_HEIGHT];
}

#pragma mark 发票类型
- (void)addFloor_2{
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.contentView addSubview: self.titleLabel];
    [self.titleLabel setText: @"发票类型"];
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).widthIs(TITLE_WIDTH).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT);
    
    //
    [self.contentView addSubview: self.invoiceTypeLabel];
    self.invoiceTypeLabel.sd_layout.leftSpaceToView(self.titleLabel, 0.0f).rightSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT);
    if(userInfoDTO){
        ///配送方式
        switch (userInfoDTO.venders.invoice_type)
        {
            case BK:
                [self.invoiceTypeLabel setText:@"不需要发票"];
                break;
            case PT:
            {
                NSString *price = [NSString formatDecimal: [userInfoDTO.total_price doubleValue] * 0.03 cnt: [[ParameterPublic sharedManagered] price_accuracy]];
                [self.invoiceTypeLabel setText:[NSString stringWithFormat:@"普通发票(%@%%税点) %@%@", userInfoDTO.venders.pt_taxing_point, L(@"￥"), price]];
            }
                break;
            case ZZ:
            {
                NSString *price = [NSString formatDecimal: [userInfoDTO.total_price doubleValue] * 0.04 cnt: [[ParameterPublic sharedManagered] price_accuracy]];
                [self.invoiceTypeLabel setText:[NSString stringWithFormat:@"增值税发票(%@%%税点) %@%@", userInfoDTO.venders.zz_taxing_point, L(@"￥"),price]];
            }
                break;
            default:
                break;
        }
    }
    
    [self.contentView initLineisBottom:YES];
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    //
    [self setupAutoHeightWithBottomView: self.titleLabel bottomMargin: DEFAULT_LINE_HEIGHT];
}

#pragma mark 配送方式
- (void)addFloor_3{
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: topView];
    topView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_SECTION_HEIGHT).widthIs(SCREEN_WIDTH);
    
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.contentView addSubview: self.titleLabel];
    [self.titleLabel setText: @"配送方式"];
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).widthIs(TITLE_WIDTH).topSpaceToView(topView, 0.0F).heightIs(TITLE_HEIGHT);
    
    ///
    [self.contentView addSubview: self.deliveryTextField];
    self.deliveryTextField.sd_layout.leftSpaceToView(self.titleLabel, 15.0f).topSpaceToView(topView, 5.0f).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs(TITLE_HEIGHT - 10.0f);
    if(userInfoDTO.distrib_mode && (![userInfoDTO.distrib_mode isEqualToString:@""])){
        [self.deliveryTextField setText: [userInfoDTO distrib_mode]];
    }
    
    //
    [self.contentView initLineisBottom:YES];
    [self setAccessoryType: UITableViewCellAccessoryNone];
    //
    [self setupAutoHeightWithBottomView: self.titleLabel bottomMargin: DEFAULT_LINE_HEIGHT];
}

#pragma mark 交货日期
- (void)addFloor_4{
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.titleLabel setText: @"交货日期"];
    [self.contentView addSubview: self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).widthIs(TITLE_WIDTH).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT);

    //
    [self.contentView addSubview: self.sendTimeLabel];
    self.sendTimeLabel.sd_layout.rightSpaceToView(self.contentView, 5.0f).topSpaceToView(self.contentView, 0.0f).heightIs(TITLE_HEIGHT).widthIs(SCREEN_WIDTH / 2.0f);
    [self.sendTimeLabel setText: @"请选择"];
    if(userInfoDTO){
        [self.sendTimeLabel setText: [[userInfoDTO delivery_date] length] > 0 ? [userInfoDTO delivery_date] : @"请选择"];
    }
    
    //
    [self.contentView initLineisBottom:YES];
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    //
    [self setupAutoHeightWithBottomView: self.titleLabel bottomMargin:DEFAULT_LINE_HEIGHT];
}

#pragma mark 收货信息
- (void)addFloor_5{
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: topView];
    topView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_SECTION_HEIGHT).widthIs(SCREEN_WIDTH);
    
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.titleLabel setText: @"收货人信息"];
    [self.contentView addSubview: self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).widthIs(TITLE_WIDTH).topSpaceToView(topView, 5.0f).heightIs(TITLE_HEIGHT / 2.0f);
    
    [self.contentView addSubview: self.receiveNameLabel];
    self.receiveNameLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(self.titleLabel, 0.0f).heightIs(TITLE_HEIGHT / 2.0f).widthIs(SCREEN_WIDTH / 3.0F);
    [self.receiveNameLabel setText: @"请选择收货地址"];
    if(userInfoDTO && [[[userInfoDTO.purchasers address] contact] length] > 0){
        [self.receiveNameLabel setText: [[userInfoDTO.purchasers address] contact]];
    }
    
    [self.contentView addSubview: self.phoneLabel];
    [self.phoneLabel setTextAlignment: NSTextAlignmentLeft];
    self.phoneLabel.sd_layout.leftSpaceToView(self.receiveNameLabel, MARGIN_LEFT).topSpaceToView(self.titleLabel, 0.0f).heightIs(TITLE_HEIGHT / 2.0f).rightSpaceToView(self.contentView, 5.0f);
    if(userInfoDTO && [[[userInfoDTO.purchasers address] phone] length] > 0 ){
        [self.phoneLabel setText: [[userInfoDTO.purchasers address] phone] ];
        
    }
    
    [self.contentView addSubview: self.addressLabel];
    self.addressLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).rightSpaceToView(self.contentView, 0.0f).topSpaceToView(self.receiveNameLabel, 0.0f).autoHeightRatio(0);
    if(userInfoDTO){
        [self.addressLabel setText: [[userInfoDTO.purchasers address] address]];
    }
    
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    //
    [self setupAutoHeightWithBottomView: self.addressLabel bottomMargin: 15.0f];
}

#pragma mark 备注
- (void)addFloor_6{
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self.contentView addSubview: topView];
    topView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).heightIs(DEFAULT_SECTION_HEIGHT).widthIs(SCREEN_WIDTH);
    
    UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
    [self.contentView addSubview: self.remarksTextView];
    self.remarksTextView.sd_layout.leftSpaceToView(self.contentView, MARGIN_LEFT).topSpaceToView(topView, MARGIN_LEFT).rightSpaceToView(self.contentView, MARGIN_LEFT).heightIs(60.0f);
    if(userInfoDTO){
        [self.remarksTextView setText: [userInfoDTO remark]];
    }
    
    [self.contentView initLineisBottom:YES];
    
    [self setAccessoryType: UITableViewCellAccessoryNone];
    
    [self setupAutoHeightWithBottomView: self.remarksTextView bottomMargin:15.0f];
}

#pragma mark 时间筛选
- (void)addFloor_7{
    [self.contentView addSubview: self.datepicker];
    self.datepicker.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.contentView, 0.0f).widthIs(SCREEN_WIDTH).heightIs(DATEPICKER_HEIGHT);
    [self setBackgroundColor: HEX_RGB(0xf0f0f0)];
    
    [self setAccessoryType: UITableViewCellAccessoryNone];
    
    [self setupAutoHeightWithBottomView: self.datepicker bottomMargin: MARGIN_LEFT];
}

#pragma mark - RBCustomDatePickerView delegate
-(void)selectNOAction{
    if([_delegate respondsToSelector: @selector(shoppingCarOrderTableViewCell_DidCancelButtonClick)]){
        [_delegate shoppingCarOrderTableViewCell_DidCancelButtonClick];
    }
}

- (void)RBCustomDatePickerView:(RBCustomDatePickerView *)pickerView selectOkAction:(NSString *)selectTime
{
    if([_delegate respondsToSelector: @selector(shoppingCarOrderTableViewCell_DidOkButtonClick:selectTime:)]){
        [_delegate shoppingCarOrderTableViewCell_DidOkButtonClick: pickerView selectTime: selectTime];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([_delegate respondsToSelector: @selector(shoppingCarOrderTableViewCell_textViewDidBeginEditing: cell:)]){
        [_delegate shoppingCarOrderTableViewCell_textViewDidBeginEditing: textView cell: self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([_delegate respondsToSelector: @selector(shoppingCarOrderTableViewCell_textViewDidEndEditing: cell:)]){
        [_delegate shoppingCarOrderTableViewCell_textViewDidEndEditing: textView cell: self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqual: @"\n"])
    {
        [textView resignFirstResponder];
        if([_delegate respondsToSelector: @selector(shoppingCarOrderTableViewCell_textViewDidEndEditing: cell:)]){
            [_delegate shoppingCarOrderTableViewCell_textViewDidEndEditing: textView cell: self];
        }
        return YES;
    }
    if (textView && (![textView.text isEqualToString:@""])){
        if (textView == self.remarksTextView)//备注 只能输入是200位以内
        {
            if (range.location >= 200) return NO;
        }
    }
    return YES;
}

#pragma mark - DHBTextField_Delegate
- (void)DHBTextFieldDidEndEditing:(UITextField *)textField{
    if (textField && (![textField.text isEqualToString:@""]) && textField == self.deliveryTextField)
    {
        UserInformationModuleDTO *userInfoDTO = [[self.floor moduleList] firstObject];
        userInfoDTO.distrib_mode = textField.text;
    }
}
- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField && (![textField.text isEqualToString:@""])){
        if (textField == self.deliveryTextField)//配送方式 只能输入是20位以内
        {
            if (range.location >= 20) return NO;
        }
    }
    return YES;
}
@end
