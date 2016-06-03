//
//  DHBGaryTextField.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/5.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGaryTextField.h"

@implementation DHBGaryTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = HEX_RGB(0xdcdcdc).CGColor;
        self.layer.cornerRadius = 2.5;
        self.tintColor = [UIColor TextRed_Color];
    }
    return self;
}


- (CGRect)textRectForBounds:(CGRect)bounds
{
    
    return CGRectInset(bounds, 5, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5, 0);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5, 0);
}

@end
