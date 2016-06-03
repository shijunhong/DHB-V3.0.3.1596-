//
//  DHBAddressDeliveryViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define FOOTER_HEIGHT 78.0f
#import "DHBAddressDeliveryViewController.h"
#import "DHBAddAddressViewController.h"
#import "DHBAddressListTableViewCell.h"
#import "UserInformationModuleDTO.h"
#import "DHBAddressSubmitRequest.h"
@interface DHBAddressDeliveryViewController ()<AddressListServiceDelegate,DHBAddressListTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)NSMutableArray *address_arr;
@property(nonatomic,strong)UIButton *edit_btn;
@end

@implementation DHBAddressDeliveryViewController

#pragma mark - lazyload

-(UIButton *)edit_btn{
    if (!_edit_btn)
    {
        _edit_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-18*2, 20.0f, 18*2, self.navigationView.height-20.0f)];
        [_edit_btn setTitle:@"删除" forState:UIControlStateNormal];
        [_edit_btn setTitle:@"完成" forState:UIControlStateSelected];
        [_edit_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_edit_btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_edit_btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edit_btn;
}

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (FOOTER_HEIGHT - TabBar_HEIGHT))];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-FOOTER_HEIGHT, SCREEN_WIDTH, FOOTER_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
        
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, (FOOTER_HEIGHT - DEFAULT_BUTTON_HEIGHT) / 2.0f, SCREEN_WIDTH-30, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue3];
        [btn setTitle:@"新增收货地址" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}


-(AddressListService *)service{
    if (!_service)
    {
        _service = [[AddressListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(NSMutableArray *)address_arr{
    if (!_address_arr)
    {
        _address_arr = [[NSMutableArray alloc] init];
    }
    return _address_arr;
}



#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
    [self.service queryAddressListlData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"收货地址"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.edit_btn];
}

#pragma mark TreeView UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.address_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModuleDTO *address = [self.address_arr safeObjectAtIndex:indexPath.section];
    DHBAddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (!cell)
    {
        cell = [[DHBAddressListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
    }
    cell.delegate = self;
    cell.is_orderSelct = self.type == SELECT?YES:NO;
    [cell updateView:address];
    return cell;
}

#pragma mark  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0 ? 0.0f : DEFAULT_SECTION_HEIGHT);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModuleDTO *address = [self.address_arr safeObjectAtIndex:indexPath.section];
    switch (self.type)
    {
        case SELECT:
        {
            [self.delegate addressDeliveryViewController:self address:address];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case LOOK:
        {
            DHBAddAddressViewController *addaddress = [[DHBAddAddressViewController alloc] init];
            addaddress.address = address;
            addaddress.titName = @"编辑收货地址";
            [self.navigationController pushViewController:addaddress animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        AddressModuleDTO *address = [self.address_arr safeObjectAtIndex:indexPath.section];
        DHBAddressSubmitRequest *request = [[DHBAddressSubmitRequest alloc] init];
        request.address = address;
        request.delete_flag = @"T";
        WS(weakSelf);
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            if ([[dic objectForKey:@"code"] intValue] ==100){
                if ([[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 1)
                {
                    [weakSelf.address_arr removeObjectAtIndex:indexPath.section];
//                    [weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [weakSelf.tableView deleteSections: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(indexPath.section, 1)] withRowAnimation: UITableViewRowAnimationAutomatic];
                    if([self.address_arr count] == 0){
                        [self.edit_btn setHidden: YES];
                        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有收货地址"];
                    }
                }
            }
        } failure:nil];
    }
}

#pragma mark ButtonAction
-(void)addAddressAction:(UIButton *)sender{
    DHBAddAddressViewController *addAddress = [[DHBAddAddressViewController alloc] init];
    [self.navigationController pushViewController:addAddress animated:YES];
}

-(void)editAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.tableView setEditing:sender.selected animated:YES];
    
}

#pragma mark AddressListServiceDelegate
-(void)addressListServiceComplete:(AddressListService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.address_arr = service.dataArray;
        [self.tableView reloadData];
        ///数据为空
        [self.edit_btn setHidden: NO];
        if([self.address_arr count] == 0){
            [self.edit_btn setHidden: YES];
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您还没有收货地址"];
        }
    }
    else
    {
        [self.address_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"网络链接错误"];
    }
}


#pragma mark DHBAddressListTableViewCellDelegate
-(void)DHBAddressListTableViewCell:(DHBAddressListTableViewCell *)cell onClickupdate:(UIButton *)sender{
    DHBAddAddressViewController *addaddress = [[DHBAddAddressViewController alloc] init];
    addaddress.address = cell.address;
    addaddress.titName = @"编辑收货地址";
    [self.navigationController pushViewController:addaddress animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
