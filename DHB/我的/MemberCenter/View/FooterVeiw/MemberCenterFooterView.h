//
//  MemberCenterFooterView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MemberCenterFooterView_Delegate <NSObject>
- (void)footerView_DidChangeAccountButtonClick:(UIButton *) button;
@end

@interface MemberCenterFooterView : UIView
@property(nonatomic, assign) id <MemberCenterFooterView_Delegate> delegate;
@property(nonatomic, strong) DHBButton *changeAccountButton;
@end
