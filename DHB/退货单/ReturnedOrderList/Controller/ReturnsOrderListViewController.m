//
//  ReturnsGoodsListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "ReturnsOrderListViewController.h"
@implementation ReturnsOrderListViewController
#pragma mark - getters and setters
- (DHBReturnedListService *)orderListService{
    if(!_orderListService){
        _orderListService = [[DHBReturnedListService alloc] init];
        [_orderListService setDelegate: self];
    }
    return _orderListService;
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel:YES andTitelText:@"退货单"];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showShoppingCar: NO];
    ///tableView
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setShowsVerticalScrollIndicator: NO];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor: [UIColor clearColor]];
    [self.orderListService queryData];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateData:) name:@"returnOrderUpdate" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - DHBReturnedListService_Delegate
- (void)returnedListService_Complete:(id)service isSuccess:(BOOL)isSuccess
{
    self.orderListService = service;
    if(isSuccess){
        if([self.orderListService cpage] > 1){
            [self.orderArray addObjectsFromArray: [service dataArray]];
        }
        else{
            self.orderArray = [NSMutableArray arrayWithArray: [service dataArray]];
        }
        [self.tableView reloadData];
        [self createFooterView];
        if([self.orderArray count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有退货单"];
        }
    }
    else{
        [self.orderArray removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}

#pragma mark tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_orderArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReturnsOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    DHBReturnedOrderModuleDTO *order = [self.orderArray safeObjectAtIndex:indexPath.row];
    if(!cell){
        cell = [[ReturnsOrderTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    [cell setDelegate: self];
    [cell updateViewWithOrderDTO: order];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReturnedOrderDetailsViewController *detailsVC = [[ReturnedOrderDetailsViewController alloc] init];
    DHBReturnedOrderModuleDTO *order = [self.orderArray safeObjectAtIndex:indexPath.row];
    [detailsVC.mainService setReturns_id: [order returns_id]];
    [self.navigationController pushViewController: detailsVC animated: YES];
}

#pragma mark - retrunsGoodsTableViewCell delegate
- (void)retrunsGoodsTableViewCell_DidOperateButtonClick:(ReturnsOrderTableViewCell *)cell{
    DHBReturnedOrderModuleDTO *order = cell.returnedOrder;
    if([[order status] isEqualToString: @"待审核"])
    {
        ///////取消退货
        CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
        //添加CustomIOSAlertView 的显示视图
        DHBOrderAlertView *content_vi= [[DHBOrderAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90*Multiple, 224*Multiple)];
        content_vi.titel_lb.text = @"取消退货";
        content_vi.textView.placeholder = @"请输入退货原因";
        content_vi.textView.placeholderLabel.font = [UIFont systemFontOfSize:13];
        [alert setContainerView:content_vi];
        [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue4)},@{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
        [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            if(buttonIndex == 1){
                ///调用接口
                [self.orderListService setReturns_id: [order returns_id]];
                [self.orderListService setCancel_reason: [content_vi.textView text]];
                [self.orderListService cancelReturnsOrder];
            }
            [alertView close];
        }];
        [alert setUseMotionEffects:true];
        [alert show];        
    }
    else if ([[order status] isEqualToString: @"待发货"])
    {
        ////确认发货先调整至配送方式页面
        DeliveryMethodViewController *deliveryVC = [[DeliveryMethodViewController alloc] init];
        [deliveryVC setReturns_id: [order returns_id]];
        [deliveryVC setDeliveryMethodDTO:[[DHBDeliveryMethodMoudleDTO alloc] init]];
        [deliveryVC setOperationMode: kAddDeliveryMode_type];
        [self.navigationController pushViewController: deliveryVC animated: YES];
    }
}

#pragma mark - EGO Delegate(刷新和加载更多)
- (void)HeaderRefreshView{
    [super HeaderRefreshView];
    [self.orderListService setPage: 0];
    [self.orderListService queryData];
    [self ShowFootView:NO];
}

- (void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.orderListService cpage] < [self.orderListService totalPage]){
        self.orderListService.page = self.orderListService.cpage+1;
        [self.orderListService queryData];
        [self ShowFootView:NO];
    }
    else{
        if ([_orderArray count]>0)
        {
            [self ShowFootView:YES];
        }
        [self loadOver];
    }
}

#pragma mark - 重写返回事件
- (void)backAction:(UIButton *)sender{
    if(self.isComeFromSubmitVC){
        [self.navigationController popToRootViewControllerAnimated: YES];
    }
    else{
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark 通知修改列表数据
-(void)UpdateData:(NSNotification *)noti{
    if ([noti.userInfo objectForKey:@"returns_id"])
    {
        WS(weakSelf);
        NSString *returns_id = [noti.userInfo objectForKey:@"returns_id"];
        [self.orderArray enumerateObjectsUsingBlock:^(DHBReturnedOrderModuleDTO* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.returns_id isEqualToString:returns_id])
            {
                [self.orderListService queryReturnOrderDetailsData:obj.returns_id returnOrder:^(DHBReturnsOrderModuleDTO *returnOrder) {
                    obj.status = [NSString stringWithString:returnOrder.status];
                    [weakSelf.tableView reloadData];
                }];
            }
        }];
    }
}
@end
