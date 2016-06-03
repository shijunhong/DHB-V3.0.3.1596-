//
//  DHBStockTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModuleDTO.h"
@class DHBStockTableViewCell;
@protocol DHBStockTableViewCellDelegate <NSObject>

-(void)DHBStockTableViewCell:(DHBStockTableViewCell*)stockTableViewCell clickLogisticsAction:(ShipsChildModuleDTO*)ships;

-(void)DHBStockTableViewCell:(DHBStockTableViewCell*)stockTableViewCell clickSureAction:(ShipsChildModuleDTO*)ships;

@end

@interface DHBStockTableViewCell : UITableViewCell<UIAlertViewDelegate>
@property(weak,nonatomic)id<DHBStockTableViewCellDelegate> delegate;

@property (strong, nonatomic) UIImageView *icon_vi;
@property (strong, nonatomic) UILabel *num_lb;
@property (strong, nonatomic) UILabel *type_lb;
@property (strong, nonatomic) UILabel *goodsNum_lb;
@property (strong, nonatomic) DHBButton *details_btn;
@property (strong, nonatomic) DHBButton *sure_btn;

@property (nonatomic,strong) ShipsChildModuleDTO *ships;
- (void)updateViewWithDTO:(ShipsChildModuleDTO *)ships;

@end
