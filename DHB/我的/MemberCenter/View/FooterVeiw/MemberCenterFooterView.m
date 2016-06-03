//
//  MemberCenterFooterView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#define BUTTON_MARGIN 15.0f
#import "MemberCenterFooterView.h"

@implementation MemberCenterFooterView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self initSectionViewTop_bottom:YES isHigth:15.0f];
        [self setBackgroundColor: [UIColor whiteColor]];
        [self addChangeAccountButton];
    }
    return self;
}

#pragma mark - 添加切换账号的按钮
- (void)addChangeAccountButton{
    if(!_changeAccountButton){
        _changeAccountButton = [[DHBButton alloc] initWithFrame: CGRectMake(BUTTON_MARGIN, BUTTON_MARGIN*2, self.frame.size.width - 2 * BUTTON_MARGIN, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue2];
        [_changeAccountButton setTitle: @"退出登录" forState: UIControlStateNormal];
        [_changeAccountButton addTarget: self action: @selector(cahngeAccountButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: _changeAccountButton];
}

- (void)cahngeAccountButtonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(footerView_DidChangeAccountButtonClick:)]){
        [_delegate footerView_DidChangeAccountButtonClick: sender];
    }
}
@end
