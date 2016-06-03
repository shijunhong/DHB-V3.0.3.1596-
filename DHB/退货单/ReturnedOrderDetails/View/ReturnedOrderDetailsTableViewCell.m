//
//  ReturnedOrderDetailsTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0F
#define BASE_LABEL_HEIGHT 25.0F
#define ARROW_WIDTHANDHEIGHT 20.0F

#import "ReturnedOrderDetailsTableViewCell.h"

@implementation ReturnedOrderDetailsTableViewCell

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        [_arrowImageView setContentMode: UIViewContentModeScaleAspectFit];
        [_arrowImageView setImage: [UIImage imageNamed: @"ic_xuanze_normal.png"]];
    }
    return _arrowImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
    }
    return self;
}

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    if (_floorDTO != dto)
    {
        _floorDTO = dto;
    }
    //移除旧的视图
//    NSArray *viewArray = [self.contentView subviews];
//    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.contentView.backgroundColor = [UIColor whiteColor];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        objc_msgSend(self, selectorMethod);
    }
}

#pragma mark - 退货状态
- (void)addFloor_1{
    OrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *mainView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, _floorDTO.hight)];
    [mainView setBackgroundColor: [_floorDTO color]];
    //标题
    [self.titleLabel setFrame: CGRectMake(MARGIN_LEFT, 0.0f, self.size.width / 2.0F, BASE_LABEL_HEIGHT)];
    [mainView addSubview: self.titleLabel];
    //状态
    CGFloat origin_x = self.titleLabel.frame.size.width + self.frame.origin.x;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, self.size.width - origin_x - ARROW_WIDTHANDHEIGHT - 2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [statusLabel setTextColor: [UIColor TextGray_Color]];
    [statusLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [mainView addSubview: statusLabel];
    //箭头
    origin_x = statusLabel.frame.size.width + statusLabel.frame.origin.x + MARGIN_LEFT;
    [self.arrowImageView setFrame: CGRectMake(origin_x, (BASE_LABEL_HEIGHT - ARROW_WIDTHANDHEIGHT) / 2.0f, ARROW_WIDTHANDHEIGHT, ARROW_WIDTHANDHEIGHT)];
    [mainView addSubview: self.arrowImageView];
    //运单号
    CGFloat origin_y = self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y;
    UILabel *orderIDLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [orderIDLabel setTextColor: [UIColor TextGray_Color]];
    [orderIDLabel setText: [NSString stringWithFormat: @"退单号：%@", [order orders_num]]];
    [orderIDLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [mainView addSubview: orderIDLabel];
    //下单时间
    origin_y = orderIDLabel.frame.size.height + orderIDLabel.frame.origin.y;
    UILabel *orderTimeLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, origin_y, self.size.width - 2 * MARGIN_LEFT, BASE_LABEL_HEIGHT)];
    [orderTimeLabel setTextColor: [UIColor TextGray_Color]];
    [orderTimeLabel setText: [NSString stringWithFormat: @"下单时间：%@", [order create_date]]];
    [orderTimeLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [mainView addSubview: orderTimeLabel];
}
@end
