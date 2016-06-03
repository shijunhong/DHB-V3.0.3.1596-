//
//  DHBOrderListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define TOPVIEW_HEIGHT 54.0f
#import "DHBOrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderModuleDTO.h"
#import "DHBSearchViewController.h"
#import "DHBOrderDetailsViewController.h"
#import "CDRTranslucentSideBar.h"
#import "RBCustomDatePickerView.h"
#import "DHBOrderSiftingStatusTableViewCell.h"
#import "DHBRechargeMethodViewController.h"

@interface DHBOrderListViewController ()<OrderListServiceDelegate,DHBSearchViewControllerDelegate,CDRTranslucentSideBarDelegate,RBCustomDatePickerViewDelegate,OrderListTableViewCellDelegate>{
    int _open_num;//打开次数
}

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)NSMutableArray *order_arr;
//筛选
@property(strong, nonatomic)CDRTranslucentSideBar *siftingView;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (strong, nonatomic) UIView *dateview;
@property (weak, nonatomic) IBOutlet UIView *sifting_scrTop;
@property (weak, nonatomic) IBOutlet UIScrollView *sifting_scroll;
@property (nonatomic ,assign)BOOL is_concern;
@property (weak, nonatomic) IBOutlet UILabel *concern_lb;
@property (weak, nonatomic) IBOutlet UIImageView *concern_img;
@property (weak, nonatomic) IBOutlet UIButton *date_btn1;
@property (weak, nonatomic) IBOutlet UIButton *date_btn2;
//订单状态
@property(strong, nonatomic)CDRTranslucentSideBar *statusViewController;
@property (weak, nonatomic) IBOutlet UITableView *status_tableView;
//付款状态
@property(strong, nonatomic)CDRTranslucentSideBar *pay_statusViewController;
@property (weak, nonatomic) IBOutlet UITableView *pay_status_tableView;

//背景灰色透明图
@property (nonatomic,strong)UIView *shareBackGroundView;

///搜索
@property (nonatomic, strong) UILabel *search_lb;

@property(nonatomic, retain) DHBTipView *tipView;
@end

@implementation DHBOrderListViewController
static NSString *identifier_1 = @"OrderCell";
static NSString *identifier_2 = @"StatusCell";
static NSString *identifier_3 = @"Pay_statusCell";

