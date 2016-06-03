//
//  DHBFinanceAccountHeaderView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHBFinanceAccountHeaderView_Delegte <NSObject>
- (void)financeAccountHeaderView_DidRechargeButton: (UIButton *) button;
@end

@interface DHBFinanceAccountHeaderView : UIView
@property(nonatomic, retain) UIImageView *topImageView;
@property(nonatomic, retain) UILabel *financeLabel;
@property(nonatomic, retain) DHBButton *rechargeButton;
@property(nonatomic, assign) id<DHBFinanceAccountHeaderView_Delegte> delegate;

- (void)setFinanceLabelText:(NSString *) text;
@end
