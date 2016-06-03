//
//  DHBStockViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "OrderModuleDTO.h"
#import "StockService.h"

@interface DHBStockViewController : DHBTableViewController
@property(nonatomic,strong)ShipsModuleDTO *ships;
@property(nonatomic,strong)NSString *orders_id;
@property(nonatomic,strong)StockService *service;
@end
