//
//  DHBShoppingViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/4.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOM_HEIGHT 50.0F
#define ORDER_VI_HEIGHT 450.0f*(SCREEN_HEIGHT/750.0f)
#import "DHBShoppingViewController.h"
#import "DHBAddShoppingCarRequest.h"
#import "DHBGoodsDetailsViewController.h"
#import "DHBSubmitShoppingCarRequest.h"
#import "UserInformationModuleDTO.h"
#import "RBCustomDatePickerView.h"
#import "DHBInvoiceViewController.h"
#import "DHBAddressDeliveryViewController.h"
#import "DHBRechargeMethodViewController.h"
#import "DHBShoppingCarCell.h"
#import "DHBFinanceAccountViewController.h"
#import "DHBShoppingCarBottomView.h"

@interface DHBShoppingViewController ()<UITextFieldDelegate,DHBInvoiceViewControllerDelegate,DHBAddressDeliveryViewControllerDelegate,DHBShoppingCarCellDelegate, DHBSubmitOrderService_Delegate>
@property(nonatomic,strong)DHBShoppingCarBottomView *bottomView;//购物车底部视图
@property(nonatomic,strong)DHBShoppingCarOrderView *order_vi;//订单OrderView
@property (nonatomic, strong)UserInformationModuleDTO *userInformation;//用户信息
@property (nonatomic,strong)UIView *shareBackGroundView;//背景灰色透明图
@end

