//
//  DHBPaymentsOptionTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBPaymentsSiftingMOduleDTO.h"

@class DHBPaymentsOptionTableViewCell;
@protocol DHBPaymentsOptionTableViewCell_Delegate <NSObject>
//- (void)paymentsOptionTableViewCell_DidClickCell:(DHBPaymentsOptionTableViewCell *)cell;
@end

@interface DHBPaymentsOptionTableViewCell : UITableViewCell
@property(nonatomic, retain) UILabel *valueLabel;
@property(nonatomic, retain) UIImageView *selectImageView;
@property(nonatomic, assign) id<DHBPaymentsOptionTableViewCell_Delegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size;
- (void)updateViewWithPayTypeDTO:(DHBPayTypeModuleDTO *)dto;
- (void)updateViewWithDepositeTypeDTO:(DHBDepositTypeModuleDTO *)dto;
@end
