//
//  DHBtextFieldObject.h
//  DHB
//
//  Created by 熊梓君 on 4/21/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHBTextField_Delegate <NSObject>
@optional
- (BOOL)DHBTextFieldShouldBeginEditing:(UITextField *)textField;
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField;
- (void)DHBTextFieldDidEndEditing:(UITextField *)textField;
- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)DHBTextFieldShouldReturn:(UITextField *)textField;
@end


@interface DHBtextFieldObject : NSObject<UITextFieldDelegate>
@property(nonatomic, strong) id<DHBTextField_Delegate> delegate;
@end
