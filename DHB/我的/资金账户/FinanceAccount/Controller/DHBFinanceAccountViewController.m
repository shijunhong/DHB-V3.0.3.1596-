//
//  DHBFinanceAccountViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBFinanceAccountViewController.h"
#import "DHBPaymentHistoryController.h"
@interface DHBFinanceAccountViewController ()
@property(nonatomic,strong)DHBFinanceAccountHeaderView *headerView;

@end

@implementation DHBFinanceAccountViewController
#pragma mark - init
-(DHBFinanceAccountService *)mainService{
    if (!_mainService)
    {
        _mainService = [[DHBFinanceAccountService alloc] init];
        _mainService.delegate = self;
    }
    return _mainService;
}

-(DHBFinanceAccountHeaderView *)headerView{
    if (!_headerView)
    {
        _headerView = [[DHBFinanceAccountHeaderView  alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 310.0f)];
        [_headerView setDelegate: self];
    }
    return _headerView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.mainService queryFinanceAccountData];
    [self showTabBar: NO];
    [self showBack: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel: YES andTitelText:@"资金账户"];
    ///tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setScrollEnabled: NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setTableHeaderView: self.headerView];
}

#pragma mark - DHBFinanceAccountServiceDelegate
- (void)financeAccountServiceComplete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.tableView reloadData];
        [self.headerView setFinanceLabelText: [NSString stringWithFormat:@"%@ %@",[self.mainService.myInfo EncodeStringFromDicWithKey:@"balance"],L(@"元")]];
    }
}


#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
        [cell.contentView initLineisBottom:NO];
        [cell.contentView initSectionView];
        [cell.textLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [cell.textLabel setTextColor: [UIColor TextBlack_Color]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ///自定义箭头
        CGFloat origin_x = SCREEN_WIDTH - 30.0f;
        UIImageView *_arrowimageView = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, 0.0f, 30.0f / 1.3f, 50.0f)];
        [_arrowimageView setContentMode: UIViewContentModeScaleAspectFit];
        [_arrowimageView setImage: [UIImage imageNamed: @"arrow"]];
        [cell addSubview: _arrowimageView];
    }
    if (indexPath.row == 0)
    {
        [cell.textLabel setText: @"收支明细"];
    }
    else if (indexPath.row == 1)
    {
        [cell.textLabel setText: @"支付记录"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f+DEFAULT_SECTION_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 )
    {
        DHBPaymentsListViewController *listVC = [[DHBPaymentsListViewController alloc] init];
        [self.navigationController pushViewController: listVC animated: YES];
    }
    else if (indexPath.row == 1)
    {
        DHBPaymentHistoryController *payHistory = [[DHBPaymentHistoryController alloc] init];
        [self.navigationController pushViewController: payHistory animated: YES];
    }
}


#pragma mark -  DHBFinanceAccountHeaderView_Delegte
- (void)financeAccountHeaderView_DidRechargeButton:(UIButton *)button{
    DHBRechargeMethodViewController *rechargeMethodVC = [[DHBRechargeMethodViewController alloc] init];
    [self.navigationController pushViewController: rechargeMethodVC animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
