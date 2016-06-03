//
//  DHBLogisticsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLogisticsViewController.h"
#import "DHBOrderStateTableViewCell.h"
#import "HomeFloorDTO.h"
#import "DHBLogisticsCell.h"

@interface DHBLogisticsViewController ()<LogisticsServiceDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation DHBLogisticsViewController
static NSString *identifier_1 = @"LogisticsCell";

#pragma mark - lazyload
-(LogisticsService *)logisticsService{
    if (!_logisticsService)
    {
        _logisticsService = [[LogisticsService alloc] init];
        _logisticsService.delegate = self;
    }
    return _logisticsService;
}

#pragma mark - Controllerlife
#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.logisticsService queryLogisticsData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"订单状态"];
    [self showTabBar:NO];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.logistState_lb.text = self.logisticsService.ships.status;
    self.logistDate_lb.text = self.logisticsService.ships.ships_date;
    self.logistCompy_lb.text = self.logisticsService.ships.logistics_name;
    self.logistNum_lb.text = self.logisticsService.ships.express_num;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.data_arr safeObjectAtIndex:indexPath.row];
    DHBLogisticsCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell)
    {
        cell = [[DHBLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
    }
    [cell updateDataWithDto:data];
    if (indexPath.row == 0)
    {
        cell.circle_vi.sd_layout.topSpaceToView(cell.contentView,15.0f);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark TableView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableview];
}


#pragma mark  LogisticsServiceDelegate
-(void)logisticsServiceComplete:(LogisticsService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.logisticslist;
        [self.tableview reloadData];
        ////数据为空
        if([self.data_arr count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableview message: @"没有相关物流信息"];
        }
    }
    else
    {
        [self.data_arr removeAllObjects];
        [self.tableview reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableview message: @"加载失败，请重新加载"];
    }
}

@end
