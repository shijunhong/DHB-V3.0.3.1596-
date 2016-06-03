//
//  DHBPaymentHistoryController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentHistoryController.h"
#import "HomeFloorDTO.h"
#import "DHBPaymentsTableViewCell.h"
#import "DHBPayHistoryInfoModuleDTO.h"
#import "DHBPaymentHistoryCell.h"
#import "CDRTranslucentSideBar.h"
#import "DHBPaymentsSiftingView.h"
#import "DHBPaymentsOptionView.h"
#import "DHBPaymentsDetailsViewController.h"
#define CELL_HEIGHT 70.0f
@interface DHBPaymentHistoryController ()<DHBPaymetHistoryService_Delegate,DHBPayHistorySiftingService_Delegate,CDRTranslucentSideBarDelegate, DHBPaymentsSiftingView_Delegate, DHBPaymentsOptionView_Delegate>{
    BOOL isGetSiftingData;
}
@property(nonatomic, retain) UIButton *filterButton;
@property (strong, nonatomic)CDRTranslucentSideBar *siftingViewController;
@property(nonatomic, retain) DHBPaymentsSiftingView *siftingMainView;
@property (strong, nonatomic)CDRTranslucentSideBar *optionViewController;
@property(nonatomic, retain) DHBPaymentsOptionView *optionMainView;
@property (nonatomic,strong) UIView *maskView;
@property(nonatomic, retain) DHBTipView *tipView;
@end

@implementation DHBPaymentHistoryController

- (DHBTipView *)tipView{
    if(!_tipView)
    {
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

-(DHBPaymetHistoryService *)mainService{
    if (!_mainService)
    {
        _mainService = [[DHBPaymetHistoryService alloc] init];
        _mainService.delegate = self;
    }
    return _mainService;
}

-(DHBPayHistorySiftingService *)siftingService{
    if (!_siftingService)
    {
        _siftingService = [[DHBPayHistorySiftingService alloc] init];
        _siftingService.delegate = self;
    }
    return _siftingService;
}

-(CDRTranslucentSideBar *)siftingViewController{
    if (!_siftingViewController)
    {
        _siftingViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        [_siftingViewController setSideBarWidth: SCREEN_WIDTH - 60.0f];
        [_siftingViewController setDelegate: self];
        [_siftingViewController setTranslucentAlpha: 0.0f];
        [_siftingViewController setTag: 0];
        [_siftingViewController setContentViewInSideBar: self.siftingMainView];
    }
    return _siftingViewController;
}

- (DHBPaymentsSiftingView *)siftingMainView{
    if(!_siftingMainView){
        _siftingMainView = [[DHBPaymentsSiftingView alloc] init];
        [_siftingMainView setDelegate: self];
    }
    return _siftingMainView;
}

-(CDRTranslucentSideBar *)optionViewController{
    if (!_optionViewController)
    {
        _optionViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        [_optionViewController setSideBarWidth: SCREEN_WIDTH - 60.0f];
        [_optionViewController setDelegate: self];
        [_optionViewController setTranslucentAlpha: 0.0f];
        [_optionViewController setTag: 1];
        [_optionViewController setContentViewInSideBar: self.optionMainView];
    }
    return _optionViewController;
}

- (DHBPaymentsOptionView *)optionMainView{
    if(!_optionMainView){
        _optionMainView = [[DHBPaymentsOptionView alloc] init];
        [_optionMainView setDelegate: self];
    }
    return _optionMainView;
}


- (UIButton *)filterButton{
    if(!_filterButton){
        _filterButton = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH-15-18*2, 20.0f, 18*2, self.navigationView.height-20.0f)];
        [_filterButton setTitle: @"筛选" forState: UIControlStateNormal];
        [_filterButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_filterButton.titleLabel setFont: [UIFont systemFontOfSize:18.0f]];
        //        [_filterButton setTitleEdgeInsets: UIEdgeInsetsMake(0.0f, 30.0f, 0.0f, 0.0f)];
        [_filterButton addTarget: self action: @selector(filterButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _filterButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"支付记录"];
    //navigation
    //    [self.navigationItem setRightBarButtonItem: self.filterButton];
    //tableView
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    //service 请求数据
    [self.mainService queryListData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.filterButton];
}


#pragma mark - DHBPaymentsListService_Delegate
- (void)paymentHistoryService_omplete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess)
    {
        self.mainService = service;
        [self.tableView reloadData];
        ///
        if([[self.mainService floorsArray] count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"暂无相关支付记录"];
        }
    }
    else{
        [[self.mainService floorsArray] removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}


#pragma mark - tabelView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.mainService floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: section];
    return [[floorDTO moduleList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBPaymentHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HistoryCell"];
    if(!cell){
        cell = [[DHBPaymentHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
    }
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray]  objectAtIndex: [indexPath section]];
    DHBPayHistoryInfoModuleDTO *dto = [[floorDTO moduleList] objectAtIndex: [indexPath row]];
    [cell updateViewWithDTO: dto];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: section];
    return [floorDTO sectionHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: section];
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10.0f, 0.0f, SCREEN_WIDTH - 20.0f, floorDTO.sectionHeight)];
    [titleLabel setText: [floorDTO floorName]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setTextColor: HEX_RGB(0x4a4a4a)];
    [view addSubview: titleLabel];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray]  objectAtIndex: [indexPath section]];
    DHBPayHistoryInfoModuleDTO *dto = [[[floorDTO moduleList] objectAtIndex: [indexPath row]] copy];
    DHBPaymentsDetailsViewController *detailsVC = [[DHBPaymentsDetailsViewController alloc] init];
    [detailsVC.mainService setPayHistoryDTO: dto];
    detailsVC.mainService.is_payHistory = YES;
    [self.navigationController pushViewController: detailsVC animated: YES];
}


