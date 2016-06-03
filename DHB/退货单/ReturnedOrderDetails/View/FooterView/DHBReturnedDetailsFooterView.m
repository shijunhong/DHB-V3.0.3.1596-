//
//  DHBReturnedDetailsFooterView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#import "DHBReturnedDetailsFooterView.h"

@implementation DHBReturnedDetailsFooterView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setHidden: YES];
        [self addSubview:self.cancelButton];
        [self addSubview:self.leaveMessageButton];
    }
    return self;
}

#pragma mark - 取消按钮
- (UIButton*)cancelButton{
    if(!_cancelButton){
        _cancelButton = [[DHBButton alloc] initWithFrame: CGRectZero style: kDHBButton_StyleValue2];
        [_cancelButton addTarget: self action: @selector(cancelBUttonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_cancelButton setTitle: @"取消退货" forState: UIControlStateNormal];
    }
    return _cancelButton;
}

#pragma mark _ 确定按钮
- (UIButton *)leaveMessageButton{
    if(!_leaveMessageButton){
        _leaveMessageButton = [[DHBButton alloc]  initWithFrame: CGRectZero style: kDHBButton_StyleValue4];
        [_leaveMessageButton addTarget: self action: @selector(leaveMessageButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_leaveMessageButton setTitle: @"留言" forState: UIControlStateNormal];
    }
    return _leaveMessageButton;
}

#pragma mark - 取消按钮点击事件
- (void)cancelBUttonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(returnedDetailsFooterView_DidCancelButtonClick:)]){
        [_delegate returnedDetailsFooterView_DidCancelButtonClick: sender];
    }
}

#pragma mark - 确认事件
- (void)leaveMessageButtonClick:(UIButton *)sender{
    if([_delegate respondsToSelector: @selector(returnedDetailsFooterView_DidLeaveMessageButtonClick:)]){
        [_delegate returnedDetailsFooterView_DidLeaveMessageButtonClick: sender];
    }
}

#pragma mark - 更新视图
- (void)updateViewWithDTO:(DHBReturnsOrderModuleDTO *) dto{
    ////根据dto 判断footer的样式
    [self setHidden: NO];
    [self updateLayout];
    //顶部视图
    CGFloat section_higth = 15.0f;
    [self initSectionViewTop_bottom:YES isHigth:section_higth];
    
    CGFloat btn_width = (SCREEN_WIDTH-(15.0f*2+15.0f))/2.0f;
    if([[dto status] isEqualToString: @"待审核"])
    {
        [self.cancelButton setHidden:NO];
        [self.cancelButton setTitle: @"取消退货" forState: UIControlStateNormal];
        self.leaveMessageButton.sd_layout.bottomSpaceToView(self,MARGIN_LEFT).rightSpaceToView(self,MARGIN_LEFT).widthIs(btn_width).topSpaceToView(self,MARGIN_LEFT+section_higth);
        self.cancelButton.sd_layout.topEqualToView(self.leaveMessageButton).leftSpaceToView(self,MARGIN_LEFT).rightSpaceToView(self.leaveMessageButton,15.0f).bottomSpaceToView(self,MARGIN_LEFT);
    }
    else if([[dto status] isEqualToString: @"待发货"])
    {
        [self.cancelButton setHidden:NO];
        [self.cancelButton setTitle: @"确认发货" forState: UIControlStateNormal];
        self.leaveMessageButton.sd_layout.bottomSpaceToView(self,MARGIN_LEFT).rightSpaceToView(self,MARGIN_LEFT).widthIs(btn_width).topSpaceToView(self,MARGIN_LEFT+section_higth);
        self.cancelButton.sd_layout.topEqualToView(self.leaveMessageButton).leftSpaceToView(self,MARGIN_LEFT).rightSpaceToView(self.leaveMessageButton,15.0f).bottomSpaceToView(self,MARGIN_LEFT);
    }
    else
    {
        [self.cancelButton setHidden:YES];
        self.leaveMessageButton.sd_layout.bottomSpaceToView(self,MARGIN_LEFT).rightSpaceToView(self,MARGIN_LEFT).leftSpaceToView(self,MARGIN_LEFT).topSpaceToView(self,MARGIN_LEFT+section_higth);
    }
}
@end
