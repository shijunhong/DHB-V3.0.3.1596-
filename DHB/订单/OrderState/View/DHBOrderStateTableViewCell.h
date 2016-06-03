//
//  DHBOrderStateTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBOrderStateTableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *name_lb;
@property (strong, nonatomic)  UILabel *time_lb;
@property (strong, nonatomic)  UIView *circle_vi;
@property (strong, nonatomic)  UIView *line_vi;
- (void)updateViewWithDTO:(NSDictionary *)dto;
@end
