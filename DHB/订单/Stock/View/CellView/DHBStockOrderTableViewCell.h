//
//  DHBStockOrderTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModuleDTO.h"

@interface DHBStockOrderTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *icon_iv;
@property (strong, nonatomic)  UILabel *name_lb;
@property (strong, nonatomic)  UILabel *type_lb;

- (void)updateViewWithDTO:(ShipsModuleDTO *)ships;

@end
