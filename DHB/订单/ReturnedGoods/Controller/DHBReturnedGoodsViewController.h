//
//  DHBReturnedGoodsViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//


#import "DHBReturnedGoodsService.h"
#import "DHBTableViewController.h"
@interface DHBReturnedGoodsViewController : DHBTableViewController
{
    id firstResposer;
}
@property(nonatomic,strong)NSString *orders_id;
@property(nonatomic,strong)DHBReturnedGoodsService *service;
@property(nonatomic,strong)NSMutableArray *data_arr;

@end
