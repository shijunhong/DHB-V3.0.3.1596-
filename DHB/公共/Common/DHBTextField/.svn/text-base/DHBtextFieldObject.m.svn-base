//
//  DHBtextFieldObject.m
//  DHB
//
//  Created by 熊梓君 on 4/21/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBtextFieldObject.h"

@implementation DHBtextFieldObject
/////////////////////////////////////////////////////////
/**************Begin：textField delegate****************/
#pragma mark -
#pragma mark delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    KeyboardManager.is_shwoCMview = NO;
    if (textField.keyboardType == UIKeyboardTypeNumberPad || textField.keyboardType == UIKeyboardTypeDecimalPad ||textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation)
    {
        KeyboardManager.is_shwoCMview = YES;
    }
    if([_delegate respondsToSelector: @selector(DHBTextFieldShouldBeginEditing:)]){
        return [_delegate DHBTextFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [textField.layer setBorderColor: [UIColor TextRed_Color].CGColor];
    if([_delegate respondsToSelector: @selector(DHBTextFieldDidBeginEditing:)]){
        [_delegate DHBTextFieldDidBeginEditing: textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField.layer setBorderColor: [UIColor InputBorder_Color].CGColor];
    if([_delegate respondsToSelector: @selector(DHBTextFieldDidEndEditing:)]){
        [_delegate DHBTextFieldDidEndEditing: textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([_delegate respondsToSelector: @selector(DHBTextField:shouldChangeCharactersInRange:replacementString:)]){
        return [_delegate DHBTextField: textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    [self.cancelButton setSelected: NO];
    if([_delegate respondsToSelector: @selector(DHBTextFieldShouldReturn:)]){
        return [_delegate DHBTextFieldShouldReturn: textField];
    }
    return YES;
}
/**************End：textField delegate****************/
@end
