//
//  DHBCategoryTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN 15.0F
#define ARRORW_HEIGHT 22.0F
#define CELL_HEIGHT 55.0F
#import <UIKit/UIKit.h>

@interface DHBCategoryTableViewCell : UITableViewCell
@property (retain, nonatomic) UILabel *categoryName_lb;
@property (strong, nonatomic) UIView  *left_vi;
@property (nonatomic, retain) UIImageView *arrowImageView;

-(void)updateViewWithDTO:(CategoryModuleDTO*)catagory;
/**
 *  移动箭头
 *
 *  @param ismove 是否移动
 *  @param widht  子视图位置
 */
-(void)moveArrow:(BOOL)ismove childWidht:(CGFloat)widht;
////
//- (void)showArrowImageView;
//- (void)dismissArrowImageView;
//- (void)selectedCurrentCell:(UIColor *) selectedColor arrow_origin_x:(CGFloat) origin_x;
//- (void)notSelectedCurrentCell:(CGFloat) origin_x;
@end
