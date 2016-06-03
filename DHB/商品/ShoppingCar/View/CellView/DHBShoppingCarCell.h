//
//  DHBShoppingCarCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsNumberView.h"

@protocol DHBShoppingCarCellDelegate <DHBTableCellDelegate>
-(void)goodsNumberViewChanged:(GoodsNumberView*)goodsNumberView;
-(void)goodsDelete:(GoodsModuleDTO *)dto;
@optional
-(void)DHBShoppingCarCell_TextFieldBeginEditing:(GoodsModuleDTO *)dto;
@end

@interface DHBShoppingCarCell : UITableViewCell
@property(nonatomic,strong)UILabel *goodsCount_lb;//起订量，库存
@property (strong ,nonatomic)GoodsModuleDTO *goods;
@property (weak, nonatomic) id<DHBShoppingCarCellDelegate> delegate;

- (void)updateViewWithGoodsDTO:(GoodsModuleDTO *)dto;
@end
