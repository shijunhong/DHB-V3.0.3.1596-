//
//  DHBOrderAlertView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderAlertView.h"


@implementation DHBOrderAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self)
    {
        _titel_lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*Multiple, self.width, 15)];
        _titel_lb.font = [UIFont systemFontOfSize:15];
        _titel_lb.textColor = [UIColor TextBlack_Color];
        [_titel_lb setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titel_lb];
        
        _textView = [[DHBTextView alloc] initWithFrame:CGRectMake(20, _titel_lb.bottom+20*Multiple, self.width-40, 147*Multiple)];
        _textView.layer.borderColor = HEX_RGB(0x757575).CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.cornerRadius = 2.5;
        _textView.delegate = self;
        [self addSubview:_textView];
        
        _cntnum_lb = [[UILabel alloc] initWithFrame:CGRectMake(_textView.right-100, _textView.bottom+5*Multiple, 100, 15)];
        _cntnum_lb.font = [UIFont systemFontOfSize:11];
        _cntnum_lb.textColor = [UIColor TextGray_Color];
        [_cntnum_lb setTextAlignment:NSTextAlignmentRight];
        _cntnum_lb.text = @"0/50";
        [self addSubview:_cntnum_lb];
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location >= 50) return NO; //只能输入是50位以内
    return YES;
}

@end