#pragma mark - setters and getters
- (DHBTipView *)tipView{
    if(!_tipView)
    {
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (UIView *)shareBackGroundView{
    if(!_shareBackGroundView){
        _shareBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _shareBackGroundView.opaque = NO;
    }
    return _shareBackGroundView;
}

-(CDRTranslucentSideBar *)siftingView{
    if (!_siftingView)
    {
        _siftingView = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _siftingView.sideBarWidth = SCREEN_WIDTH-60;
        self.siftingView.delegate = self;
        _siftingView.translucentAlpha =0;
        _siftingView.tag = 0;
        [_siftingView setContentViewInSideBar:[[[NSBundle mainBundle] loadNibNamed:@"DHBOrderSiftingView" owner:self options:nil] objectAtIndex:0]];
        self.is_concern = YES;
        [_orderStatusLabel setTextColor: [UIColor TextGray_Color]];
        [_payStatusLabel setTextColor: [UIColor TextGray_Color]];
    }
    return _siftingView;
}


-(CDRTranslucentSideBar *)statusViewController{
    if (!_statusViewController)
    {
        _statusViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _statusViewController.sideBarWidth = SCREEN_WIDTH-60;
        _statusViewController.delegate = self;
        _statusViewController.translucentAlpha =0;
        _statusViewController.tag = 0;
        [_statusViewController setContentViewInSideBar:[[[NSBundle mainBundle] loadNibNamed:@"DHBOrderSiftingChildView" owner:self options:nil] objectAtIndex:0]];
        self.status_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *nib = [UINib nibWithNibName:@"DHBOrderSiftingStatusTableViewCell" bundle:nil];
        [self.status_tableView registerNib:nib forCellReuseIdentifier:identifier_2];
    }
    return _statusViewController;
}


-(CDRTranslucentSideBar *)pay_statusViewController{
    if (!_pay_statusViewController)
    {
        _pay_statusViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _pay_statusViewController.sideBarWidth = SCREEN_WIDTH-60;
        _pay_statusViewController.delegate = self;
        _pay_statusViewController.translucentAlpha =0;
        _pay_statusViewController.tag = 0;
        [_pay_statusViewController setContentViewInSideBar:[[[NSBundle mainBundle] loadNibNamed:@"DHBOrderSiftingChild_1View" owner:self options:nil] objectAtIndex:0]];
        self.pay_status_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *nib = [UINib nibWithNibName:@"DHBOrderSiftingStatusTableViewCell" bundle:nil];
        [self.pay_status_tableView registerNib:nib forCellReuseIdentifier:identifier_3];
    }
    return _pay_statusViewController;
}

-(OrderListService *)orderListService{
    if (!_orderListService)
    {
        _orderListService = [[OrderListService alloc] init];
        _orderListService.delegate = self;
    }
    return _orderListService;
}

-(UIView *)topView{
    if (!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, SCREEN_WIDTH, TOPVIEW_HEIGHT)];
        [_topView setBackgroundColor:HEX_RGB(0xf0f0f0)];
        
        NSString *sifting_btn_str = L(@"  筛选");
        UIImage *screening_normal = [UIImage imageNamed:@"screening_normal"];
        UIButton *sifting_btn =[[UIButton alloc] init];
        [sifting_btn setImage:screening_normal forState:UIControlStateNormal];
        [sifting_btn setTitle:sifting_btn_str forState:UIControlStateNormal];
        [sifting_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [sifting_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [sifting_btn addTarget:self action:@selector(siftingAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:sifting_btn];
        sifting_btn.sd_layout.centerYEqualToView(_topView).rightSpaceToView(_topView,0.0f).widthIs(30.0f+screening_normal.size.width+sifting_btn_str.length*14.0f).heightIs(_topView.size.height);
        
        
        UIButton *search_btn = [[UIButton alloc] init];
        [search_btn setBackgroundColor:[UIColor whiteColor]];
        search_btn.layer.cornerRadius = 5;
        [search_btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:search_btn];
        search_btn.sd_layout.centerYEqualToView(_topView).leftSpaceToView(_topView,15.0f).rightSpaceToView(sifting_btn,0.0f).heightIs(TOPVIEW_HEIGHT - 20.0f);
        
        UIImage *hp_search = [UIImage imageNamed:@"hp_search"];
        UIImageView *search_vi = [[UIImageView alloc] init];
        [search_vi setImage:hp_search];
        [search_vi setContentMode: UIViewContentModeScaleAspectFit];
        [_topView addSubview:search_vi];
        search_vi.sd_layout.centerYEqualToView(search_btn).leftSpaceToView(_topView,15.0f+10.0f).widthIs(hp_search.size.width).heightIs(hp_search.size.height);
        
        if(!_search_lb){
            _search_lb = [[UILabel alloc] init];
            _search_lb.font = [UIFont systemFontOfSize:14.0f];
            _search_lb.textColor = [UIColor TextGray_Color];
            _search_lb.alpha = 0.9;
            _search_lb.text = @"请输入订单号/商品名称";
        }
        [_topView addSubview:_search_lb];
        _search_lb.sd_layout.centerYEqualToView(search_btn).leftSpaceToView(search_vi,5.0f).rightSpaceToView(sifting_btn,0.0f).heightIs(TOPVIEW_HEIGHT - 20.0f);
        
    }
    return _topView;
}


-(NSMutableArray *)order_arr{
    if (!_order_arr)
    {
        _order_arr = [NSMutableArray array];
    }
    return _order_arr;
}

-(UIView *)dateview{
    if (!_dateview)
    {
        _dateview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH-60, 160)];
        [_dateview setBackgroundColor:HEX_RGB(0xf0f0f0)];
        [self.sifting_scroll addSubview:_dateview];
        [self.sifting_scroll insertSubview:_dateview belowSubview:self.sifting_scrTop];
    }
    return _dateview;
}


#pragma mark - Controllerlife
#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:YES];
    isSearch = NO;
    [self showVender:YES andVenderName:nil];
    if ([self.order_arr count] == 0)
    {
        if (_open_num > 0)
        {
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有订单"];
        }
    }
    _open_num++;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self showTitel:YES andTitelText:@"订货端"];
    [self showShoppingCar:YES];
    //tableView
    [self.tableView setFrame:CGRectMake(0.0f, TOPVIEW_HEIGHT, self.view.frame.size.width, SCREEN_HEIGHT- Titel_HEIGHT -TabBar_HEIGHT - TOPVIEW_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderListService queryOrderData];
    ///topView
    [self.view addSubview:self.topView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateData:) name:@"orderUpdate" object:nil];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.status_tableView)
        return [self.orderListService.status_arr count];
    else if (tableView == self.pay_status_tableView)
        return [self.orderListService.pay_status_arr count];
    else
        return [self.order_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.status_tableView)
    {
        DHBOrderSiftingStatusTableViewCell  *cell= [tableView dequeueReusableCellWithIdentifier:identifier_2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic = [self.orderListService.status_arr safeObjectAtIndex:indexPath.row];
        cell.name_lb.text = [dic EncodeStringFromDicWithKey:@"name"];
        if ([[dic EncodeStringFromDicWithKey:@"value"] isEqualToString:self.orderListService.status])
        {
            [cell.select_img setImage:[UIImage imageNamed:@"check"]];
            cell.name_lb.textColor = [UIColor TextRed_Color];
        }
        else
        {
            [cell.select_img setImage:[UIImage imageNamed:@"uncheck"]];
            cell.name_lb.textColor = [UIColor TextBlack_Color];
        }
        return cell;
    }
    else if (tableView == self.pay_status_tableView)
    {
        DHBOrderSiftingStatusTableViewCell  *cell= [tableView dequeueReusableCellWithIdentifier:identifier_3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic = [self.orderListService.pay_status_arr safeObjectAtIndex:indexPath.row];
        cell.name_lb.text = [dic EncodeStringFromDicWithKey:@"name"];
        if ([[dic EncodeStringFromDicWithKey:@"value"] isEqualToString:self.orderListService.pay_status])
        {
            [cell.select_img setImage:[UIImage imageNamed:@"check"]];
            cell.name_lb.textColor = [UIColor TextRed_Color];
        }
        else
        {
            [cell.select_img setImage:[UIImage imageNamed:@"uncheck"]];
            cell.name_lb.textColor = [UIColor TextBlack_Color];
        }
        return cell;
    }
    else
    {
        OrderListTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
        if (!orderCell)
        {
            orderCell = [[OrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
            orderCell.delegate = self;
        }
        OrderModuleDTO *order = [self.order_arr safeObjectAtIndex:indexPath.row];
        [orderCell updateViewWithOrderDTO:order];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return orderCell;
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.status_tableView)
        return 43;
    else if (tableView == self.pay_status_tableView)
        return 43;
    else
        return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.status_tableView)
    {
        NSDictionary *dic = [self.orderListService.status_arr safeObjectAtIndex:indexPath.row];
        self.orderListService.status = [dic EncodeStringFromDicWithKey:@"value"];
        self.orderListService.page = 1;
        [self.orderStatusLabel setText: [dic EncodeStringFromDicWithKey:@"name"]];
        [self.status_tableView reloadData];
        [self.statusViewController dismiss];
    }
    else if (tableView == self.pay_status_tableView)
    {
        NSDictionary *dic = [self.orderListService.pay_status_arr safeObjectAtIndex:indexPath.row];
        self.orderListService.pay_status = [dic EncodeStringFromDicWithKey:@"value"];
        self.orderListService.page = 1;
        [self.payStatusLabel setText: [dic EncodeStringFromDicWithKey:@"name"]];
        [self.pay_status_tableView reloadData];
        [self.pay_statusViewController dismiss];
    }
    else
    {
        OrderModuleDTO *order = [self.order_arr safeObjectAtIndex:indexPath.row];
        DHBOrderDetailsViewController *orderDetails = [[DHBOrderDetailsViewController alloc] init];
        orderDetails.orderDetailsService.orders_id = order.orders_id;
        [self.navigationController pushViewController:orderDetails animated:YES];
    }
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    self.orderListService.page = 1;
    [self.orderListService queryOrderData];
    [self ShowFootView:NO];
}

-(void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.orderListService cpage] < [self.orderListService totalPage])
    {
        self.orderListService.page = self.orderListService.cpage+1;
        [self.orderListService queryOrderData];
        [self ShowFootView:NO];
    }
    else
    {
        if ([self.order_arr count] > 0)
        {
            [self ShowFootView:YES];
        }
        [self loadOver];
    }
}


