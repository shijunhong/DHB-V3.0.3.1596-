//
//  DHBGoodsHeadView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/19.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListService.h"

@protocol DHBGoodsHeadViewDelegate <DHBTableCellDelegate>
@optional
- (void) DHBGoodsViewCell_didSelectCategory;
- (void) DHBGoodsViewCell_didSelectSifting;
- (void) DHBGoodsViewCell_didSelectExchangePic;
@end

@interface DHBGoodsHeadView : UIView
@property(nonatomic, strong)UIButton *category_btn;
@property(nonatomic, strong)UILabel *category_lb;
@property(nonatomic, strong)UIButton *sifting_btn;
@property(nonatomic, strong)UIButton *exchangePic_btn;
@property(nonatomic ,weak)id<DHBGoodsHeadViewDelegate> delegate;

-(void)updateViewWithDTO:(GoodsListService*)service;

@end
