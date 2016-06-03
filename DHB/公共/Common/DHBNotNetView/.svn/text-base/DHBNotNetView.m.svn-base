//
//  DHBNotNetView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/25/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define VIEW_HEIGHT 60.0f
#import "DHBNotNetView.h"

@implementation DHBNotNetView
+(DHBNotNetView *)sharedManagered{
    static DHBNotNetView *notNetView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notNetView = [[DHBNotNetView alloc] initWithFrame: CGRectMake(0.0f, Titel_HEIGHT, SCREEN_WIDTH, VIEW_HEIGHT)];
        [notNetView setBackgroundColor: HEX_RGB(0xfedfdf)];
        [notNetView setAlpha: 0.9f];
        UILabel *tiplabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, VIEW_HEIGHT)];
        [tiplabel setText: @"网络未连接，请检查您的网络"];
        [tiplabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [tiplabel setTextAlignment: NSTextAlignmentCenter];
        [tiplabel setTextColor: HEX_RGB(0x6f6e62)];
        [notNetView addSubview: tiplabel];
    });
    return notNetView;
}

- (void)show{
    [self setHidden: NO];
    [[[UIApplication sharedApplication] keyWindow] addSubview: self];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront: self];
}

- (void)dismiss{
    [self setHidden: YES];
}
@end
