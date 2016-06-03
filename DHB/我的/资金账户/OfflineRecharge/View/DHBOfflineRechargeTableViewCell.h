//
//  DHBOfflineRechargeTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "DHBUploadImageView.h"

@protocol DHBOfflineRechargeTableViewCell_Delegte <DHBTableCellDelegate>
@optional
- (void)offlineRechargeTableViewCell_DidSelectedAcctount:(UITableViewCell *) cell whithBankRow:(NSInteger)row;
- (void)offlineRechargeTableViewCell_textFieldDidBeginEditing:(UITextField *)textField;
- (void)offlineRechargeTableViewCell_textViewDidEndEditing:(UITextView *)textView cell:(UITableViewCell *)cell;
- (void)offlineRechargeTableViewCell_DidUploadPicture:(UIButton *) sender;
@end

@interface DHBOfflineRechargeTableViewCell : UITableViewCell<UITextFieldDelegate, UITextViewDelegate>
@property(nonatomic, retain) HomeFloorDTO *floorDTO;
@property(nonatomic, assign) id<DHBOfflineRechargeTableViewCell_Delegte> delegate;
@property(nonatomic, retain) NSMutableArray *accountArray; //账户视图数组
@property(nonatomic, retain) DHBTextField *rechargeTextField; //转账时间
@property(nonatomic, retain) UIButton *uploadButton; //上传凭证图片的按钮
@property(nonatomic, retain) DHBUploadImageView *uploadImageView;

- (void)showImage:(DHBUploadImage *) image;
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
