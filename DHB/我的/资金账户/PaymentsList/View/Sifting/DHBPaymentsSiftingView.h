//
//  DHBPaymentsSiftingView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBPaymentsSiftingTableViewCell.h"

@protocol DHBPaymentsSiftingView_Delegate <NSObject>
- (void)paymentsSiftingView_DidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)paymentsSiftingView_DidClearButton:(UIButton *) button;
- (void)paymentsSiftingView_DidOkButton:(UIButton *) button;
@end

@interface DHBPaymentsSiftingView : UIView<UITableViewDataSource, UITableViewDelegate, DHBPaymentsSiftingTableViewCell_Delegate>
{
    CGFloat datePickerHeight;
}
@property(nonatomic, retain) UITableView *mainTableView;
@property(nonatomic, retain) UIView *bottomView;
@property(nonatomic, assign) id<DHBPaymentsSiftingView_Delegate> delegate;
@end
