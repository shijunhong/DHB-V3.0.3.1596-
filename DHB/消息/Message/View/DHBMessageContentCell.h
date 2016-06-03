//
//  DHBMessageContentCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBMessageContentCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *head_img;
@property (strong, nonatomic)  UILabel *time_lb;
@property (strong, nonatomic)  TTTAttributedLabel *content_lb;
- (void)updateViewWithMessageDTO:(NSDictionary *)msg;
@end