#pragma mark OrderListServiceDelegate
-(void)orderListServiceComplete:(OrderListService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        if (service.cpage == 1)
        {
            [self.order_arr removeAllObjects];
        }
        [self.order_arr addObjectsFromArray:service.orderlist];
        [self.tableView reloadData];
        [self createFooterView];
        ////数据为空
        if([self.order_arr count] == 0)
        {
            if ([service isAllOrder])
                [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有订单"];
            else
                [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"无相关订单"];
        }
    }
    else{
        [self.order_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
    [_refreshFooterView setState:EGOOPullRefreshNormal];
    [_refreshHeaderView setState:EGOOPullRefreshNormal];
    _reloading = NO;
}

#pragma mark ButtonAction
//搜索
- (void)searchAction:(UIButton *)sender{
    isSearch = YES;
    DHBSearchViewController *search = [[DHBSearchViewController alloc] init];
    search.delegate = self;
    search.table_name = @"order_history";
    search.search_text = self.orderListService.content?self.orderListService.content:@"";
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark -
#pragma mark 打开筛选页面
- (void)siftingAction:(UIButton *)sender {
    if (self.orderListService.status_arr && self.orderListService.pay_status_arr)
    {
//        self.orderListService.content = @"";
        [self.siftingView show];
    }
    else
    {
        WS(weakSelf);
        [self.orderListService querySiftingDataCallBack:^(BOOL is_success) {
            if (is_success) [weakSelf.siftingView show];
        }];
    }
}

#pragma mark 清空筛选
- (IBAction)cleanSiftingAction:(UIButton *)sender {
    [self.concern_lb setTextColor:[UIColor TextGray_Color]];
    [self.concern_img setImage:[UIImage imageNamed:@"uncheck"]];
    self.orderListService.is_attention = @"F";
    self.orderListService.status = @"all";
    self.orderListService.pay_status = @"all";
    self.orderListService.begin_date = @"";
    self.orderListService.end_date = @"";
    self.payStatusLabel.text = @"全部";
    self.orderStatusLabel.text = @"全部";
//    _search_lb.text = @"订单号/商品名称";
    [self.date_btn1 setTitle:@"" forState:UIControlStateNormal];
    [self.date_btn2 setTitle:@"" forState:UIControlStateNormal];
    [self.status_tableView reloadData];
    [self.pay_status_tableView reloadData];
}

#pragma mark 筛选确认按钮
- (IBAction)sureSiftingAction:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString: [self.orderListService begin_date]];
    NSDate *endDate = [dateFormatter dateFromString: [self.orderListService end_date]];
    if(![startDate isEqualToDate: endDate]){
        if([[startDate laterDate: endDate] isEqual: startDate]){
            [self.tipView showInSuperView: [[UIApplication sharedApplication] keyWindow] message: @"开始时间不能大于结束时间"];
            return;
        }
    }
    [self.siftingView dismiss];
    [self.orderListService setPage: 1];
    [self.orderListService queryOrderData];
}


#pragma mark 打开订单的时间选择
- (IBAction)showDateAction:(UIButton *)sender {
    [self.dateview removeAllSubviews];
    RBCustomDatePickerView *pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.dateview.frame.size.width, self.dateview.frame.size.height)];
    pickerView.tag = sender.tag;
    pickerView.delegate = self;
    //    [pickerView setIslimitDate: NO];
