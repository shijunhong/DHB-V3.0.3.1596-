//
//  HDBReturnedDetailsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "DHBReturnsOrderModuleDTO.h"

@interface DHBReturnedDetailsTableViewCell : UITableViewCell
@property(nonatomic, strong) HomeFloorDTO *floorDTO;

/*（标准通用视图）*/
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subContentLabel;
@property(nonatomic, strong) UIImageView *arrowImageView;

/*样式1*/
@property(nonatomic, strong) UILabel *orderIDLabel;
@property(nonatomic, strong) UILabel *orderTimeLabel;

/*样式5*/
@property(nonatomic, strong) UILabel *contentLabel;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
