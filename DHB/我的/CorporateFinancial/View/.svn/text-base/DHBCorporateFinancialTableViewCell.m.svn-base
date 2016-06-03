//
//  DHBCorporateFinancialTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/31/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0F
#define MARGIN_TOP 10.0F
#define TITLE_WIDTH 90.0F
#import "DHBCorporateFinancialTableViewCell.h"

@implementation DHBCorporateFinancialTableViewCell

-(UILabel *)titleLabel{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_titleLabel setTextColor:[UIColor TextBlack_Color]];
    }
    return _titleLabel;
}

-(DHBTextField *)contentTextFiled{
    if (!_contentTextFiled)
    {
        _contentTextFiled = [[DHBTextField alloc] init];
        [_contentTextFiled setStyle:kDHBTextField_MaxInputStyle];
        [_contentTextFiled setDHB_Delegate:self];
    }
    return _contentTextFiled;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentTextFiled];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    }
    return self;
}


-(void)updateData:(NSMutableArray *)data{
    self.data_arr = data;
    NSString *text = [data firstObject];
    
    [self.contentTextFiled setPlaceholder: [data objectAtIndex: 1]];
    [self.contentTextFiled setText: [data lastObject]];
    if ([text isEqualToString:@"银行账号"])
        [self.contentTextFiled setKeyboardType:UIKeyboardTypeNumberPad];
    else
        [self.contentTextFiled setKeyboardType:UIKeyboardTypeDefault];
    self.contentTextFiled.sd_layout.topSpaceToView(self.contentView,8.0f).leftSpaceToView(self.contentView,TITLE_WIDTH+15.0f*2).rightSpaceToView(self.contentView,15.0f).heightIs(30.0f);
    
    [self.titleLabel setText: text];
    self.titleLabel.sd_layout.centerYEqualToView(self.contentTextFiled).leftSpaceToView(self.contentView,15.0f).widthIs(TITLE_WIDTH).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.contentTextFiled bottomMargin:8.0f];
    
}

#pragma mark - DHBTextField_Delegate
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    ////由DHBTableViewController执行键盘的控制逻辑
    if([_delegate respondsToSelector: @selector(DHBTableViewCellBeginEditing:)]){
        [_delegate DHBTableViewCellBeginEditing:self];
    }
}

- (BOOL)DHBTextFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)DHBTextFieldDidEndEditing:(UITextField *)textField{
    [self.data_arr replaceObjectAtIndex:2 withObject:textField.text];
}

- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString: @""])
    {
        if (range.location >= 30) return NO; //只能输入是30位以内
        if ([[self.data_arr firstObject] isEqualToString:@"银行账号"])
            return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"] evaluateWithObject:string];//只能输入是0-9数字
    }
    return YES;
}

@end
