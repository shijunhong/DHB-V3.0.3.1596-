//
//  ReturnSubmitGoodsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModuleDTO.h"

@interface ReturnSubmitGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *image_vi;
@property (weak, nonatomic) IBOutlet UILabel *goodsnum_lb;
@property (weak, nonatomic) IBOutlet UILabel *goodsname_lb;
@property (weak, nonatomic) IBOutlet UIView *options_vi;
@property (weak, nonatomic) IBOutlet UIView *price_vi;

@property (nonatomic,strong)OrdersgoodsModuleDTO *ordersgoods;
@property (nonatomic,strong)EGOImageViewEx *goods_img;
@property (nonatomic,strong)TTTAttributedLabel *options_lb;
@property (nonatomic,strong)TTTAttributedLabel *price_lb;

-(void)updateCellData:(OrdersgoodsModuleDTO*)ordergoods;

@end