//    pickerView.middleSepView_frame = CGRectMake(0, 55, SCREEN_WIDTH, 38);
//    pickerView.timeBroadcastView_frame = CGRectMake(20, 0, self.dateview.frame.size.width-40, 100.0);
//    pickerView.OkBtn_frame = CGRectMake(self.dateview.frame.size.width-40-50, self.dateview.frame.size.height-50, 50, 20);
//    pickerView.NOBtn_frame = CGRectMake(40, self.dateview.frame.size.height-50, 50, 20);
//    [pickerView setTimeBroadcastView];
    
    [self.dateview addSubview:pickerView];
    WS(weakSelf)
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.dateview.top = 220;
        if (weakSelf.sifting_scroll.bottom < 220+self.dateview.frame.size.height)
        {
            CGFloat h= weakSelf.sifting_scroll.bottom-(220+self.dateview.frame.size.height+35);
            [weakSelf.sifting_scroll setContentOffset:CGPointMake(0, -h) animated:NO];
        }
        weakSelf.sifting_scroll.bouncesZoom = NO;
    } completion:^(BOOL finished) {
        weakSelf.sifting_scroll.scrollEnabled = NO;
    }];
}

#pragma mark 通知修改列表数据
-(void)UpdateData:(NSNotification *)noti{
    if ([noti.userInfo objectForKey:@"order"])
    {
        WS(weakSelf);
        OrderModuleDTO *order = [noti.userInfo objectForKey:@"order"];
        __block BOOL is_add = YES;
        [self.order_arr enumerateObjectsUsingBlock:^(OrderModuleDTO* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.orders_id == order.orders_id)
            {
                is_add = NO;
                [self.orderListService queryOrder:obj.orders_id Order:^(OrderModuleDTO *order) {
                    obj.status = [NSString stringWithString:order.status];
                    obj.is_pay = [NSString stringWithString:order.is_pay];
                    obj.account_notpaid = [NSString stringWithString:order.account_notpaid];
                    obj.account_paid = [NSString stringWithString:order.account_paid];
                    [weakSelf.tableView reloadData];
                }];
            }
        }];
        if (is_add)
        {
            [self.orderListService queryOrderData];
        }
    }
}


