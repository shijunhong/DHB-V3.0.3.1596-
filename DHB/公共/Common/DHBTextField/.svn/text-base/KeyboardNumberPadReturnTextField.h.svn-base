//
//  KeyboardNumberPadReturnTextField.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/5.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTextField.h"
@protocol KeyboardDoneTappedDelegate <NSObject>

@optional
- (void)doneTapped:(id)sender;

@end

@interface KeyboardNumberPadReturnTextField : DHBTextField{
    UIButton *_doneButton;
    
    id <KeyboardDoneTappedDelegate> __weak _doneButtonDelegate;
}

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, weak) id <KeyboardDoneTappedDelegate> doneButtonDelegate;
@end
