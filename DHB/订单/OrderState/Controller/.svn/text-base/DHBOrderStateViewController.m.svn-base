//
//  DHBOrderStateViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/18.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderStateViewController.h"
#import "DHBOrderStateTableViewCell.h"
#import "HomeFloorDTO.h"
@interface DHBOrderStateViewController ()<UITableViewDataSource,UITableViewDelegate,OrderStateServiceDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data_arr;
@property (weak, nonatomic) IBOutlet UIView *top_vi;
@property (weak, nonatomic) IBOutlet UILabel *orderNum_lb;
@property (weak, nonatomic) IBOutlet UILabel *createDate_lb;
@property (weak, nonatomic) IBOutlet UILabel *orderTitle_lb;
@end

@implementation DHBOrderStateViewController
static NSString *identifier_1 = @"StateCell";
#pragma mark - lazyload
-(OrderStateService *)orderStateService{
    if (!_orderStateService)
    {
        _orderStateService = [[OrderStateService alloc] init];
        _orderStateService.delegate = self;
    }
    return _orderStateService;
}

-(DHBReturnedDetailsService *)returnsStateService{
    if (!_returnsStateService)
    {
        _returnsStateService = [[DHBReturnedDetailsService alloc] init];
        _returnsStateService.delegate = self;
    }
    return _returnsStateService;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.top_vi.bottom+8, SCREEN_WIDTH, SCREEN_HEIGHT-self.top_vi.bottom-8)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - Controllerlife
#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showBack:YES];
    [self showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    if([self.orderStateService orders_id]){
        [self.orderStateService queryOrderStateData];
        self.orderNum_lb.text = self.orderStateService.orders_num;
        self.createDate_lb.text = self.orderStateService.create_date;
        [self showTitel:YES andTitelText:@"订单状态"];
    }
    else if([self.returnsStateService returns_id]){
        [self.returnsStateService queryOrderStateData];
        self.orderNum_lb.text = self.returnsStateService.returnedOrderDTO.returns_num;
        self.createDate_lb.text = self.returnsStateService.returnedOrderDTO.create_date;
        [self.orderTitle_lb setText: @"退单号"];
        [self showTitel:YES andTitelText:@"退货单状态"];
    }
}

#pragma mark TableView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.data_arr safeObjectAtIndex:indexPath.row];
    DHBOrderStateTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell)
    {
        cell = [[DHBOrderStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
    }
    [cell updateViewWithDTO:data];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark TableView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: [UIColor clearColor]];
    return view;
}

#pragma mark  OrderStateServiceDelegate
- (void)orderStateServiceComplete:(OrderStateService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.statelist;
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }
}

#pragma mark - DHBReturnedDetailsService_Delegate
- (void)returnedDetailsService_OrderStatusRequestFinish:(id)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = [service statusFloorsArray];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
