//
//  ReturnSubmitTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBUploadImageView.h"

@class ReturnSubmitTableViewCell;
@protocol ReturnSubmitTableViewCellDelegate <NSObject>
-(void)selectaddImgReturnSubmitTableViewCell:(ReturnSubmitTableViewCell*)cell;
-(void)deleteImgReturnSubmitTableViewCell:(ReturnSubmitTableViewCell*)cell;
-(void)returnSubmitTableViewCell:(ReturnSubmitTableViewCell*)cell textmark:(NSString*)mark;
@end

@interface ReturnSubmitTableViewCell : UITableViewCell<UITextFieldDelegate, DHBUploadImageView_Delegate>
@property (weak, nonatomic) IBOutlet UILabel *price_lb;
@property (weak, nonatomic) IBOutlet UITextField *mark_lb;
@property (weak, nonatomic) IBOutlet UILabel *textNum_lb;
@property (weak, nonatomic) IBOutlet UIView *images_vi;
@property (retain, nonatomic) NSMutableArray *imageViewsArray;

@property(weak,nonatomic)id<ReturnSubmitTableViewCellDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *img_arr;
-(void)updateCellData:(NSMutableArray*)img_arr;

@end