#pragma mark CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated{
    if(sideBar == self.siftingViewController){
        [self.view addSubview: self.maskView];
        WS(weakSelf);
        [self showBackgroundView:YES onClick:^{
            [weakSelf.siftingViewController dismiss];
        }];
    }
}
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated{
    if(sideBar == self.siftingViewController){
        [self.maskView removeFromSuperview];
        [self showBackgroundView:NO onClick:nil];
    }
}

#pragma mark - 筛选按钮
- (void)filterButtonClick:(UIButton *)sender{
    if(!isGetSiftingData){
        ///首次获取数据
        [self.siftingService querySiftingData];
        isGetSiftingData = YES;
    }else{
        [self.siftingViewController show];
    }
}


#pragma mark - DHBPayHistorySiftingService_Delegate
- (void)payHistorySiftingService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.siftingViewController show];
        self.siftingService = service;
        ////
        DHBDepositTypeModuleDTO *dto = [[DHBDepositTypeModuleDTO alloc]  init];
        [dto setName: @"全部"];
        [dto setIs_select: YES];
        [dto setValue: @""];
        [[[self.siftingService siftingDTO] statusArray] insertObject: dto atIndex:0];
        ////
        DHBPayTypeModuleDTO *payTupeDto = [[DHBPayTypeModuleDTO alloc]  init];
        [payTupeDto setName: @"全部"];
        [payTupeDto setIs_select: YES];
        [payTupeDto setValue: @""];
        [[[self.siftingService siftingDTO] typeArray] insertObject: payTupeDto atIndex:0];
    }
}



#pragma mark - DHBPaymentsSiftingView_Delegate
#pragma mark 筛选的时候跳转至相应的子筛选页面
- (void)paymentsSiftingView_DidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == 0){
        [self.optionMainView setDataArray: [[self.siftingService siftingDTO] statusArray]];
        [self.optionMainView setIsPayType: NO];
    }
    else{
        [self.optionMainView setDataArray: [[self.siftingService siftingDTO] typeArray]];
        [self.optionMainView setIsPayType: YES];
    }
    [self.optionMainView.mainTableView reloadData];
    [self.optionViewController show];
}

#pragma mark 清空筛选
- (void)paymentsSiftingView_DidClearButton:(UIButton *)button{
    ///付款类型
    DHBPaymentsSiftingTableViewCell * cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    [cell.depositTypeLabel setText: @"全部"];
    [self.mainService setStatus_id: @""];
    for(DHBDepositTypeModuleDTO *dto in [[self.siftingService siftingDTO] statusArray]){
        if([[dto name] isEqualToString: @"全部"]){
            [dto setIs_select: YES];
        }
        else{
            [dto setIs_select: NO];
        }
    }
    //支付类型
    cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 1 inSection: 0]];
    [cell.payTypeLabel setText: @"全部"];
    [self.mainService setType_id: @""];
    for(DHBDepositTypeModuleDTO *dto in [[self.siftingService siftingDTO] typeArray]){
        if([[dto name] isEqualToString: @"全部"]){
            [dto setIs_select: YES];
        }
        else{
            [dto setIs_select: NO];
        }
    }
    //发货时间
    cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 2 inSection: 0]];
    [self.mainService setBegin_date: @""];
    [self.mainService setEnd_date: @""];
    [cell.startTimeTextFiled setText: @""];
    [cell.endTimeTextField setText: @""];
}

#pragma mark 开始筛选
- (void)paymentsSiftingView_DidOkButton:(UIButton *)button{
    DHBPaymentsSiftingTableViewCell *cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 2 inSection: 0]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString: [cell.startTimeTextFiled text]];
    NSDate *endDate = [dateFormatter dateFromString: [cell.endTimeTextField text]];
    if(![startDate isEqualToDate: endDate]){
        if([[startDate laterDate: endDate] isEqual: startDate]){
            [self.tipView showInSuperView: [[UIApplication sharedApplication] keyWindow] message: @"开始时间不能大于结束时间"];
            return;
        }
    }
    self.mainService.begin_date = [cell.startTimeTextFiled text];
    self.mainService.end_date = [cell.endTimeTextField text];
    [self.mainService queryListData];
    [self.siftingViewController dismiss];
}

#pragma mark - DHBPaymentsOptionView_Delegate
#pragma mark 选中指定的筛选项（类型、付款方式）
- (void)paymentsOptionView_DidSelectRowAtIndexPath:(NSIndexPath *)indexPath isPayType:(BOOL)isPayType{
    [self.optionViewController dismiss];
    ///更新数据
    if(isPayType){
        DHBPayTypeModuleDTO *dto = [[[self.siftingService siftingDTO] typeArray] objectAtIndex: [indexPath row]];
        DHBPaymentsSiftingTableViewCell * cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 1 inSection: 0]];
        [cell.payTypeLabel setText: [dto name]];
        self.mainService.type_id = [dto value];
    }
    else{
        DHBDepositTypeModuleDTO *dto = [[[self.siftingService siftingDTO] statusArray] objectAtIndex: [indexPath row]];
        DHBPaymentsSiftingTableViewCell * cell = [self.siftingMainView.mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
        [cell.depositTypeLabel setText: [dto name]];
        self.mainService.status_id = [dto value];
    }
}
@end
