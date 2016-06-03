//
//  DHBCorporateFinancialTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/31/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBTableCellDelegate.h"

@protocol DHBCorporateFinancialTableViewCell_Delegate <NSObject>
//- (void)corporateFinancialTableViewCell_TextFieldDidEndEditing:(UITextField *)textField cell:(UITableViewCell *) cell;
@end

@interface DHBCorporateFinancialTableViewCell : UITableViewCell<UITextFieldDelegate, DHBTextField_Delegate>
@property(nonatomic, strong) NSMutableArray *data_arr;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) DHBTextField *contentTextFiled;
@property(nonatomic, assign) id<DHBCorporateFinancialTableViewCell_Delegate, DHBTableCellDelegate> delegate;


-(void)updateData:(NSMutableArray*)data;
@end
