//
//  DHBAboutBottomView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define LABEL_HEIGHT 20.0f
#import "DHBAboutBottomView.h"

@implementation DHBAboutBottomView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addCopyrightLabel];
        [self addCorporateLabel];
    }
    return self;
}

- (void)addCopyrightLabel{
    if(!_copyrightLabel){
        _copyrightLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, LABEL_HEIGHT)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"yyyy"];
        [_copyrightLabel setText: [NSString stringWithFormat: @"Copyright © 2005-%@", [formatter stringFromDate: [NSDate date]]]];
        [_copyrightLabel setFont: [UIFont systemFontOfSize: 12.0f]];
        [_copyrightLabel setTextAlignment: NSTextAlignmentCenter];
        [_copyrightLabel setTextColor: [UIColor grayColor]];
    }
    [self addSubview: _copyrightLabel];
}

- (void)addCorporateLabel{
    if(!_corporateLabel){
        CGFloat origin_y = _copyrightLabel.frame.size.height + _copyrightLabel.frame.origin.y;
        _corporateLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, LABEL_HEIGHT)];
        [_corporateLabel setText: @"成都阿商信息技术有限公司 版权所有"];
        [_corporateLabel setFont: [UIFont systemFontOfSize: 12.0f]];
        [_corporateLabel setTextAlignment: NSTextAlignmentCenter];
        [_corporateLabel setTextColor: [UIColor grayColor]];
    }
    [self addSubview: _corporateLabel];
}

#pragma mark - 更新视图数据
- (void)updateViewWithDTO:(DHBAboutModuleDTO *)dto{
    if([[dto copyright] length] > 0)
        [_copyrightLabel setText: [dto copyright]];
    if([[dto company] length] > 0)
        [_corporateLabel setText: [dto company]];
}
@end
