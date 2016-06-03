//
//  DHBAboutTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_TOP 55.0F
#define LABEL_HEIGHT 20.0F
#define IMAGE_HEIGHT 228.0F
#import "DHBAboutTableViewCell.h"

@implementation DHBAboutTableViewCell

#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    _floorDTO = dto;
    //移除旧的视图
    NSArray *viewArray = [self subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
}

#pragma mark -
#pragma mark 样式1（订货宝二维码）
- (void)addFloor_1{
//    //标题
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, MARGIN_TOP, SCREEN_WIDTH, LABEL_HEIGHT)];
//    [titleLabel setTextColor: [UIColor TextBlack_Color]];
//    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
//    [titleLabel setText: [_floorDTO floorName]];
//    [titleLabel setTextAlignment: NSTextAlignmentCenter];
//    [self addSubview: titleLabel];
//    //版本
//    CGFloat origin_y = titleLabel.frame.size.height + titleLabel.frame.origin.y;
//    UILabel *versionLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y,SCREEN_WIDTH, LABEL_HEIGHT)];
//    [versionLabel setTextColor: [UIColor TextGray_Color]];
//    [versionLabel setFont: [UIFont systemFontOfSize: 12.0f]];
//    [versionLabel setTextAlignment: NSTextAlignmentCenter];
//    [versionLabel setText: @"For iOS V3.0.0"];
//    [self addSubview: versionLabel];
    //二维码图片
//    origin_y = versionLabel.frame.size.height + versionLabel.frame.origin.y;
    UIImageView *qrImageView = [[UIImageView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - IMAGE_HEIGHT) / 2.0f, MARGIN_TOP, IMAGE_HEIGHT, IMAGE_HEIGHT)];
    [qrImageView setContentMode: UIViewContentModeScaleAspectFit];
    [qrImageView setBackgroundColor: [UIColor redColor]];
    [qrImageView setImage:[UIImage imageNamed:@"code"]];
    [self addSubview: qrImageView];
    //提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, qrImageView.bottom+25,  SCREEN_WIDTH, LABEL_HEIGHT)];
    [tipLabel setTextColor: [UIColor TextGray_Color]];
    [tipLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [tipLabel setText: @"邀请好友扫描二维码，直接下载安装"];
    [tipLabel setTextAlignment: NSTextAlignmentCenter];
    [self addSubview: tipLabel];
    [self setAccessoryType: UITableViewCellAccessoryNone];
    [self setBackgroundColor:[UIColor UIViewBackGroundColor]];
}

#pragma mark -
#pragma mark 样式2（标准通用视图）
- (void)addFloor_2{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10.0f, 0.0f, SCREEN_WIDTH / 2.0f, _floorDTO.hight)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: [_floorDTO floorName]];
    [self addSubview: titleLabel];
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
}
@end
