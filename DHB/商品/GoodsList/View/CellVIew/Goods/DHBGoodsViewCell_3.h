//
//  DHBGoodsViewCell_3.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModuleDTO.h"
#import "GoodsNumberView.h"
#import "DHBGoodsViewCell_2.h"

@interface DHBGoodsViewCell_3 : UITableViewCell
@property (strong, nonatomic) GoodsModuleDTO *product;
@property (strong, nonatomic)  UIView *main_v;
@property (strong, nonatomic)  UILabel *name_lb;
@property (strong, nonatomic)  UIView *goodsTypeView; ///显示goodsType
@property (strong, nonatomic)  UILabel *sku_lb; //规格
@property (strong, nonatomic)  TTTAttributedLabel *price_lb;
@property (strong, nonatomic)  UIButton *shoppingCar_btn;
@property (strong, nonatomic)  UIImageView *noAvailable_img;
@property (nonatomic, weak) id <DHBGoodsViewCellDelegate> delegate;

- (void)updateViewWithProductDTO:(GoodsModuleDTO *)dto;
@end
