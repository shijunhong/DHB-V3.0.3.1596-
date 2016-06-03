//
//  DHBReturnedGoodsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModuleDTO.h"
#import "GoodsModuleDTO.h"
#import "GoodsNumberView.h"

@class DHBReturnedGoodsTableViewCell;
@protocol DHBReturnedGoodsTableViewCellDelegate <DHBTableCellDelegate>
-(void)DHBReturnedGoodsTableViewCell:(DHBReturnedGoodsTableViewCell*)cell is_select:(OrdersgoodsModuleDTO*)ordersgoods;
@end

@interface DHBReturnedGoodsTableViewCell : UITableViewCell<GoodsNumberViewDelegate>
@property (strong,nonatomic) EGOImageViewEx *image_vi;
@property (strong,nonatomic) UILabel *num_lb;
@property (strong,nonatomic) UILabel *name_lb;
@property (strong,nonatomic) TTTAttributedLabel *price_lb;
@property (strong,nonatomic) UIButton *select_btn;
@property (strong,nonatomic) UILabel *units_lb;
@property (strong,nonatomic) GoodsNumberView *goodnum_vi;
@property (strong,nonatomic) UILabel *returnnum_lb;
@property (strong,nonatomic) UIView *middle_line;
@property (strong,nonatomic) UIView *bottomView;
@property(nonatomic,strong) OrdersgoodsModuleDTO *ordersgoods;
@property(weak,nonatomic) id<DHBReturnedGoodsTableViewCellDelegate>delegate;
- (void)updateViewWithGoods:(OrdersgoodsModuleDTO*)ordersgoods;
@end
