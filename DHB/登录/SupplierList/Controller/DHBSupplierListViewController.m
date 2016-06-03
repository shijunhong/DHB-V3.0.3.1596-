//
//  DHBSupplierListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSupplierListViewController.h"

@implementation DHBSupplierListViewController
#pragma mark - getters and setters
- (DHBSupplierListService *)mainService{
    if(!_mainService){
        _mainService = [[DHBSupplierListService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

-(UIView *)navigationView{
    if (!_navigationView)
    {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, SCREEN_WIDTH, Titel_HEIGHT)];
        [_navigationView setBackgroundColor:[[UIColor NavBack_Red_Color] colorWithAlphaComponent:1.0f]];
        [_navigationView addSubview:self.titel_lb];
        [_navigationView addSubview:self.back_btn];
    }
    return _navigationView;
}

-(UIButton *)back_btn{
    if (!_back_btn) {
        _back_btn = [[UIButton alloc] init];
        [_back_btn setTop: 20.0f];
        [_back_btn setLeft:0.0f];
        [_back_btn setHeight:Titel_HEIGHT - 20.0f];
        [_back_btn setWidth: 22+20];
        [_back_btn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
        [_back_btn setImage:[UIImage imageNamed:@"back_focused"] forState:UIControlStateHighlighted];
        [_back_btn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_back_btn setBackgroundColor: [UIColor clearColor]];
    }
    return _back_btn;
}

-(UILabel *)titel_lb{
    if (!_titel_lb)
    {
        _titel_lb = [[UILabel alloc] init];
        [_titel_lb setTop:32];
        [_titel_lb setLeft:SCREEN_WIDTH/2-200/2];
        [_titel_lb setHeight:20];
        [_titel_lb setWidth:200];
        [_titel_lb setTextAlignment:NSTextAlignmentCenter];
        [_titel_lb setFont:[UIFont systemFontOfSize:18]];
        [_titel_lb setTextColor:HEX_RGB(0xffffff)];
        [_titel_lb setText:  @"平台选择"];
    }
    return _titel_lb;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, Titel_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
        [_mainTableView setDataSource: self];
        [_mainTableView setDelegate: self];
        [_mainTableView setBackgroundColor: [UIColor clearColor]];
        [_mainTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        UIView *footerView = [[UIView alloc] init];
        [footerView setBackgroundColor: [UIColor clearColor]];
        [_mainTableView setTableFooterView: footerView];
    }
    return _mainTableView;
}

#pragma mark - load
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview: self.navigationView];
    [self.view addSubview: self.mainTableView];
    [self.view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    //service
    [self.mainService querDataList];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - DHBSupplierListService_Delegate
- (void)DHBSupplierListService_Compelete:(id)service isSueccess:(BOOL)isSuccess{
    self.mainService = service;
    if(isSuccess){
        [self.mainTableView reloadData];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: (self.mainService.message ? self.mainService.message : @"数据获取出错") delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)DHBSupplierListService_SelectedSupplier:(id)service isSueccess:(BOOL)isSuccess{
    if(isSuccess)
    {
        
        [[ParameterPublic sharedManagered] setCompany_name: [curOperateDTO name]];
        ////设置根视图
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[MainPageViewController alloc] init];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: (self.mainService.message ? self.mainService.message : @"数据获取出错") delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - tableView datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mainService.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBSupplierListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBSupplierListTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    DHBSupplierModuleDTO *dto = [self.mainService.dataArray objectAtIndex: [indexPath row]];
    [cell updateViewWithDTO:dto CompanyID:self.company_id];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.mainTableView];
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    curOperateDTO = [[self.mainService dataArray] objectAtIndex: [indexPath row]];
    if([curOperateDTO is_login]){
        [self.mainService setCompany_id: [curOperateDTO company_id]];
        [self.mainService selectSupplier];
    }
}

#pragma mark - 返回按钮点击事件
- (void)backButtonClick{
    [self dismissViewControllerAnimated: YES completion: nil];
}
@end