@implementation DHBShoppingViewController
#pragma mark - getters and setters
-(DHBShoppingCarBottomView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[DHBShoppingCarBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - Titel_HEIGHT - BOTTOM_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)];
        [_bottomView.shopping_btn addTarget:self action:@selector(addSubimtAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (ShoppingCarService *)shoppingCarService {
    if (!_shoppingCarService) {
        _shoppingCarService = [[ShoppingCarService alloc] init];
        _shoppingCarService.delegate = self;
    }
    return _shoppingCarService;
}

- (DHBSubmitOrderService *)submitOrderService{
    if(!_submitOrderService){
        _submitOrderService = [[DHBSubmitOrderService alloc] init];
        [_submitOrderService setDelegate: self];
    }
    return _submitOrderService;
}

-(DHBShoppingCarOrderView *)order_vi{
    if (!_order_vi)
    {
        _order_vi = [[DHBShoppingCarOrderView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ORDER_VI_HEIGHT)];
        [_order_vi setDelegate: self];
        [self.view insertSubview:_order_vi belowSubview:self.bottomView];
    }
    return _order_vi;
}

-(UIView *)shareBackGroundView{
    if (!_shareBackGroundView)
    {
        _shareBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _shareBackGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_shareBackGroundView addGestureRecognizer:gesture];
    }
    return _shareBackGroundView;
}

#pragma mark - Controllerlife load
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showBackgroundView:NO onClick:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(isShowNaviBackground)
    {
        WS(weakSelf);
        [self showBackgroundView:YES onClick:^{
            [weakSelf dismissBottomOrderView];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    [self showBack:YES];
    [self showTabBar:NO];
    [self showTitel:YES andTitelText:@"购物车"];
    //获取数据
    [self.shoppingCarService queryGoodsData];
    
    //添加底部视图
    [self.view addSubview:self.bottomView];
    
    //tableView
    [self.tableView setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, SCREEN_HEIGHT- Titel_HEIGHT - self.bottomView.frame.size.height)];
    [self.tableView setBackgroundColor: [UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark － TreeView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.shoppingCarService.goodslist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier: @"shoppingCarCell"];
    if(!cell)
    {
        cell = [[DHBShoppingCarCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"shoppingCarCell"];
        [cell setDelegate: self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateViewWithGoodsDTO:[self.shoppingCarService.goodslist safeObjectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

#pragma mark - tableView Deledate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
    GoodsModuleDTO *goods = [self.shoppingCarService.goodslist safeObjectAtIndex:indexPath.row];
    goodsDetails.goodsDetailsService.goods_id = goods.goods_id;
    goodsDetails.goodsDetailsService.price_id = goods.price_id;
    goodsDetails.goodsDetailsService.goods_num = goods.number;
    goodsDetails.goodsDetailsService.defaultOption = [goods.options_data safeObjectAtIndex:0];
    [self.navigationController pushViewController:goodsDetails animated:YES];
}

#pragma mark - 下拉刷新
- (void)HeaderRefreshView{
    //获取数据
    [self.shoppingCarService queryGoodsData];
}

#pragma mark - button action
/**
 *  返回按钮点击事件
 *
 *  @param sender  当前点击的按钮
 */
-(void)backAction:(UIButton *)sender{
    is_bakc = YES;
//    [self.navigationView.back_btn setEnabled: NO];
    if([self.shoppingCarService.goodslist count] > 0){
        [self.shoppingCarService submitShoppingCarWithHiddenEffect: NO];
    }
    else{
        [self.navigationController popViewControllerAnimated: YES];
    }
}

/**
 *  打开提交订单填写页面点击事件
 *
 *  @param sender 当前点击按钮
 */
-(void)addSubimtAction:(UIButton*)sender{
    switch (self.bottomView.bottom_type)
    {
        case ShoppingBottom:
            [self checkShoppingCarSubmit];
            break;
        case OrderBottom:
            [self submitOrderAction];
            break;
        default:
            break;
    }
}

#pragma mark  点击提交按钮时检查购物车数据
-(void)checkShoppingCarSubmit{
    if([self.shoppingCarService.goodslist count] > 0){
        if([[ParameterPublic sharedManagered] client_allow_order])//系统配置是否可以订货
        {
            [self.shoppingCarService submitShoppingCarWithHiddenEffect:NO];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:@"账号待审核，请审核通过后再下单" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }
}


#pragma mark - OrderView显示订单填写页面
-(void)showBottomOrderView{
    WS(weakSelf);
    [self showBackgroundView:YES onClick:^{
        [weakSelf dismissBottomOrderView];
    }];
    isShowNaviBackground = YES;
    [self.view insertSubview:self.shareBackGroundView belowSubview:self.order_vi];
    [self.bottomView setBottomViewContent:@{@"total_price":self.userInformation.total_price} layoutType:OrderBottom];
    [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [weakSelf.order_vi reloadData];
        weakSelf.order_vi.top = self.view.frame.size.height - ORDER_VI_HEIGHT;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark OrderView 隐藏订单填写页面
-(void)dismissBottomOrderView{
    [self showBackgroundView:NO onClick:nil];
    isShowNaviBackground = NO;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    WS(weakSelf);
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.order_vi.top = self.view.frame.size.height;
    } completion:^(BOOL finished) {
        [weakSelf.bottomView setBottomViewContent:[weakSelf.shoppingCarService getTotal] layoutType:ShoppingBottom];
        [weakSelf.shareBackGroundView removeFromSuperview];
    }];
}

#pragma mark - 订单填写页面的委托方法（DHBShoppingCarOrderView_Delegate）
#pragma mark 跳转到发票页面
- (void)shoppingCarOrderView_DidInvoiceAction:(DHBShoppingCarOrderTableViewCell *)cell {
    DHBInvoiceViewController *invioce = [[DHBInvoiceViewController alloc] init];
    invioce.userInformation = self.userInformation;
    invioce.delegate = self;
    [self.navigationController pushViewController:invioce animated:YES];
}

#pragma mark 跳转到收获地址页面
- (void)shoppingCarOrderView_DidAddressAction:(DHBShoppingCarOrderTableViewCell *)cell{
    WS(weakSelf);
    [self showBackgroundView:NO onClick:nil];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.order_vi.top  = self.view.frame.size.height-ORDER_VI_HEIGHT;
    }];
    DHBAddressDeliveryViewController *address = [[DHBAddressDeliveryViewController alloc] init];
    address.delegate = self;
    address.type = SELECT;
    [self.navigationController pushViewController:address animated:YES];
}

#pragma mark - 点击提交订单
-(void)submitOrderAction{
    //获取备注信息
//    for(NSInteger i = 0; i < [[self.order_vi.mainService floorArray] count]; i++)
//    {
//        HomeFloorDTO *floor = [[self.order_vi.mainService floorArray] objectAtIndex: i];
//        if([[floor floorName] isEqualToString: @"备注"]){
//            NSString *remark = [[(DHBShoppingCarOrderTableViewCell *)[[self.order_vi mainTableView] cellForRowAtIndexPath: [NSIndexPath indexPathForRow: i inSection: 0]] remarksTextView] text];
//            [self.userInformation setRemark: remark];
//        }
////        else if([[floor floorName] isEqualToString: @"配送方式"]){
////            NSString *distributeText = [[(DHBShoppingCarOrderTableViewCell *)[[self.order_vi mainTableView] cellForRowAtIndexPath: [NSIndexPath indexPathForRow: i inSection: 0]] deliveryTextField] text];
////            [self.userInformation setDistrib_mode: distributeText];
////        }
//    }
    [self.submitOrderService setUserInfoDTO: self.userInformation];
    [self.submitOrderService submitOrder];
}

#pragma mark - DHBSubmitOrderService Delegate 提交订单信息，并生成订单
/**
 *  确定提交订单后的代理方法
 *
 *  @param responseDictionary 提交订单后，接口返回数据
 *  @param isSuccess          订单是否提交成功
 */
- (void)DHBSubmitOrderService_SubmitOrder:(NSDictionary *)responseDictionary isSuceess:(BOOL)isSuccess{
    [self showBackgroundView:NO onClick:nil];
    if ([[responseDictionary EncodeNumberFromDicWithKey:@"enough"] boolValue])
    {
        [[ParameterPublic sharedManagered] setCart_count: 0];
        DHBRechargeMethodViewController *payOrder = [[DHBRechargeMethodViewController alloc] init];
        OrderModuleDTO *order = [[OrderModuleDTO alloc] init];
        [order parseFromDict:@{@"discount_total":[responseDictionary EncodeStringFromDicWithKey:@"discount_total"],
                               @"orders_num":[responseDictionary EncodeStringFromDicWithKey:@"orders_num"],
                               @"account_notpaid":[responseDictionary EncodeStringFromDicWithKey:@"discount_total"]}];
        payOrder.mainService.order = order;
        [self.navigationController pushViewController:payOrder animated:YES];
    }
    else
    {
        DHBAlertView *alertView = [[DHBAlertView alloc] init];
        alertView.lable.text = @"\n\n可支付余额不足，请先充值";
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue2)}, @{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
        WS(weakSelf);
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            if(buttonIndex == 1)
            {
                //跳转充值界面
                DHBFinanceAccountViewController *financeVC = [[DHBFinanceAccountViewController alloc] init];
                [weakSelf.navigationController pushViewController: financeVC animated: YES];
            }
        }];
        
        [alertView show];
    }
}

#pragma mark - ShoppingCarServiceDelegate 提交购物车数据，提交成功后显示订单提交信息填写页面
/**
 *  获取购物车数据
 *
 *  @param service   购物车服务类（ShoppingCarService）
 *  @param isSuccess 接口返回是否成功
 */
-(void)shoppingCarServiceComplete:(ShoppingCarService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        [self.tableView reloadData];
        [self.bottomView setHidden: NO];
        [self.bottomView setBottomViewContent:[service getTotal] layoutType:ShoppingBottom];
        if([self.shoppingCarService.goodslist count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"购物车空空如也"];
        }
    }
    else
    {
//        [self showNoNetView];
        [self.bottomView setHidden: YES];
        [self.shoppingCarService.goodslist removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.view message: @"加载失败，请重新加载"];
    }
}

/**
 *  提交当前购物车的数据，提交成功后打开提交订单的填写页面
 *
 *  @param service   购物车服务类
 *  @param isSuccess 提交订单是否成功
 */
-(void)shoppingCarServiceSubmit:(ShoppingCarService *)service isSuccess:(BOOL)isSuccess{
    if (is_bakc)
    {
        //返回按钮
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (isSuccess)
        {
            self.userInformation = service.userInformation;
            [self.order_vi setUserInfoDTO: self.userInformation];
            [self showBottomOrderView]; ///显示订单填写页面
        }
        else
        {
            if (service.code != 300)
            {
                [self.tableView reloadData];
                [[DHBAlertView sharedManagered] showMessage:@"起订量/库存不够,请检查商品数量！"];
            }
        }
    }
}


#pragma mark － DHBShoppingCarTableViewCellDelegate 购物车商品数量改变回调
/**
 *  修改购物车数量
 *
 *  @param goodsNumberView  当前购物车数量视图
 */
-(void)goodsNumberViewChanged:(GoodsNumberView *)goodsNumberView{
    [self.bottomView setBottomViewContent:[self.shoppingCarService getTotal] layoutType:ShoppingBottom];
    [self.tableView reloadData];
}

#pragma mark 删除购物车数据
/**
 *  删除购物车数据
 *
 *  @param dto 商品数据模型
 */
-(void)goodsDelete:(GoodsModuleDTO *)dto{
    DHBAlertView *alertView = [[DHBAlertView alloc] init];
    alertView.lable.text = @"\n\n确认删除该商品？";
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue2)}, @{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
    WS(weakSelf);
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if(buttonIndex == 1)
        {
            [weakSelf.shoppingCarService DeleteShoppingCarGoods:dto block:^(BOOL is_success) {
                if (is_success)
                {
                    [weakSelf.shoppingCarService queryGoodsData];
                }
            }];
        }
    }];
    [alertView show];
}

#pragma mark - DHBAddressDeliveryViewControllerDelegate 
#pragma mark 选取地址回调
-(void)addressDeliveryViewController:(DHBAddressDeliveryViewController *)controller address:(AddressModuleDTO *)address{
    [self.userInformation.purchasers setAddress: address];
    [self.order_vi setUserInfoDTO: self.userInformation];
    [self.order_vi reloadData];
}

#pragma mark 选取发票回调
-(void)DHBInvoiceViewController:(DHBInvoiceViewController*)invoiceController userInformation:(UserInformationModuleDTO*)userInformation{
    self.userInformation = userInformation;
    [self.order_vi setUserInfoDTO: self.userInformation];
    [self.order_vi reloadData];
    /**
     *  更新底部视图的价格
     */
    [self.bottomView setBottomViewContent:[self.shoppingCarService getTotal] layoutType: OrderBottom];
}

#pragma mark - BackgroundTapAction 点击背景蒙层(关闭订单视图)
-(void)backgroundTapped:(UIGestureRecognizer*)sender{
    [self dismissBottomOrderView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
