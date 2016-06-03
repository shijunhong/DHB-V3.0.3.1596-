//
//  DHBModifyPasswordTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0f
#define MARGIN_TOP 10.0f
#define TITLE_WIDTH 100.0f
#import "DHBModifyPasswordTableViewCell.h"

@implementation DHBModifyPasswordTableViewCell

#pragma mark -
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        [self setSize: size];
        [self addTitleLabel];
        [self addContentTextFiled];
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        [self initLineisBottom: YES];
    }
    return self;
}

#pragma mark - title
- (void)addTitleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:  CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, self.size.height)];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
    }
    [self addSubview: _titleLabel];
}

- (void)addContentTextFiled{
    if(!_contentTextFiled){
        CGFloat origin_x = SCREEN_WIDTH / 3.0f;
        _contentTextFiled = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, SCREEN_WIDTH - origin_x - MARGIN_LEFT, self.size.height - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_contentTextFiled setDHB_Delegate: self];
        [_contentTextFiled setFontSize: 14.0];
        [_contentTextFiled setSecureTextEntry: YES];
        [_contentTextFiled setKeyboardType: UIKeyboardTypeNamePhonePad];
    }
    [self addSubview: _contentTextFiled];
}

#pragma mark - textField delegate
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    if([_delegate respondsToSelector: @selector(modifyPasswordTableViewCell_TextFieldDidBeginEditing:cell:)]){
        [_delegate modifyPasswordTableViewCell_TextFieldDidBeginEditing: textField cell: self];
    }
}

- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""] && textField == self.contentTextFiled)//密码
    {
        if (range.location >= 18) return NO; //只能输入是18位以内
        return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[a-zA-Z0-9]"] evaluateWithObject:string];//只能输入 数字、字母
    }
    return YES;
}

@end
