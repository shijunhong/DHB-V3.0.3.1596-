//
//  DHBReturnedDetailsFooterView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBReturnsOrderModuleDTO.h"

@protocol DHBReturnedDetailsFooterView_Delegate <NSObject>
- (void)returnedDetailsFooterView_DidCancelButtonClick:(UIButton *) button;
- (void)returnedDetailsFooterView_DidLeaveMessageButtonClick:(UIButton *) button;
@end

@interface DHBReturnedDetailsFooterView : UIView
@property(nonatomic, retain) DHBButton *cancelButton;
@property(nonatomic, retain) DHBButton *leaveMessageButton;
@property(nonatomic, assign) id<DHBReturnedDetailsFooterView_Delegate> delegate;
- (void)updateViewWithDTO:(DHBReturnsOrderModuleDTO *) dto;
@end
