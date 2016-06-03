//
//  DHBStockViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBStockViewController.h"
#import "DHBStockTableViewCell.h"
#import "DHBOrderGoodsListViewController.h"
#import "DHBLogisticsViewController.h"
#import "DHBStockOrderTableViewCell.h"
#import "DHBOrderGoodsListViewController.h"
#import "DHBShipsContentRequest.h"
#import "OrderModuleDTO.h"

@interface DHBStockViewController ()<DHBStockTableViewCellDelegate,StockServiceDelegate>

@end

@implementation DHBStockViewController
static NSString *identifier_1 = @"StockCell";
static NSString *identifier_2 = @"OrdersCell";

#pragma mark - lazyload
-(StockService *)service{
    if (!_service)
    {
        _service = [[StockService alloc] init];
        _service.orders_id = self.orders_id;
        _service.delegate = self;
    }
    return _service;
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
    [self.service queryOrderDetailData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"出库/发货记录"];
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.ships.shipslist count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
    {
        DHBStockOrderTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_2];
        if (!cell)
        {
            cell = [[DHBStockOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_2];
        }
        [cell updateViewWithDTO:self.ships];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    ShipsChildModuleDTO *ships = [self.ships.shipslist safeObjectAtIndex:indexPath.row-1];
    DHBStockTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell)
    {
        cell = [[DHBStockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
        cell.delegate = self;
    }
    [cell updateViewWithDTO:ships];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0)
    {
        DHBOrderGoodsListViewController *orderGoodsList = [[DHBOrderGoodsListViewController alloc] init];
        orderGoodsList.orderslist = self.ships.goodslist;
        orderGoodsList.HiddenBottomView = YES;
        [self.navigationController pushViewController:orderGoodsList animated:YES];
    }
    else
    {
        ShipsChildModuleDTO *ships = [self.ships.shipslist safeObjectAtIndex:indexPath.row-1];
        NSMutableArray *orderslist = [[NSMutableArray alloc] init];
        WS(weakSelf);
        DHBShipsContentRequest *request =[[DHBShipsContentRequest alloc] init];
        request.ships_id = ships.ships_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            NSLog_Red(@"%@",dic);
            if ([[dic objectForKey:@"code"] intValue] ==100)
            {
                NSDictionary *data =[dic objectForKey:@"data"];
                NSArray *arr = [data objectForKey:@"orderslist"];
                for (NSDictionary *dic in arr)
                {
                    OrdersgoodsModuleDTO *goods = [[OrdersgoodsModuleDTO alloc] init];
                    [goods parseFromDict:dic];
                    [orderslist addObject:goods];
                }
                DHBOrderGoodsListViewController * orderGoodsList = [[DHBOrderGoodsListViewController alloc] init];
                orderGoodsList.orderslist = orderslist;
                orderGoodsList.HiddenBottomView = YES;
                [weakSelf.navigationController pushViewController:orderGoodsList animated:YES];
            }
            else
            {
                NSLog_Red(@"error code=%@",dic);
            }
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
             NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        }];
    }
}

#pragma mark -StockServiceDelegate
-(void)stockServiceComplete:(StockService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        TT_RELEASE_SAFELY(self.ships);
        self.ships = service.ships;
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }
}


#pragma mark - DHBStockTableViewCellDelegate
-(void)DHBStockTableViewCell:(DHBStockTableViewCell*)stockTableViewCell clickLogisticsAction:(ShipsChildModuleDTO*)ships{
    DHBLogisticsViewController *logistics = [[DHBLogisticsViewController alloc] init];
    logistics.logisticsService.ships = ships;
    [self.navigationController pushViewController:logistics animated:YES];
}

-(void)DHBStockTableViewCell:(DHBStockTableViewCell*)stockTableViewCell clickSureAction:(ShipsChildModuleDTO *)ships{
    OrderModuleDTO *order = [[OrderModuleDTO alloc] init];
    order.orders_id = self.orders_id;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil userInfo:@{@"order":order}];
    [self.service queryOrderDetailData];
}


@end
