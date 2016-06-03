//
//  DHBSiftingWithMarkCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/17.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "SiftingModuleDTO.h"

@class DHBSiftingWithMarkCell;
@protocol DHBSiftingWithMarkDelegate <NSObject>

-(void)selectSiftingCell:(DHBSiftingWithMarkCell*)cell markBtnIndex:(NSUInteger)index;

-(void)selectSiftingCell:(DHBSiftingWithMarkCell*)cell textField:(UITextField*)textField;
@end

@interface DHBSiftingWithMarkCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property(nonatomic, strong) UILabel *brandLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property(assign ,nonatomic)id<DHBSiftingWithMarkDelegate> delegate;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateBrandViewWithDTO:(BrandModuleDTO *)dto;
@end
