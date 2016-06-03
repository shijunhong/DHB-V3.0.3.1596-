//
//  DHBOrderDetailsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderDetailsViewController.h"
#import "HomeFloorDTO.h"
#import "DHBOrderDetailCell.h"
#import "DHBOrderGoodsListViewController.h"
#import "DHBOrderStateViewController.h"
#import "DHBStockViewController.h"
#import "DHBReturnedGoodsViewController.h"
#import "DHBOperatingLogViewController.h"
#import "DHBShowInvoiceViewController.h"
#import "CustomIOSAlertView.h"
#import "DHBOrderAlertView.h"
#import "DHBRechargeMethodViewController.h"
#import "DHBPaymentRecordListViewController.h"

@interface DHBOrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,OrderDetailsServiceDelegate,DHBOrderDetailCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data_arr;
@property (strong, nonatomic) UIButton *guanzu_btn;
@property (strong, nonatomic) UILabel *collectionLabel;
@end

@implementation DHBOrderDetailsViewController
#pragma mark - lazyload
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height+TabBar_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor: [UIColor clearColor]];
    }
    return _tableView;
}

- (OrderDetailsService *)orderDetailsService {
    if (!_orderDetailsService) {
        _orderDetailsService = [[OrderDetailsService alloc] init];
        _orderDetailsService.delegate = self;
    }
    return _orderDetailsService;
}

- (UIButton *)guanzu_btn{
    if(!_guanzu_btn){
        _guanzu_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-18*3, 20.0f, 18*3, self.navigationView.height-20.0f)];
        [_guanzu_btn setBackgroundColor: [UIColor clearColor]];
        [_guanzu_btn addTarget:self action:@selector(guanzhuAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _guanzu_btn;
}

- (UILabel *)collectionLabel{
    if(!_collectionLabel){
        _collectionLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.guanzu_btn.width, self.guanzu_btn.height)];
        [_collectionLabel setFont: [UIFont systemFontOfSize: 18.0f]];
        [_collectionLabel setTextColor: [UIColor whiteColor]];
        [_collectionLabel setTextAlignment: NSTextAlignmentRight];
    }
    return _collectionLabel;
}

#pragma mark - Controllerlife
#pragma mark - View lifecycle

#pragma mark 内存处理
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    TT_RELEASE_SAFELY(self.tableView);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel:YES andTitelText:L(@"订单详情")];
    [self showBack:YES];
    [self showTabBar:NO];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.tableView];
    [self.orderDetailsService queryOrderDetailData];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview: self.guanzu_btn];
    [self.guanzu_btn addSubview: self.collectionLabel];
}

