//
//  DHBOfflineRechargeTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#define LABEL_WIDTH 80.0F
#define ACCOUNT_HEIGHT 90.0F
#define SELECTED_HEIGHT 20.0F
//#define CANCELBUTTON_WIDTH 20.0F
#import "DHBOfflineRechargeTableViewCell.h"

@implementation DHBOfflineRechargeTableViewCell
#pragma mark - init
- (NSMutableArray *)accountArray{
    if(!_accountArray){
        _accountArray = [[NSMutableArray alloc] init];
    }
    return _accountArray;
}

- (UIButton *)uploadButton{
    if(!_uploadButton){
        _uploadButton = [[UIButton alloc] initWithFrame: CGRectMake(MARGIN_LEFT, MARGIN_LEFT, _floorDTO.hight - 4 * MARGIN_LEFT, _floorDTO.hight - 4 * MARGIN_LEFT)];
        [_uploadButton setImage: [UIImage imageNamed: @"add_voucher"] forState: UIControlStateNormal];
        [_uploadButton addTarget: self action: @selector(photoButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _uploadButton;
}

- (DHBUploadImageView *)uploadImageView{
    if(!_uploadImageView){
        CGFloat origin_x = self.uploadButton.width + self.uploadButton.left + MARGIN_LEFT;
        _uploadImageView = [[DHBUploadImageView alloc] initWithFrame: CGRectMake(origin_x, self.uploadButton.top, self.uploadButton.width,self.uploadButton.height)];
    }
    return _uploadImageView;
}

#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    _floorDTO = dto;
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
}

#pragma mark -
#pragma mark 样式1（转账日期）
- (void)addFloor_1{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, LABEL_WIDTH, _floorDTO.hight)];
    [titleLabel setText: [_floorDTO floorName]];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [self.contentView addSubview: titleLabel];
    //状态
    CGFloat origin_x =  titleLabel.frame.size.width + titleLabel.frame.origin.x + MARGIN_LEFT;
    if(!_rechargeTextField){
        _rechargeTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, 8.0f, SCREEN_WIDTH - origin_x - MARGIN_LEFT, _floorDTO.hight - 2 * 8.0f) style: kDHBTextField_MaxInputStyle];
        [_rechargeTextField setText: [NSDate getNowDateFormat:DEFAULT_DATE_PATTERN]];
        [_rechargeTextField showCancelButton: NO];
        [_rechargeTextField setDelegate: self];
    }
    [self.contentView addSubview: _rechargeTextField];
}

#pragma mark -
#pragma mark 样式2（收款账户）
- (void)addFloor_2{
    [self initLineisBottom: NO];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, LABEL_WIDTH, 45.0f)];
    [titleLabel setText: [_floorDTO floorName]];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [self.contentView addSubview: titleLabel];
    //下划线
    CGFloat origin_y = titleLabel.frame.size.height + titleLabel.frame.origin.y;
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xe6e6e6)];
    [self.contentView addSubview: lineView];
    
    ////账户内容
    origin_y += lineView.frame.size.height;
    CGFloat origin_x = 0.0f;
    for(NSInteger i = 0; i < [_floorDTO.moduleList count];i++){
        NSDictionary *bank = [_floorDTO.moduleList safeObjectAtIndex:i];
        
        UIView *accountView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y + i * (ACCOUNT_HEIGHT), SCREEN_WIDTH, ACCOUNT_HEIGHT)];
        [accountView setBackgroundColor: [UIColor whiteColor]];
        //点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(accountViewClick:)];
        [accountView addGestureRecognizer: tap];
        [accountView setTag: i];
        [self.contentView addSubview: accountView];
        [self.accountArray addObject: accountView];
        //选中视图
        UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, (ACCOUNT_HEIGHT - SELECTED_HEIGHT) / 2.0f, SELECTED_HEIGHT, SELECTED_HEIGHT)];
        [selectedImageView setContentMode: UIViewContentModeScaleAspectFit];
        [accountView addSubview: selectedImageView];
        if ([[bank EncodeStringFromDicWithKey:@"is_default"] isEqualToString:@"T"])
        {
            [selectedImageView setImage: [UIImage imageNamed:@"check"]];
        }
        else
        {
            [selectedImageView setImage: [UIImage imageNamed: @"uncheck"]];
        }
        //账户号
        origin_x = selectedImageView.frame.size.width + selectedImageView.frame.origin.x + MARGIN_LEFT;
        UILabel *bankLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, MARGIN_LEFT, accountView.frame.size.width - origin_x - 2 * MARGIN_LEFT, (ACCOUNT_HEIGHT - 2 * MARGIN_LEFT) / 3.0f)];
        [bankLabel setText: [bank EncodeStringFromDicWithKey:@"bank_name"]];
        [bankLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [bankLabel setTextColor: [UIColor TextBlack_Color]];
        [accountView addSubview: bankLabel];
        //账户名
        CGFloat tmp_y = bankLabel.frame.size.height + bankLabel.frame.origin.y;
        UILabel *accountLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, tmp_y, accountView.frame.size.width - origin_x - 2 * MARGIN_LEFT, (ACCOUNT_HEIGHT - 2 * MARGIN_LEFT) / 3.0f)];
        [accountLabel setText: [bank EncodeStringFromDicWithKey:@"account_name"]];
        [accountLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [accountLabel setTextColor: [UIColor TextBlack_Color]];
        [accountView addSubview: accountLabel];
        //卡号
        tmp_y = accountLabel.frame.size.height + accountLabel.frame.origin.y;
        UILabel *cardNumLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, tmp_y, accountView.frame.size.width - origin_x - 2 * MARGIN_LEFT, (ACCOUNT_HEIGHT - 2 * MARGIN_LEFT) / 3.0f)];
        [cardNumLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [cardNumLabel setTextColor: [UIColor TextBlack_Color]];
        [cardNumLabel setText: [bank EncodeStringFromDicWithKey:@"account_number"]];
        [accountView addSubview: cardNumLabel];
        //
        lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, ACCOUNT_HEIGHT - 0.5f, SCREEN_WIDTH, 0.5f)];
        [lineView setBackgroundColor: HEX_RGB(0xe6e6e6)];
        [accountView addSubview: lineView];
    }
    
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式3(备注)
- (void)addFloor_3{
    NSString *contentStr = [_floorDTO.moduleList firstObject];
    DHBTextView *remarksTextView = [[DHBTextView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, MARGIN_LEFT, SCREEN_WIDTH - 2* MARGIN_LEFT, _floorDTO.hight - 2 * MARGIN_LEFT)];
    [remarksTextView setPlaceholder: @"请填写备注"];
    [remarksTextView setFont: [UIFont systemFontOfSize: 14.0f]];
    [remarksTextView.layer setCornerRadius: 3.0f];
    [remarksTextView.layer setBorderWidth: 0.5f];
    [remarksTextView.layer setBorderColor: [UIColor InputBorder_Color].CGColor];
    [remarksTextView setTextColor: [UIColor grayColor]];
    [remarksTextView setReturnKeyType: UIReturnKeyDone];
    [remarksTextView setDelegate: self];
    [remarksTextView setText: contentStr];
    [self.contentView addSubview: remarksTextView];
}

