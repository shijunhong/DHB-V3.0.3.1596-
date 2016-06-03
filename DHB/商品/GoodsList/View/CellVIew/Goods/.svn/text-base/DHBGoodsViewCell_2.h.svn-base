//
//  DHBProductViewCell_2.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModuleDTO.h"
#import "GoodsNumberView.h"

@protocol DHBGoodsViewCellDelegate <DHBTableCellDelegate>
@optional
- (void) DHBGoodsViewCell:(UITableViewCell *)cell didTouchShoppingCar:(UIButton*)sender GoodsModule:(GoodsModuleDTO*)goods;
- (void) DHBGoodsViewCell_didSelectRow:(UITableViewCell *)cell;
@end

@interface DHBGoodsViewCell_2 : UITableViewCell<EGOImageViewDelegate>
@property (strong, nonatomic)  GoodsModuleDTO *product;
@property (strong, nonatomic)  UIView *bottomImageView;
@property (strong, nonatomic)  UIView *topImageView;
@property (strong, nonatomic)  UIView *main_v;
@property (strong, nonatomic)  EGOImageViewEx *image_vi;
@property (strong, nonatomic)  UILabel *name_lb;
@property (strong, nonatomic)  UILabel *num_lb;
@property (strong, nonatomic)  TTTAttributedLabel *options_lb;
@property (strong, nonatomic)  TTTAttributedLabel *price_lb;
@property (strong, nonatomic)  UIButton *shoppingCar_btn;
@property (strong, nonatomic)  UIImageView *noAvailable_img;

@property (strong, nonatomic)  UIView *goodsTypeView; ///显示goodsType
@property (strong, nonatomic)  UIImageView *goodsTypeShadowView; ///goodsType的阴影图标

@property (nonatomic, weak) id <DHBGoodsViewCellDelegate> delegate;

- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto;
- (void)showShoppingCarButton:(BOOL) isShow;
@end
