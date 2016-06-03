//
//  DHBRechargeResultViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "DHBRechargeResultMainView.h"
#import "OrderModuleDTO.h"

@interface DHBRechargeResultViewController : DHBCommonViewController<DHBRechargeResultMainView_Delegate>
@property(nonatomic, retain) DHBRechargeResultMainView *mainView;
@property(nonatomic, assign) BOOL is_haveOrder;
@property(nonatomic, strong) OrderModuleDTO *order;
@end
