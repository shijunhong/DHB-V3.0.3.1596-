//
//  DHBRechargeResultMainView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayType.h"



@protocol DHBRechargeResultMainView_Delegate <NSObject>
- (void)rechargeResultMainView_DidBackButtonClick:(UIButton *) button;
@end

@interface DHBRechargeResultMainView : UIView
@property(nonatomic, assign) id<DHBRechargeResultMainView_Delegate> delegate;
@property(nonatomic, strong) NSString *amount;//金额
@property(nonatomic, strong)PayType *type;//支付类型

-(void)updateMainViewDate:(BOOL) is_haveOrder;
@end