#pragma mark -
#pragma mark 样式4（凭证）
- (void)addFloor_4{
    [self.contentView addSubview: self.uploadButton];
    [self.contentView addSubview: self.uploadImageView];
    
    ///提示信息
    CGFloat origin_y = self.uploadButton.bottom + 5.0f;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * MARGIN_LEFT, 20.0f)];
    [tipLabel setText: @"提示：最多1张，单张大小不超过4M"];
    [tipLabel setFont: [UIFont systemFontOfSize: 12.0f]];
    [tipLabel setTextColor: [UIColor grayColor]];
    [self.contentView addSubview: tipLabel];
    ///
    DHBUploadImage *image = [_floorDTO.moduleList firstObject];
    if(image){
        [self showImage: image];
    }
    else{
        [self.uploadImageView dismiss];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(offlineRechargeTableViewCell_textFieldDidBeginEditing:)]) {
        [_delegate offlineRechargeTableViewCell_textFieldDidBeginEditing:textField];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(offlineRechargeTableViewCell_textViewDidEndEditing:cell:)]) {
        [_delegate offlineRechargeTableViewCell_textViewDidEndEditing:textView cell: self];
    }
}

#pragma mark - 选择账户
- (void)accountViewClick:(UITapGestureRecognizer *) tap{
    for(UIView *itemView in self.accountArray){
        BOOL isCurView = ([itemView tag] == [tap.view tag] ? YES : NO);
        if(isCurView){
            [itemView setBackgroundColor: HEX_RGB(0xdcdcdc)];
        }
        else{
            [itemView setBackgroundColor: [UIColor whiteColor]];
        }
        for(UIView *subView in [itemView subviews]){
            if([subView isKindOfClass: [UIImageView class]]){
                if(isCurView){
                    [(UIImageView *)subView setImage: [UIImage imageNamed: @"check"]];
                }
                else{
                    [(UIImageView *)subView setImage: [UIImage imageNamed: @"uncheck"]];
                }
            }
        }
    }
    if ([_delegate respondsToSelector:@selector(offlineRechargeTableViewCell_DidSelectedAcctount: whithBankRow:)]) {
        [_delegate offlineRechargeTableViewCell_DidSelectedAcctount: self whithBankRow:[tap.view tag]];
    }
}

#pragma mark - 上传凭证
- (void)photoButtonClick:(UIButton *) sender{
    if ([_delegate respondsToSelector:@selector(offlineRechargeTableViewCell_DidUploadPicture:)]) {
        [_delegate offlineRechargeTableViewCell_DidUploadPicture: sender];
    }
}

#pragma mark - 显示图片
- (void)showImage:(DHBUploadImage *) image{
    [self.uploadImageView UpdateView: image];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(DHBTableViewCellBeginEditing:)]) {
        [_delegate DHBTableViewCellBeginEditing:self];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString: @"\n"]){
        [textView resignFirstResponder];
    }
    return YES;
}
@end
