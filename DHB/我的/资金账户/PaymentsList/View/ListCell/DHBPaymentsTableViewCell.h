//
//  DHBPaymentsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBPaymentsInfoModuleDTO.h"

@interface DHBPaymentsTableViewCell : UITableViewCell
@property(nonatomic, retain) UIView *mainView; //主视图
@property(nonatomic, retain) UILabel *payTimeLabel; //支付时间
@property(nonatomic, retain) UILabel *depositTypeLabel;//预存款类型
@property(nonatomic, retain) UILabel *payTypeLabel; //付款方式
@property(nonatomic, retain) UILabel *balanceLabel; //余额
@property(nonatomic, retain) UILabel *amountLabel; //操作金额

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize) size;
- (void)updateViewWithDTO:(DHBPaymentsInfoModuleDTO *) dto;
@end
