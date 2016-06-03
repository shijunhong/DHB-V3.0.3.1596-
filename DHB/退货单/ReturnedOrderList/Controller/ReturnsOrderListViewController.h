//
//  ReturnsGoodsListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBReturnedListService.h"
#import "ReturnsOrderTableViewCell.h"
#import "ReturnedOrderDetailsViewController.h"

@interface ReturnsOrderListViewController : DHBTableViewController<DHBReturnedListService_Delegate, ReturnsOrderTableViewCell_Delegate>
/**
 *  退货单的服务类
 */
@property(nonatomic,strong)DHBReturnedListService *orderListService;
/**
 *  退货单数据源
 */
@property(nonatomic,strong)NSMutableArray *orderArray;
/**
 *  是否重提交退货单页面跳转过来
 */
@property(nonatomic, assign) BOOL isComeFromSubmitVC;
@end
