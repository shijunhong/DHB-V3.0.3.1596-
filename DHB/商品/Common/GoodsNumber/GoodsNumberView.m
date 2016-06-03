//
//  GoodsNumberView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/4.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define BUTTON_WIDTH 26
#define BUTTON_HEIGHT 25
#import "GoodsNumberView.h"

@implementation GoodsNumberView
-(UIButton *)btnDelete{
    
    if (!_btnDelete) {
        _btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
        _btnDelete.backgroundColor = [UIColor clearColor];
        
        [_btnDelete setImage:[UIImage imageNamed:@"bt_jian_normal"] forState:UIControlStateNormal];
//        [_btnDelete setImage:[UIImage imageNamed:@"bt_jian_cannotpress"] forState:UIControlStateSelected];
        [_btnDelete setImage:[UIImage imageNamed:@"bt_jian_pressed"] forState:UIControlStateHighlighted];
        [_btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDelete;
}
-(KeyboardNumberPadReturnTextField *)numberTF{
    
    if (!_numberTF)
    {                                                                               
        CGFloat origin_x = self.btnDelete.frame.size.width + self.btnDelete.frame.origin.x - 1.0f;
        _numberTF = [KeyboardNumberPadReturnTextField borderTextField];
        //_numberTF.backgroundColor = [UIColor grayColor];
        _numberTF.frame = CGRectMake(origin_x, 0, self.size.width - 2 * BUTTON_WIDTH,BUTTON_HEIGHT);
        _numberTF.textAlignment = NSTextAlignmentCenter;
        _numberTF.textColor = RGBCOLOR(102, 102, 102);
        [_numberTF setLeftViewMode: UITextFieldViewModeNever];
        _numberTF.font = [UIFont systemFontOfSize:13];
        _numberTF.clearButtonMode = UITextFieldViewModeNever;
        _numberTF.delegate = self;
        _numberTF.keyboardType = UIKeyboardTypeDecimalPad;
        _numberTF.returnKeyType = UIReturnKeyDone;
        _numberTF.backgroundColor = HEX_RGB(0xf5f5f5);
        
    }
    
    return _numberTF;
}

-(UIButton *)btnAdd{
    
    if (!_btnAdd)
    {
        CGFloat origin_x = self.numberTF.frame.size.width + self.numberTF.frame.origin.x - 1.0f;
        _btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(origin_x, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
        _btnAdd.backgroundColor = [UIColor clearColor];
        
        [_btnAdd setImage:[UIImage imageNamed:@"bt_jia_normal"] forState:UIControlStateNormal];
//        [_btnAdd setImage:[UIImage imageNamed:@"bt_jia_cannotpress"] forState:UIControlStateSelected];
        [_btnAdd setImage:[UIImage imageNamed:@"bt_jia_pressed"] forState:UIControlStateHighlighted];
        [_btnAdd addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnAdd;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0)
    {
        frame.size.width = GoodsNumberDefaultWidth;
    }
    if (frame.size.height == 0)
    {
        frame.size.height = GoodsNumberDefaultHeight;
    }
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.btnDelete];
        [self addSubview:self.numberTF];
        [self addSubview:self.btnAdd];
    }
    return self;
}


//-(void)didClickButtonDone:(NSNotification *)note{
//    [self.numberTF resignFirstResponder];
//}

-(instancetype)init{
    self = [self initWithFrame:CGRectMake(0, 0, 0, 0)];
    return self;
}

-(void)addAction:(UIButton *)sender{
    NSString *changedStr = self.numberTF.text;
    double num = [changedStr doubleValue]+1;
    
    if ([changedStr doubleValue] >= 0)
    {
        if (num > 1)
        {
            self.btnDelete.selected = NO;
        }
        if (num > self.max_num && self.max_num != 0)
        {
            self.btnAdd.selected = YES;
            return;
        }
    }
    self.numberTF.text = [NSString stringWithFormat:@"%@",[NSString formatDecimal:[changedStr doubleValue]+1 cnt:[[ParameterPublic sharedManagered] quantitative_accuracy]]];
    if ([self.numberTF.text doubleValue] >= self.max_num && self.max_num != 0)
    {
        self.btnAdd.selected = YES;
    }
    self.goods.number = self.numberTF.text;
    if ([self.goods getSelectOptions])
    {
        [self.goods getSelectOptions].number = self.goods.number;
    }
    if([self.delegate respondsToSelector: @selector(GoodsNumberView:changeNum:)])
        [self.delegate GoodsNumberView:self changeNum:self.numberTF.text];
}

-(void)deleteAction:(UIButton *)sender{
    NSString *changedStr = self.numberTF.text;
//    if ([self isAllNumber:changedStr]&& [changedStr integerValue] > (self.min_num == 0?self.goods.min_order:self.min_num))
//    {
//        self.numberTF.text = [NSString stringWithFormat:@"%ld",[changedStr integerValue]-1];
//        if ([self.numberTF.text integerValue] == (self.min_num == 0?self.goods.min_order:self.min_num))
//        {
//            self.btnDelete.enabled = NO;
//        }
//        if ([self.numberTF.text integerValue] < self.max_num && self.max_num != 0)
//        {
//            self.btnAdd.enabled = YES;
//        }
//    }
    if ([changedStr doubleValue] > 1)
    {
        self.numberTF.text = [NSString stringWithFormat:@"%@",[NSString formatDecimal:[changedStr doubleValue]-1 cnt:[[ParameterPublic sharedManagered] quantitative_accuracy]]];
    }
    self.goods.number = self.numberTF.text;
    if ([self.goods getSelectOptions])
    {
        [self.goods getSelectOptions].number = self.goods.number;
    }
    if([self.delegate respondsToSelector: @selector(GoodsNumberView:changeNum:)])
        [self.delegate GoodsNumberView:self changeNum:self.numberTF.text];
    if ([self.numberTF.text doubleValue] < self.max_num)
    {
        self.btnAdd.selected = NO;
    }
    if ([self.numberTF.text doubleValue] == 1)
    {
        self.btnDelete.selected = YES;
    }
}


//- (BOOL)isAllNumber:(NSString *)checkStr{
//    
//    NSString *ruleNumber = @"0123456789";
//    
//    for (int i=0; i<[checkStr length]; i++) {
//        BOOL isNumber = NO;
//        for (int j=0; j<10; j++) {
//            
//            if ([ [checkStr substringWithRange:NSMakeRange(i, 1)] isEqualToString:[ruleNumber substringWithRange:NSMakeRange(j, 1)]]) {
//                
//                isNumber = YES;
//                break;
//            }
//        }
//        if (NO == isNumber) {
//            
//            return isNumber;
//        }
//    }
//    return YES;
//}

-(void)setMax_num:(double)max_num{
    _max_num = max_num;
    if ([self.numberTF.text doubleValue] >= max_num)
    {
        self.btnAdd.selected = YES;
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    KeyboardManager.is_shwoCMview = YES;
    ///通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsNumberShouldBeginEditing" object: textField];
    ///委托
    if([_delegate respondsToSelector: @selector(GoodsNumberView_textFieldShouldBeginEditing:)]){
        [_delegate GoodsNumberView_textFieldShouldBeginEditing: textField];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (![string isEqualToString:@""])
    {
        ////        NSString *strFormat = @"[a-zA-Z0-9]{0,20}";
        NSString *strFormat = @"[0-9]";
        NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strFormat];
        if([string isEqualToString: @"."] && ![[textField text] containsString: @"."])return YES; ///只允许输入一个小数点
        if (![strPredicate evaluateWithObject:string]) return NO;//当不是数字的时候不允许输入
        //判断小数点前的位数不能超过7位,小数点后的位数不能超过系统配置位(注：此时需要判断当前输入的值是在小数点之前还是在小数点之后)
        NSArray *tmpArray = [[textField text] componentsSeparatedByString: @"."];
        BOOL isValidata = YES;
        if ([tmpArray count] <= 1)
        {
            //没有有小数点
            isValidata = [[tmpArray objectAtIndex: 0] length] < 7 ? YES : NO;
        }
        else
        {
            //有小数
            isValidata = [[tmpArray objectAtIndex: 0] length] <= 7 ? YES : NO;
            if([tmpArray count] > 1 && isValidata)
            {
//                NSLog(@"%@",[[ParameterPublic sharedManagered] quantitative_accuracy]);
                isValidata = [[tmpArray objectAtIndex: 1] length] < [[ParameterPublic sharedManagered] quantitative_accuracy] ? YES : NO;
            }
        }
        return isValidata;
    }
    else
    {
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.goods.number = self.numberTF.text;
    if ([self.goods getSelectOptions])
    {
        [self.goods getSelectOptions].number = self.goods.number;
    }
    if([self.delegate respondsToSelector: @selector(GoodsNumberView:changeNum:)])
        [self.delegate GoodsNumberView:self changeNum:self.numberTF.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.numberTF resignFirstResponder];
//    NSString *strFormat = @"[0-9]{0,20}";
//    NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strFormat];
//    if ([strPredicate evaluateWithObject:textField.text] != YES)
//    {
//        textField.text = [NSString stringWithFormat:@"%ld",(long)self.goods.min_order];
//    }
//    if ([textField.text doubleValue] < [self.goods.min_order doubleValue])
//    {
//        textField.text = [NSString stringWithFormat:@"%@",self.goods.min_order];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsNumberDidEndEditing" object:nil];
    self.goods.number = self.numberTF.text;
    if ([self.goods getSelectOptions])
    {
        [self.goods getSelectOptions].number = self.goods.number;
    }
    if([self.delegate respondsToSelector: @selector(GoodsNumberView:changeNum:)])
        [self.delegate GoodsNumberView:self changeNum:self.numberTF.text];
}


@end
