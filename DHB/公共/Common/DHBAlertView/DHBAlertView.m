//
//  DHBAlertView.m
//  DHB
//  消息提示单例视图（避免重复显示提示视图而编写的一个单例类）
//  Created by 阿商信息技术有限公司 on 3/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAlertView.h"
#import <objc/runtime.h>
#define WidthPadding 45.0f
#define Hight 120.0f

@implementation DHBAlertView
static UILabel *messageLabel;
+(DHBAlertView *)sharedManagered
{
    static DHBAlertView *alertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[DHBAlertView alloc] init];
        [alertView  setUseMotionEffects:true];
        //添加按钮
        UIView *contentView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0, SCREEN_WIDTH- WidthPadding * 2 * Multiple, Hight * Multiple)];
        [alertView setContainerView: contentView];
        ///label
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0, contentView.width - 30.0f, contentView.height)];
        [messageLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [messageLabel setTextAlignment: NSTextAlignmentCenter];
        [messageLabel setNumberOfLines: 0];
        [messageLabel setLineBreakMode: NSLineBreakByCharWrapping];
        [contentView addSubview: messageLabel];
    });
    return alertView;
}

#pragma mark 显示指定消息
- (void)showMessage:(NSString *) message{
    if(!self.isShow)
    {
        self.isShow = YES;
        [self setButtonTitles:[NSMutableArray arrayWithObjects: @{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
        [super show];
        [messageLabel setText: message];
    }
}

#pragma mark 关闭提示视图
- (void)close{
    [super close];
    self.isShow = NO;
    [[DHBAlertView sharedManagered] setOnButtonTouchUpInside: nil];
}

-(id)init{
    self = [super init];
    if (self)
    {
        [self setUseMotionEffects:YES];
        UIView *contentView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0, SCREEN_WIDTH- WidthPadding * 2 * Multiple, Hight * Multiple)];
        [self setContainerView: contentView];
        self.lable = [[UILabel alloc] init];
        [self.lable setFont: [UIFont systemFontOfSize: 15.0f]];
        [self.lable setTextAlignment: NSTextAlignmentCenter];
        [self.lable setNumberOfLines: 0];
        [self.lable setLineBreakMode: NSLineBreakByCharWrapping];
        [contentView addSubview: self.lable];
        self.lable.sd_layout.topSpaceToView(contentView,15.0f).leftSpaceToView(contentView,15.0f).rightSpaceToView(contentView,15.0f).autoHeightRatio(0);
    }
    return self;
}

@end
