//
//  DHBShoppingCarBottomView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/29.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBLabel.h"

typedef enum{
    ShoppingBottom,
    OrderBottom
}BottomType;

@interface DHBShoppingCarBottomView : UIView
@property (nonatomic,strong)DHBLabel *total_lb;
@property (nonatomic,strong)UILabel *goods_lb;
@property (nonatomic,strong)DHBButton *shopping_btn;
@property (nonatomic,assign)BottomType bottom_type;
/**
 *  设置bottom 金额，数量
 *
 *  @param dic 
 */
-(void)setBottomViewContent:(NSDictionary *)dic layoutType:(BottomType)type;
@end