#pragma mark 我的收藏点击事件
- (IBAction)concernAction:(UIButton *)sender {
    self.is_concern = !self.is_concern;
    if (self.is_concern)
    {
        [self.concern_lb setTextColor:[UIColor TextRed_Color]];
        [self.concern_img setImage:[UIImage imageNamed:@"check"]];
        self.orderListService.is_attention = @"T";
    }
    else
    {
        [self.concern_lb setTextColor:[UIColor TextGray_Color]];
        [self.concern_img setImage:[UIImage imageNamed:@"uncheck"]];
        self.orderListService.is_attention = @"F";
    }
}

#pragma mark 订单状态点击事件
- (IBAction)orderTypeAction:(UIButton *)sender {
    [self.statusViewController show];
}

#pragma mark 付款状态的点击事件
- (IBAction)payTypeAction:(UIButton *)sender {
    [self.pay_statusViewController show];
}


#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated{
    if(sideBar == self.statusViewController)
    {
    }
    else if (sideBar == self.pay_statusViewController)
    {
    }
    else
    {
//        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + TabBar_HEIGHT)];
//        background.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//        background.opaque = NO;
//        self.shareBackGroundView = background;
        [self.view addSubview: self.shareBackGroundView];
        MainPageViewController *root = (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [root makeTabBarMask: YES];
        WS(weakSelf);
        [self showBackgroundView:YES onClick:^{
            [weakSelf.siftingView dismiss];
        }];
    }
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated{
    if(sideBar == self.statusViewController)
    {
    }
    else if (sideBar == self.pay_statusViewController)
    {
    }
    else
    {
        [self.shareBackGroundView removeFromSuperview];
        [self showBackgroundView:NO onClick:nil];
        MainPageViewController *root = (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [root makeTabBarMask: NO];
    }
}

#pragma mark - DHBSearchViewControllerDelegate
#pragma mark 搜索结果
-(void)DHBSearchViewController:(UIViewController*)searchViewController searchText:(NSString*)search{
    self.orderListService.content = search;
    [self cleanSiftingAction:nil];
    [self.orderListService setPage: 1];
    [self.orderListService queryOrderData];
    ///
    [_search_lb setText:[search isEqualToString:@""] ? @"订单号/商品名称" : search];
}

#pragma mark - RBCustomDatePickerViewDelegate
-(void)RBCustomDatePickerView:(RBCustomDatePickerView*)pickerView selectOkAction:(NSString*)selectTime{
    switch (pickerView.tag)
    {
        case 1:
            [self.date_btn1 setTitle:selectTime forState:UIControlStateNormal];
            [self.orderListService setBegin_date: selectTime];
            break;
        case 2:
             [self.date_btn2 setTitle:selectTime forState:UIControlStateNormal];
            [self.orderListService setEnd_date: selectTime];
            break;
        default:
            break;
    }
    WS(weakSelf)
    [UIView animateWithDuration:.5 animations:^{
        [weakSelf.sifting_scroll setContentOffset:CGPointMake(0, 0) animated:NO];
        weakSelf.sifting_scroll.bouncesZoom = NO;
        weakSelf.dateview.top = -20;
        
    } completion:^(BOOL finished) {
        weakSelf.sifting_scroll.scrollEnabled = YES;
    }];
}

-(void)selectNOAction{
    WS(weakSelf)
    [UIView animateWithDuration:.5 animations:^{
        [weakSelf.sifting_scroll setContentOffset:CGPointMake(0, 0) animated:NO];
        weakSelf.sifting_scroll.bouncesZoom = NO;
        weakSelf.dateview.top = -20;
    } completion:^(BOOL finished) {
        weakSelf.sifting_scroll.scrollEnabled = YES;
    }];
}

#pragma mark - OrderListTableViewCellDelegate
-(void)OrderListTableViewCell:(OrderListTableViewCell *)cell withOrder:(OrderModuleDTO *)order{
    DHBRechargeMethodViewController *recharge = [[DHBRechargeMethodViewController alloc] init];
    recharge.mainService.order = order;
    [self.navigationController pushViewController:recharge animated:YES];
}

//#pragma mark - navigationBarMaskViewClick 点击导航栏的遮挡视图
//- (void)navigationBarMaskViewClick{
//    [self.siftingView dismiss];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
