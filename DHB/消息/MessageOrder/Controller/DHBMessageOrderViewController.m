//
//  DHBMessageOrderViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageOrderViewController.h"
#import "DHBMessageOrderCell.h"
#import "DHBOrderDetailsViewController.h"
#import "ReturnedOrderDetailsViewController.h"

@interface DHBMessageOrderViewController ()<MessageOrderServiceDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;

@end

@implementation DHBMessageOrderViewController
static NSString *identifier_1 = @"orderCell";

-(NSMutableArray *)data_arr{
    if (!_data_arr)
    {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

-(MessageOrderService *)service{
    if (!_service)
    {
        _service = [[MessageOrderService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitel:YES andTitelText:@"订单消息"];
    [self showBack:YES];
    
    [self.service queryMsgData];
    
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-Titel_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBMessageOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell) {
        cell = [[DHBMessageOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
    }
    NSDictionary *dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    cell.name_lb.text = [dic EncodeStringFromDicWithKey:@"data_type"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *createDate = [formatter dateFromString: [dic EncodeStringFromDicWithKey:@"create_date"]];
    if(createDate){
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm"];
        cell.time_lb.text = [formatter stringFromDate: createDate];
    }
    cell.content_lb.text = [dic EncodeStringFromDicWithKey:@"content"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    if ([[dic EncodeStringFromDicWithKey:@"content_type"] isEqualToString:@"order"])
    {
        DHBOrderDetailsViewController *orderDetails = [[DHBOrderDetailsViewController alloc] init];
        orderDetails.orderDetailsService.orders_id = [dic EncodeStringFromDicWithKey:@"content_id"];
        [self.navigationController pushViewController:orderDetails animated:YES];
    }
    else if ([[dic EncodeStringFromDicWithKey:@"content_type"] isEqualToString:@"back"])
    {
        ReturnedOrderDetailsViewController *returnedOrderDetails = [[ReturnedOrderDetailsViewController alloc] init];
        returnedOrderDetails.mainService.returns_id = [dic EncodeStringFromDicWithKey:@"content_id"];
        [self.navigationController pushViewController:returnedOrderDetails animated:YES];
    }
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    self.service.page = 1;
    [self.service queryMsgData];
}

-(void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.service cpage] < [self.service totalPage]){
        self.service.page = self.service.cpage+1;
        [self.service queryMsgData];
    }
    else{
        [self loadOver];
    }
}

#pragma mark - MessageOrderServiceDelegate
-(void)messageOrderServiceComplete:(MessageOrderService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        if (service.cpage == 1)
        {
            [self.data_arr removeAllObjects];
        }
        [self.data_arr addObjectsFromArray:service.msglist];
        [self.tableView reloadData];
        [self createFooterView];
        ///数据为空
        if([self.data_arr count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有订单消息"];
        }
    }
    else
    {
        [self.data_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
    [_refreshFooterView setState:EGOOPullRefreshNormal];
    [_refreshHeaderView setState:EGOOPullRefreshNormal];
    _reloading = NO;
}




@end
