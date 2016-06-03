//
//  DHBNoDataView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BASE_WIDTH 180.0F
#define BASE_HEIGHT 200.0f
#import "DHBNoDataView.h"

@implementation DHBNoDataView
static UILabel *messageLabel;
static  UIImageView *tipImageView;
+(DHBNoDataView *)sharedManagered{
    static DHBNoDataView *noDataView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noDataView = [[DHBNoDataView alloc] init];
        [noDataView setSize: CGSizeMake(BASE_WIDTH, BASE_HEIGHT)];
        ///
        tipImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, BASE_WIDTH - 30.0f, BASE_HEIGHT - 45.0f)];
        [tipImageView setImage: [UIImage imageNamed: @"fail"]];
        [tipImageView setContentMode: UIViewContentModeScaleAspectFit];
        [noDataView addSubview: tipImageView];
        ///
        messageLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, tipImageView.bottom + 22.0f, SCREEN_WIDTH, 20.0f)];
        [messageLabel setTextAlignment: NSTextAlignmentCenter];
        [messageLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [messageLabel setTextColor: [UIColor TextGray_Color]];
        [noDataView addSubview: messageLabel];
    });
    return noDataView;
}

#pragma mark - 在指定的父视图中显示提示消息[有提示图片]
- (void)showInParentView:(UIView *) parentView message:(NSString *) message{
    [self setSize: CGSizeMake(SCREEN_WIDTH, (parentView.height / 2.0f < BASE_HEIGHT ? parentView.height / 2.0f : BASE_HEIGHT))];
    [tipImageView setSize: CGSizeMake(self.width, self.height - 45.0f)];
    [messageLabel setTop: tipImageView.bottom];
    [messageLabel setSize: CGSizeMake(self.width, 45.0f)];
    [self setCenter: CGPointMake(parentView.width / 2.0f, parentView.height / 2.5f)];
    [messageLabel setText: message];
    [parentView addSubview: self];
    WS(weakSelf);
    [UIView animateWithDuration: 0.3f animations: ^{
        [weakSelf setAlpha: 1.0f];
    }];
}

#pragma mark - 在指定的父视图中显示提示消息[没有提示图片]
- (void)showMessageInParentView:(UIView *) parentView message:(NSString *) message{
    [tipImageView setSize: CGSizeMake(0.0f, 0.0f)];
    [self setWidth: SCREEN_WIDTH];
    [self setTop: 0.0f];
    [self setLeft: 0.0f];
    [messageLabel setWidth: self.width];
    [messageLabel setTop: self.height / 2.0f];
    [messageLabel setText: message];
    [parentView addSubview: self];
    WS(weakSelf);
    [UIView animateWithDuration: 0.3f animations: ^{
        [weakSelf setAlpha: 1.0f];
    }];
}

#pragma mark - 隐藏视图
- (void)dismiss{
    WS(weakSelf);
    [UIView animateWithDuration: 0.3f animations: ^{
        [weakSelf setAlpha: 0.0f];
    }];
}
@end
