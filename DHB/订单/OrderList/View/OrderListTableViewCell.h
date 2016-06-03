//
//  OrderListTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModuleDTO.h"
@class OrderListTableViewCell;
@protocol OrderListTableViewCellDelegate <NSObject>

-(void)OrderListTableViewCell:(OrderListTableViewCell*)cell withOrder:(OrderModuleDTO*)order;

@end

@interface OrderListTableViewCell : UITableViewCell
@property(weak,nonatomic)id<OrderListTableViewCellDelegate>delegate;

@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *cutLine;
@property (strong, nonatomic) UIView *bottom_vi;
@property (strong, nonatomic) UIImageView *orderStatus_img;
@property (strong, nonatomic) UILabel *orderNum_lb;
@property (strong, nonatomic) UILabel *orderStatus_lb;
@property (strong, nonatomic) UILabel *orderPrice_lb;
@property (strong, nonatomic) UILabel *goodsNum_lb;
@property (strong, nonatomic) UILabel *orderDate_lb;
@property (strong, nonatomic) DHBButton *pay_btn;

@property(nonatomic, strong)OrderModuleDTO *order;

- (void)updateViewWithOrderDTO:(OrderModuleDTO *)dto;

@end
