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
#import "DHBAboutModuleDTO.h"

@implementation DHBAboutTableViewCell

#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    _floorDTO = dto;
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
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
    DHBAboutModuleDTO *dto = [_floorDTO.moduleList firstObject];
    EGOImageViewEx *qrImageView = [[EGOImageViewEx alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - IMAGE_HEIGHT) / 2.0f, MARGIN_TOP, IMAGE_HEIGHT, IMAGE_HEIGHT)];
    [qrImageView setContentMode: UIViewContentModeScaleAspectFit];
    [qrImageView setPlaceholderImage: [UIImage imageNamed:@"invalid"]];
    if(dto)
        [qrImageView setImageURL: [NSURL URLWithString: [dto qr_code_url]]];
    [self.contentView addSubview: qrImageView];
    //提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, qrImageView.bottom+25,  SCREEN_WIDTH, LABEL_HEIGHT)];
    [tipLabel setTextColor: [UIColor TextGray_Color]];
    [tipLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [tipLabel setText: @"邀请好友扫描二维码，直接下载安装"];
    [tipLabel setTextAlignment: NSTextAlignmentCenter];
    [self.contentView addSubview: tipLabel];
    [self setAccessoryType: UITableViewCellAccessoryNone];
    [self setBackgroundColor:[UIColor UIViewBackGroundColor]];
}

#pragma mark -
#pragma mark 样式2（标准通用视图）
- (void)addFloor_2{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(15.0f, 0.0f, SCREEN_WIDTH / 2.0f, _floorDTO.hight)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: [_floorDTO floorName]];
    [self.contentView addSubview: titleLabel];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    [valueLabel setTextColor: [UIColor TextBlack_Color]];
    [valueLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [self.contentView addSubview:valueLabel];
    if (_floorDTO.moduleList)
    {
        [valueLabel setText:[_floorDTO.moduleList firstObject]];
    }
    valueLabel.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView,15.0f).heightIs(self.contentView.height);
    [valueLabel setSingleLineAutoResizeWithMaxWidth:self.contentView.width];
    if ([[_floorDTO floorName] isEqualToString:@"当前版本"])
    {
        [self setAccessoryType: UITableViewCellAccessoryNone];
    }
    else
    {
        [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
}
@end