#pragma mark TreeView UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:section];
    return floor.floors;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBOrderDetailCell *cell = nil;
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:indexPath.section];
    NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)[floor.orderNO integerValue]];
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[DHBOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    [cell updateViewWithFloorDTO:floor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark TreeView UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:indexPath.section];
    return floor.hight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:indexPath.section];
    if ([floor.floorName isEqualToString:@"订单状态"])
    {
        DHBOrderStateViewController *orderState = [[DHBOrderStateViewController alloc] init];
        orderState.orderStateService.orders_id = self.orderDetailsService.order.orders_id;
        orderState.orderStateService.create_date = self.orderDetailsService.order.create_date;
        orderState.orderStateService.orders_num = self.orderDetailsService.order.orders_num;
        [self.navigationController pushViewController:orderState animated:YES];
    }
    else if ([floor.floorName isEqualToString:@"商品清单"])
    {
        DHBOrderGoodsListViewController * orderGoodsList = [[DHBOrderGoodsListViewController alloc] init];
        orderGoodsList.orders_id = self.orderDetailsService.order.orders_id;
        [self.navigationController pushViewController:orderGoodsList animated:YES];
    }
    else if ([floor.floorName isEqualToString:@"付款记录"])
    {
        DHBPaymentRecordListViewController *paymentVC = [[DHBPaymentRecordListViewController alloc] init];
        paymentVC.service.order = self.orderDetailsService.order;
        [self.navigationController pushViewController: paymentVC animated: YES];
    }
    else if ([floor.floorName isEqualToString:@"出库/发货记录"])
    {
        if([[floor templateID] isEqualToString: @"2"]){
            DHBStockViewController *stockView = [[DHBStockViewController alloc] init];
            stockView.orders_id = self.orderDetailsService.order.orders_id;
            [self.navigationController pushViewController:stockView animated:YES];
        }
    }
    else if ([floor.floorName isEqualToString:@"配送方式"]);
    else if ([floor.floorName isEqualToString:@"交货时间"]);
    else if ([floor.floorName isEqualToString:@"发票信息"])
    {
        DHBShowInvoiceViewController *showInvoice = [[DHBShowInvoiceViewController alloc] init];
        showInvoice.service.invoice = self.orderDetailsService.order.invoice;
        if ([self.orderDetailsService.order.invoice.invoice_type isEqualToString:@"P"]||[self.orderDetailsService.order.invoice.invoice_type isEqualToString:@"Z"])
        {
            [self.navigationController pushViewController:showInvoice animated:YES];
        }
    }
    else if ([floor.floorName isEqualToString:@"操作日志"])
    {
        DHBOperatingLogViewController *operatingLog = [[DHBOperatingLogViewController alloc] init];
        operatingLog.logs_arr= self.orderDetailsService.order.log_orders;
        [self.navigationController pushViewController:operatingLog animated:YES];
    }
    else if ([floor.floorName isEqualToString:@"订单附件"])
    {
        if([[floor templateID] isEqualToString: @"2"]){
            ///退货附件
            DHBOrderAttachmentViewController *orderAttatchVC = [[DHBOrderAttachmentViewController alloc] init];
            orderAttatchVC.mainService.orders_id = self.orderDetailsService.order.orders_id;
            [self.navigationController pushViewController: orderAttatchVC animated: YES];
        }
    }
}


#pragma mark - ButtonAction
/**
 *  收藏订单
 *
 *  @param sender 
 */
- (void)guanzhuAction:(UIButton *)sender{
    [sender setEnabled:NO];
    WS(weakSelf);
    [self.orderDetailsService FollowOrderCallback:^(BOOL is_success, NSString *msg) {
        [sender setEnabled:YES];
        if (is_success)
        {
            [sender setSelected:!sender.selected];
            if([[weakSelf.collectionLabel text] isEqualToString: L(@"收藏")])
                [weakSelf.collectionLabel setText: L(@"已收藏")];
            else
                [weakSelf.collectionLabel setText: L(@"收藏")];
        }
        else
        {
            if (msg)[[DHBAlertView sharedManagered] showMessage:msg];
        }
    }];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll" object:nil];
}

#pragma mark OrderDetailsServiceDelegate
- (void)orderDetailsServiceComplete:(OrderDetailsService *)service isSuccess:(BOOL )isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.dataArray;
        [self.tableView reloadData];
        [self.guanzu_btn setSelected:service.order.is_follow];
        [self.collectionLabel setText: service.order.is_follow?L(@"已收藏"):L(@"收藏")];
    }
    else
        NSLog(@"error = %@",service.error);
}

#pragma mark DHBOrderDetailCellDelegate
/**
 *  确认收货
 *
 *  @param orderDetailCell
 *  @param sender
 *  @param floorDTO
 */
-(void)DHBOrderDetailCell:(DHBOrderDetailCell *)orderDetailCell stockActionBtn:(UIButton *)sender withHomeFloorDTO:(HomeFloorDTO *)floorDTO{
    DHBStockViewController *stockView = [[DHBStockViewController alloc] init];
    stockView.orders_id = self.orderDetailsService.order.orders_id;
    [self.navigationController pushViewController:stockView animated:YES];
}

/**
 *  退货
 *
 *  @param orderDetailCell
 *  @param sender
 *  @param floorDTO
 */
