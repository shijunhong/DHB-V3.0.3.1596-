//
//  DHBPaymentRecordListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/28.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//
#define BOTOMVIEW_HEIGHT 68.0F
#import "DHBPaymentRecordListViewController.h"
#import "DHBPaymentRecordListCell.h"
#import "DHBPaymentRecordDetailsViewController.h"
#import "DHBRechargeMethodViewController.h"

@interface DHBPaymentRecordListViewController ()
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation DHBPaymentRecordListViewController


-(DHBPaymentRecordListService *)service{
    if (!_service)
    {
        _service = [[DHBPaymentRecordListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height- BOTOMVIEW_HEIGHT -Titel_HEIGHT, SCREEN_WIDTH, BOTOMVIEW_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
        
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, (BOTOMVIEW_HEIGHT - DEFAULT_BUTTON_HEIGHT) / 2.0f, SCREEN_WIDTH-30, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue3];
        if ([self.service.order.pay_status isEqualToString:@"已付款"]||[self.service.order.status isEqualToString:@"已取消"])
        {
            [btn setEnabled:NO];
        }
        [btn setBackgroundColor: [UIColor clearColor]];
        [btn setTitle:@"付款" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTabBar: NO];
    [self showBack: YES];
    [self showTitel:YES andTitelText:@"付款记录"];
    [self showShoppingCar: NO];
    [self.view addSubview:self.bottomView];
    ///
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - self.bottomView.height)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    
    ///
    [self.service queryListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - DHBPaymentRecordListServiceDelegate
- (void)DHBPaymentRecordListComplete: service isSuccess:(BOOL)isSuccess{
    if(isSuccess)
    {
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.service floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floor = [[self.service floorsArray] safeObjectAtIndex:section];
    return floor.floors;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBPaymentRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell)
    {
        cell = [[DHBPaymentRecordListCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    HomeFloorDTO *dto = [[self.service floorsArray] safeObjectAtIndex:[indexPath section]];
    [cell updateViewWithFloorDTO:dto whitIndex:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [[self.service floorsArray] safeObjectAtIndex:indexPath.section];
    if ([floor.floorName isEqualToString:@"付款记录"])
    {
        NSDictionary *data = [[self.service dataArray] safeObjectAtIndex:indexPath.row];
        DHBPaymentRecordDetailsViewController *paymentRecordDetails = [[DHBPaymentRecordDetailsViewController alloc] init];
        [paymentRecordDetails.mainService setPayment_id: [data objectForKey: @"payment_id"]];
        [self.navigationController pushViewController:paymentRecordDetails animated:YES];
    }
}

-(void)payAction:(UIButton*)sender{
    DHBRechargeMethodViewController *rechargeMethod = [[DHBRechargeMethodViewController alloc] init];
    rechargeMethod.mainService.order = self.service.order;
    [self.navigationController pushViewController:rechargeMethod animated:YES];
}

@end
