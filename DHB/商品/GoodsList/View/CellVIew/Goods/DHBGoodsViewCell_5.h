//
//  DHBGoodsViewCell_5.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/21.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBGoodsViewCell_2.h"
#import "DHBLabel.h"

@interface DHBGoodsViewCell_5 : UITableViewCell<GoodsNumberViewDelegate>
@property (strong, nonatomic) GoodsModuleDTO *product;
@property (strong, nonatomic)  UIView *main_v;
@property (strong, nonatomic)  UILabel *name_lb;
@property (strong, nonatomic)  DHBLabel *price_lb;
@property (strong, nonatomic)  UIButton *shoppingCar_btn;
@property (strong, nonatomic)  UIImageView *noAvailable_img;
@property (strong, nonatomic)UIView *units_vi;
@property (strong, nonatomic) GoodsNumberView *goodsNumber;
@property (strong, nonatomic)  UIView *goodsTypeView; ///显示goodsType

@property (nonatomic, weak) id <DHBGoodsViewCellDelegate> delegate;
- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto;
@end
