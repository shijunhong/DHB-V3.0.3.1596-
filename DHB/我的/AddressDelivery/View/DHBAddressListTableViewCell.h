//
//  DHBAddressListTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInformationModuleDTO.h"
@class DHBAddressListTableViewCell;
@protocol DHBAddressListTableViewCellDelegate <NSObject>

-(void)DHBAddressListTableViewCell:(DHBAddressListTableViewCell*)cell onClickupdate:(UIButton*)sender;
@end

@interface DHBAddressListTableViewCell : UITableViewCell
@property (nonatomic,strong) AddressModuleDTO *address;
@property (strong, nonatomic) UILabel *name_lb;
@property (strong, nonatomic) UILabel *phone_lb;
@property (strong, nonatomic) UILabel *address_lb;
@property (strong, nonatomic) UIView *topLineView;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UIImageView *arrow_img;
@property (strong, nonatomic) UIImageView *default_img;
@property (assign, nonatomic) BOOL is_orderSelct;//订单创建时选择
@property (nonatomic, strong)UIButton *update_btn;
@property (nonatomic, weak)id<DHBAddressListTableViewCellDelegate> delegate;

- (void)updateView:(AddressModuleDTO*)address;
@end
