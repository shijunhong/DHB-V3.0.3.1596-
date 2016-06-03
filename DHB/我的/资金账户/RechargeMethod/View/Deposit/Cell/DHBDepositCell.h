//
//  DHBDepositCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBDepositCell : UITableViewCell
@property(nonatomic,strong)UILabel *name_lb;
@property(nonatomic,strong)TTTAttributedLabel *value_lb;
@property(nonatomic,strong)UIView *bottom_l;
- (void)updateViewWithData:(NSDictionary *)dto;
@end
