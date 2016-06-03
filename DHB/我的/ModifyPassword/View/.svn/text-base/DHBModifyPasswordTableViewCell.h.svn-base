//
//  DHBModifyPasswordTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHBModifyPasswordTableViewCell_Delegate <NSObject>
- (void)modifyPasswordTableViewCell_TextFieldDidBeginEditing:(UITextField *)textField cell:(UITableViewCell *) cell;
@end

@interface DHBModifyPasswordTableViewCell : UITableViewCell<DHBTextField_Delegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) DHBTextField *contentTextFiled;
@property(nonatomic, assign) id<DHBModifyPasswordTableViewCell_Delegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size;
@end
