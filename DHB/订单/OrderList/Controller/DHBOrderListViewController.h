//
//  DHBOrderListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "OrderListService.h"
#import "MainPageViewController.h"

@interface DHBOrderListViewController : DHBTableViewController
{
    BOOL isSearch;
}
@property(nonatomic,strong)OrderListService *orderListService;
@end
