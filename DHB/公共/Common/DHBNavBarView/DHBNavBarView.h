//
//  DHBNavBarView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/7.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBNavBarView : UIView
@property(strong,nonatomic)UILabel *center_lb;//居中label
@property(strong, nonatomic)UILabel *left_lb;//居左label
@property(strong, nonatomic)UIButton *back_btn;//返回
@property(strong, nonatomic)UIButton *shoppingCar_btn;//购物车
@property(strong, nonatomic)UIImageView *shoppingCar_img;//购物车图片

@property(nonatomic, strong) UITapGestureRecognizer *left_tap;//左边label 点击手势
@end
