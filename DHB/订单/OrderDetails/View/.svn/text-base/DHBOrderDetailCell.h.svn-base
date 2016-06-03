//
//  DHBOrderDetailCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
@class DHBOrderDetailCell;
@protocol DHBOrderDetailCellDelegate <NSObject>
-(void)DHBOrderDetailCell:(DHBOrderDetailCell*)orderDetailCell tuihuoActionBtn:(UIButton*)sender withHomeFloorDTO:(HomeFloorDTO*)floorDTO;
-(void)DHBOrderDetailCell:(DHBOrderDetailCell*)orderDetailCell cancelActionBtn:(UIButton*)sender withHomeFloorDTO:(HomeFloorDTO*)floorDTO;
-(void)DHBOrderDetailCell:(DHBOrderDetailCell*)orderDetailCell msgActionBtn:(UIButton*)sender withHomeFloorDTO:(HomeFloorDTO*)floorDTO;
-(void)DHBOrderDetailCell:(DHBOrderDetailCell*)orderDetailCell payActionBtn:(UIButton*)sender withHomeFloorDTO:(HomeFloorDTO*)floorDTO;
-(void)DHBOrderDetailCell:(DHBOrderDetailCell*)orderDetailCell stockActionBtn:(UIButton*)sender withHomeFloorDTO:(HomeFloorDTO*)floorDTO;
@end

@interface DHBOrderDetailCell : UITableViewCell

@property(nonatomic,weak)id<DHBOrderDetailCellDelegate> delegate;
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;

/*
 * cell_1
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell1_img;
@property (weak, nonatomic) IBOutlet UILabel *name_cell1_lb;
@property (weak, nonatomic) IBOutlet UILabel *type_cell1_lb;
@property (weak, nonatomic) IBOutlet UILabel *label1_cell1_lb;
@property (weak, nonatomic) IBOutlet UILabel *label2_cell1_lb;


/*
 * cell_2
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell2_img;
@property (weak, nonatomic) IBOutlet UILabel *name_cell2_lb;
@property (weak, nonatomic) IBOutlet UILabel *type_cell2_lb;

/*
 * cell_3
 */

@property (weak, nonatomic) IBOutlet UIImageView *image_cell3_img;
@property (weak, nonatomic) IBOutlet UILabel *remark_cell3_lb;
@property (weak, nonatomic) IBOutlet UILabel *name_cell3_lb;


/*
 * cell_4
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell4_img;
@property (weak, nonatomic) IBOutlet UILabel *price_cell4_lb;

/*
 * cell_5
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell5_img;
@property (weak, nonatomic) IBOutlet UILabel *type_cell5_lb;
@property (weak, nonatomic) IBOutlet UILabel *label1_cell5_lb;
@property (weak, nonatomic) IBOutlet UILabel *label2_cell5_lb;

/*
 * cell_6
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell6_img;
@property (weak, nonatomic) IBOutlet UILabel *label1_cell6_lb;
@property (weak, nonatomic) IBOutlet UILabel *label2_cell6_lb;

/*
 * cell_7
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell7_img;
@property (weak, nonatomic) IBOutlet UILabel *name_cell7_lb;
@property (weak, nonatomic) IBOutlet UILabel *type_cell7_lb;

/*
 * cell_8
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_cell8_img;
@property (weak, nonatomic) IBOutlet UILabel *name_cell8_lb;
@property (weak, nonatomic) IBOutlet UILabel *type_cell8_lb;

@end

