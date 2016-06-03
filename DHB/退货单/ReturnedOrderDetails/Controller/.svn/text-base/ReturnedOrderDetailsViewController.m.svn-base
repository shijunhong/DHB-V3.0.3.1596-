//
//  ReturnedOrderDetailsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/28/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define FOOTER_HEIGHT 89.0f
#import "ReturnedOrderDetailsViewController.h"
#import "DHBOrderStateViewController.h"
#import "DHBReturnedGoodsListViewController.h"
#import "DHBOperatingLogViewController.h"

@implementation ReturnedOrderDetailsViewController

#pragma mark -
- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (DHBReturnedDetailsService *)mainService{
    if(!_mainService){
        _mainService = [[DHBReturnedDetailsService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (DHBReturnedDetailsFooterView *)footerView{
    if(!_footerView){
        _footerView = [[DHBReturnedDetailsFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, FOOTER_HEIGHT)];
        [_footerView setBackgroundColor: [UIColor whiteColor]];
        [_footerView setDelegate: self];
    }
    return _footerView;
}
#pragma mark -
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    ///serivce
    [self.mainService queryOrderDetailsData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel:YES andTitelText:@"退货单详情"];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showShoppingCar: NO];
    ////tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setShowsVerticalScrollIndicator: NO];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView setTableFooterView: self.footerView];
}

#pragma mark - DHBReturnedDetailsService_Delegate
- (void)returnedDetailsService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.dataArray = [service floorsArray];
        [self.footerView updateViewWithDTO: [service returnedOrderDTO]];
//        NSLog(@"%f", self.footerView.height);
        [self.tableView reloadData];
        ///查询退货单附件数量
//        [self.mainService queryReturnsAttachmentData];
    }
}

//- (void)returnedDetailsService_ReturnsAttachmentComplete:(id)service isSuccess:(BOOL)isSuccess{
//    if(isSuccess){
//        self.mainService = service;
//        [self.tableView reloadData];
//    }
//}

#pragma mark 取消退货回调
- (void)returnedDetailsService_CancelComplete:(id)service isSuccess:(BOOL)isSuccess{
    self.mainService = service;
    if(isSuccess){
        [self.mainService queryOrderDetailsData];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: self.mainService.message delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBReturnedDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBReturnedDetailsTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    HomeFloorDTO *dto = [self.dataArray objectAtIndex: [indexPath section]];
    if([[dto floorName] isEqualToString: @"退货附件"]){
        [dto setModuleList: [NSMutableArray arrayWithObject: [self.mainService returnedOrderDTO]]];
    }
    [cell updateViewWithFloorDTO: dto];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.dataArray objectAtIndex: [indexPath section]];
    return [dto hight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *dto = [self.dataArray objectAtIndex: section];
    return [dto sectionHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: HEX_RGB(0xf0f0f0)];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.dataArray objectAtIndex: [indexPath section]];
    DHBReturnsOrderModuleDTO *order = [dto.moduleList firstObject];
    switch ([[dto templateID] integerValue]) {
        case 1:{
            ///退货状态
            DHBOrderStateViewController *orderState = [[DHBOrderStateViewController alloc] init];
            [orderState.returnsStateService setReturns_id: [order returns_id]];
            [orderState.returnsStateService setReturnedOrderDTO: order];
            [self.navigationController pushViewController:orderState animated:YES];
            break;
        }
        case 2:{
            ///退货清单
            DHBReturnedGoodsListViewController *orderGoodsList = [[DHBReturnedGoodsListViewController alloc] init];
            [orderGoodsList.mainService setReturns_id: [order returns_id]];
            [self.navigationController pushViewController:orderGoodsList animated:YES];
            break;
        }
        case 5:{
            if([[order attachmentNumber] integerValue] > 0){
                ///退货附件
                DHBOrderAttachmentViewController *orderAttatchVC = [[DHBOrderAttachmentViewController alloc] init];
                [orderAttatchVC setIsReturnsOrder: YES];
                [orderAttatchVC.mainService setReturns_id: [order returns_id]];
                [self.navigationController pushViewController: orderAttatchVC animated: YES];
            }
            break;
        }
        case 6:{
            ///操作日志
            DHBOperatingLogViewController *operatingLog = [[DHBOperatingLogViewController alloc] init];
            operatingLog.logs_arr= [self.mainService.returnedOrderDTO log_returns];
            [self.navigationController pushViewController:operatingLog animated:YES];
            break;
        }
        case 8:{
            ///退货方式
            DeliveryMethodViewController *deliveryVC = [[DeliveryMethodViewController alloc] init];
            [deliveryVC setDeliveryMethodDTO: [order deliveryMethodDTO]];
            [deliveryVC setReturns_id: [order returns_id]];
            [deliveryVC setOperationMode: kEditDeliveryMode_type];
            [self.navigationController pushViewController: deliveryVC animated: YES];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark footer delegate
- (void)returnedDetailsFooterView_DidLeaveMessageButtonClick:(UIButton *)button{
    ///留言
    CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
    // 添加CustomIOSAlertView 的显示视图
    DHBOrderAlertView *content_vi= [[DHBOrderAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90*Multiple, 224*Multiple)];
    content_vi.titel_lb.text = @"留言";
    content_vi.textView.placeholder = @"请输入给供货商留言内容";
    content_vi.textView.placeholderLabel.font = [UIFont systemFontOfSize:13];
    [alert setContainerView:content_vi];
    // 添加按钮
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue4)},@{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
    // block 处理按钮回调.
    WS(weakSelf);
    [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if(buttonIndex == 1){
            //提交留言接口
            [weakSelf.mainService setLeaveMessage: [content_vi.textView text]];
            [weakSelf.mainService  setReturns_id: weakSelf.mainService.returnedOrderDTO.returns_id];
            [weakSelf.mainService submitLeaveMessage];
        }
        [alertView close];
    }];
    [alert setUseMotionEffects:true];
    [alert show];
}

- (void)returnedDetailsFooterView_DidCancelButtonClick:(UIButton *)button{
    if([[button.titleLabel text] isEqualToString: @"确认发货"]){
        ////确认发货先调整至配送方式页面
        HomeFloorDTO *dto = [self.dataArray firstObject];
        DHBReturnsOrderModuleDTO *order = [dto.moduleList firstObject];
        DeliveryMethodViewController *deliveryVC = [[DeliveryMethodViewController alloc] init];
        [deliveryVC setReturns_id: [order returns_id]];
        [deliveryVC setOperationMode: kAddDeliveryMode_type];
        [self.navigationController pushViewController: deliveryVC animated: YES];
    }
    else if([[button.titleLabel text] isEqualToString: @"取消退货"]){
        ///取消退货
        CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
        //添加CustomIOSAlertView 的显示视图
        DHBOrderAlertView *content_vi= [[DHBOrderAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90*Multiple, 224*Multiple)];
        content_vi.titel_lb.text = @"取消退货";
        content_vi.textView.placeholder = @"请输入取消退货原因";
        content_vi.textView.placeholderLabel.font = [UIFont systemFontOfSize:13];
        [alert setContainerView:content_vi];
        [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue4)},@{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
        [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            if(buttonIndex == 1){
                ///调用接口
                [self.mainService setCancel_reason: [content_vi.textView text]];
                [self.mainService cancelReturnsOrder];
            }
            [alertView close];
        }];
        [alert setUseMotionEffects:true];
        [alert show];
    }
}

#pragma mark - delloc
- (void)dealloc {
}
@end
