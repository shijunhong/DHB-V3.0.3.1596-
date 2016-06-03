//
//  DHBShoppingViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/4.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "ShoppingCarService.h"
#import "DHBShoppingCarOrderView.h"
#import "OrderModuleDTO.h"

@interface DHBShoppingViewController : DHBTableViewController<ShoppingCarServiceDelegate, DHBShoppingCarOrderView_Delegate, UIAlertViewDelegate>
{
    BOOL is_bakc;//是否点击返回键
    BOOL isShowNaviBackground;//是否显示导航栏背景
}
@property(nonatomic,strong)ShoppingCarService *shoppingCarService;
@property(nonatomic,strong)DHBSubmitOrderService *submitOrderService;
@end
