//
//  DHBOrderGoodsListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "OrderGoodsListService.h"

@interface DHBOrderGoodsListViewController : DHBCommonViewController
@property(nonatomic,strong)NSMutableArray *orderslist;
@property(nonatomic,assign)BOOL HiddenBottomView;

@property(nonatomic,strong)NSString *orders_id;
@property(nonatomic,strong)OrderGoodsListService *service;
@end
