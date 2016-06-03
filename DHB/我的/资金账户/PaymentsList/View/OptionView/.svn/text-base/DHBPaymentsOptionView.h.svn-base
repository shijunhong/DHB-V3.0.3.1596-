//
//  DHBPaymentsOptionView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBPaymentsOptionTableViewCell.h"

@protocol DHBPaymentsOptionView_Delegate <NSObject>
- (void)paymentsOptionView_DidSelectRowAtIndexPath:(NSIndexPath *)indexPath isPayType:(BOOL) isPayType;
@end

@interface DHBPaymentsOptionView : UIView<UITableViewDataSource, UITableViewDelegate, DHBPaymentsOptionTableViewCell_Delegate>
{
    NSIndexPath *curOperateIndexPath;
}
@property(nonatomic, retain) UITableView *mainTableView;
@property(nonatomic, retain) NSArray *dataArray;
@property(nonatomic, assign) id<DHBPaymentsOptionView_Delegate> delegate;
@property(nonatomic, assign) BOOL isPayType;
@end
