//
//  DHBCorporateFinancialViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/31/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCorporateFinancialViewController.h"
@implementation DHBCorporateFinancialViewController

#pragma mark - mainService
- (DHBCorporateFinancialService *)mainService{
    if(!_mainService){
        _mainService = [[DHBCorporateFinancialService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}


#pragma mark - compeleteButton
- (UIButton *)compeleteButton{
    if(!_compeleteButton){
        _compeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- 15.0f -18*2, 20.0f, 18*2, self.navigationView.height-20.0f)];
        [_compeleteButton setTitle: @"确定" forState: UIControlStateNormal];
        [_compeleteButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_compeleteButton.titleLabel setFont: [UIFont systemFontOfSize:18.0f]];
//        [tmpbutton setTitleEdgeInsets: UIEdgeInsetsMake(0.0f, 25.0f, 0.0f, 0.0f)];
        [_compeleteButton addTarget: self action: @selector(compeleteButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        ///
//        _compeleteButton = [[UIBarButtonItem alloc] initWithCustomView: tmpbutton];
    }
    return _compeleteButton;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showShoppingCar: NO];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"公司财务信息"];
    ///navigation right barButton
//    [self.navigationItem setRightBarButtonItem: self.compeleteButton];
    ///tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorColor: [UIColor CellLine_Color]];
    if([self.tableView respondsToSelector: @selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins: UIEdgeInsetsMake(0, 15.0f, 0.0f, 15.0f)];
    }
    if([self.tableView respondsToSelector: @selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:  UIEdgeInsetsMake(0, 15.0f, 0.0f, 15.0f)];
    }
    //footer
    DHBCorporateFinancialFooterView *footerView = [[DHBCorporateFinancialFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 80.0f)];
    [self.tableView setTableFooterView: footerView];
    ///service
    [self.mainService queryData];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.compeleteButton];
}

#pragma mark - DHBCorporateFinancialService delegate
- (void)corporateFinancialService_Compelete:(id)service isSuccess:(BOOL)isSuccess{
    self.mainService = service;
    [self.tableView reloadData];
}

- (void)corporateFinancialService_DidSubitCompelete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.mainService floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.mainService floorsArray]  objectAtIndex: section] floors];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBCorporateFinancialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell)
    {
        cell = [[DHBCorporateFinancialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    [cell setDelegate: self];
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    NSMutableArray *dataArray = [[floorDTO moduleList] objectAtIndex: [indexPath row]];
    [cell updateData:dataArray];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell respondsToSelector: @selector(setLayoutMargins:)]){
        [cell setLayoutMargins:  UIEdgeInsetsMake(0, 15.0f, 0.0f, 15.0f)];
    }
    if([cell respondsToSelector: @selector(setSeparatorInset:)]){
        [cell setSeparatorInset:  UIEdgeInsetsMake(0, 15.0f, 0.0f, 15.0f)];
    }
}


#pragma mark - button click
- (void)compeleteButtonClick:(UIButton *) sender{
    
    ///提交修改的公司信息
    [self.mainService submitCorporateFinancialData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
