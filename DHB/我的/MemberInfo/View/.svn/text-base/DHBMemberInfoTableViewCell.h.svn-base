//
//  DHBMemberInfoTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "DHBMemberInfoModuleDTO.h"
@protocol DHBMemberInfoTableViewCell_Delegate <DHBTableCellDelegate>
@optional
- (void)memberInfoTableViewCell_TextFieldDidBeginEditing:(UITextField *)textField cell:(UITableViewCell *) cell;
- (void)memberInfoTableViewCell_TextFieldShouldReturn:(UITextField *)textField;
@end

@interface DHBMemberInfoTableViewCell : UITableViewCell<DHBTextField_Delegate>
@property(nonatomic, strong) HomeFloorDTO *floorDTO;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) DHBTextField *contentTextFiled;
@property(nonatomic, assign) id<DHBMemberInfoTableViewCell_Delegate> delegate;
@property(nonatomic, strong) UIImageView *arrowimageView;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
