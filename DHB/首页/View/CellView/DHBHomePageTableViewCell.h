//
//  DHBHomePageTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/21.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import <objc/message.h>
#import "DHBEightBannerView.h"
#import "DHBHomeFunctionView.h"
#import "DHBProductView_2.h"
#import "DHBFloorView.h"
#import "DHBGoodsViewCell_2.h"
#import "GoodsModuleDTO.h"

@protocol DHBHomePageTableViewCellDelegate <NSObject>
@optional
- (void)selectHomeFloor:(HomeFloorDTO*)floor WithModuleDTO:(NSObject *)dto;
- (void)DHBHomePageTableViewCell_didSelectRow:(UITableViewCell *)cell;
- (void)homePageTableViewCell_DidGoodsListButtonClick;
@end

@interface DHBHomePageTableViewCell : UITableViewCell<DHBEightBannerViewDelegate,DHBHomeFunctionViewDelegate,DHBProductView_2Delegate, DHBGoodsViewCellDelegate>
@property (nonatomic, assign) id <DHBHomePageTableViewCellDelegate>  delegate;
//楼层DTO
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  更新界面
 *
 *  @param array 模块列表
 */
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
