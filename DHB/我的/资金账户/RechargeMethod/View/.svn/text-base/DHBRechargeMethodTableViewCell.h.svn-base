//
//  DHBRechargeMethodTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
@protocol DHBRechargeMethodTableViewCell_Delegate <NSObject>
- (void)rechargeMethodTableViewCell_textFieldDidBeginEditing:(UITextField *)textField;
@end

@interface DHBRechargeMethodTableViewCell : UITableViewCell<DHBTextField_Delegate>
@property(nonatomic, retain) HomeFloorDTO *floorDTO;
@property(nonatomic, retain) DHBTextField *priceTextFiled;
@property(nonatomic, assign) id<DHBRechargeMethodTableViewCell_Delegate> delegate;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