-(void)DHBOrderDetailCell:(DHBOrderDetailCell *)orderDetailCell tuihuoActionBtn:(UIButton *)sender withHomeFloorDTO:(HomeFloorDTO *)floorDTO{
    DHBReturnedGoodsViewController *returnedGoods = [[DHBReturnedGoodsViewController alloc] init];
    returnedGoods.orders_id = self.orderDetailsService.order.orders_id;
    returnedGoods.service.orders_num = self.orderDetailsService.order.orders_num;
    [self.navigationController pushViewController:returnedGoods animated:YES];
}

/**
 *  点击取消订单
 *
 *  @param orderDetailCell
 *  @param sender
 *  @param floorDTO
 */
-(void)DHBOrderDetailCell:(DHBOrderDetailCell *)orderDetailCell cancelActionBtn:(UIButton *)sender withHomeFloorDTO:(HomeFloorDTO *)floorDTO{
    CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
    // 添加CustomIOSAlertView 的显示视图
    DHBOrderAlertView *content_vi= [[DHBOrderAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90*Multiple, 224*Multiple)];
    content_vi.titel_lb.text = L(@"取消订单");
    content_vi.textView.placeholder = L(@"若取消订单请填写原因");
    content_vi.textView.placeholderLabel.font = [UIFont systemFontOfSize:13];
    [alert setContainerView:content_vi];
    // 添加按钮
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":L(@"取消"),@"type":@(kDHBButton_StyleValue4)},@{@"name":L(@"确定"),@"type":@(kDHBButton_StyleValue3)}, nil]];
    WS(weakSelf);
    [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1)
        {
            [weakSelf.orderDetailsService cancelOrderRemark:content_vi.textView.text callback:^(BOOL is_success) {
                if (is_success)
                {
                    [alertView close];
                    [weakSelf.orderDetailsService queryOrderDetailData];
                }
            }];
        }
        else
            [alertView close];
    }];
    
    [alert setUseMotionEffects:true];
    [alert show];
    
}

/**
 *  点击订单留言
 *
 *  @param orderDetailCell
 *  @param sender
 *  @param floorDTO        
 */
-(void)DHBOrderDetailCell:(DHBOrderDetailCell *)orderDetailCell msgActionBtn:(UIButton *)sender withHomeFloorDTO:(HomeFloorDTO *)floorDTO{
    CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
    // 添加CustomIOSAlertView 的显示视图
    DHBOrderAlertView *content_vi= [[DHBOrderAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90*Multiple, 224*Multiple)];
    content_vi.titel_lb.text = L(@"留言");
    content_vi.textView.placeholder = L(@"给供货商留言内容");
    content_vi.textView.placeholderLabel.font = [UIFont systemFontOfSize:13];
    [alert setContainerView:content_vi];
    // 添加按钮
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":L(@"取消"),@"type":@(kDHBButton_StyleValue4)},@{@"name":L(@"确定"),@"type":@(kDHBButton_StyleValue3)}, nil]];
    // block 处理按钮回调.
    WS(weakSelf);
    [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1)
        {
            [weakSelf.orderDetailsService LeaveMsgRemark:content_vi.textView.text callback:^(BOOL is_success) {
                if (is_success)
                {
                    [alertView close];
                    [weakSelf.orderDetailsService queryOrderDetailData];
                }
            }];
        }
        else
            [alertView close];
    }];
    [alert setUseMotionEffects:true];
    // And launch the dialog
    [alert show];
}
/**
 *  支付订单
 *
 *  @param orderDetailCell
 *  @param sender
 *  @param floorDTO
 */
-(void)DHBOrderDetailCell:(DHBOrderDetailCell *)orderDetailCell payActionBtn:(UIButton *)sender withHomeFloorDTO:(HomeFloorDTO *)floorDTO{
    DHBRechargeMethodViewController *rechargeMethod = [[DHBRechargeMethodViewController alloc] init];
    rechargeMethod.mainService.order = self.orderDetailsService.order;
    [self.navigationController pushViewController:rechargeMethod animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
