//
//  MemberCenterViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define FOOTERVIEW_HEIGHT 90.0f
#import "MemberCenterViewController.h"
#import "UMessage.h"
#import "ParameterPublic.h"

@implementation MemberCenterViewController

#pragma mark - setters and getters
//- (NSArray *)titleArray{
//    if(!_titleArray){
//        _titleArray = [NSArray arrayWithObjects: [NSArray arrayWithObject:@"我的账号"], [NSArray arrayWithObjects: @"公司财务信息",@"收货地址", nil], [NSArray arrayWithObjects:@"资金账户",@"快捷支付",@"退货单",@"联系供货商",nil], [NSArray arrayWithObjects:@"关于订货宝",@"系统建议与反馈",nil], nil];
//    }
//    return _titleArray;
//}

- (DHBMemberCenterService *)mainService{
    if(!_mainService){
        _mainService = [[DHBMemberCenterService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

#pragma mark - load
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self showTabBar:YES];
    ///获取会员信息
    [self.mainService queryMemberData];
    [self showVender:YES andVenderName:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showShoppingCar: YES];
//    [self showTitel:YES andTitelText:@"我的"];
    ///设置tableview
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - TabBar_HEIGHT - Titel_HEIGHT)];
    [self removeHeaderView];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
}

#pragma mark - DHBMemberCenterService_Delegate
- (void)memberCenterSerivce_RequestMemberDataFinish:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.tableView reloadData];
        //footerView
        MemberCenterFooterView *footerView = [[MemberCenterFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, FOOTERVIEW_HEIGHT)];
        [footerView setDelegate: self];
        [self.tableView setTableFooterView: footerView];
    }
    else{
        [self.mainService.floorArray removeAllObjects];
        [self.tableView reloadData];
        [self.tableView setTableFooterView: nil];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}

- (void)memberCenterSerivce_LoginOutFinish:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        //移除友盟标签
        [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {
//            [[[DHBTipView alloc] init] showInSuperView:[[UIApplication sharedApplication] keyWindow] message:[NSString stringWithFormat:@"sctag"]];
        }];
//        [UMessage getTags:^(NSSet *responseTags, NSInteger remain, NSError *error) {
//            NSLog_Red(@"responseObject_LoginOut = %@",responseTags);
//        }];
        ///先清空当前账号
        NSUserDefaults *userDefatuls = [NSUserDefaults standardUserDefaults];
        [userDefatuls removeObjectForKey: @"skey"];
        [userDefatuls removeObjectForKey: @"accounts_id"];
        [userDefatuls synchronize];
        ////设置根视图
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[DHBLoginViewController alloc] init]];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.mainService.floorArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floor = [self.mainService.floorArray objectAtIndex: section];
    return [[floor moduleList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseedIndenty = ((indexPath.row == 0 && indexPath.section == 0) ? @"ListCell1" : @"ListCell2");
    DHBMemberCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseedIndenty];
    if(!cell){
        cell = [[DHBMemberCenterTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: reuseedIndenty size: CGSizeMake(tableView.frame.size.width, (indexPath.section + indexPath.row == 0 ? CELL_HEIGHT1 : CELL_HEIGHT2))];
    }
    HomeFloorDTO *floor = [self.mainService.floorArray objectAtIndex: [indexPath section]];
    NSString *floorName = [[floor moduleList] objectAtIndex: indexPath.row];
    if([floorName isEqualToString: @"个人账户"]){
        [cell.subTitleLabel setText: [[ParameterPublic sharedManagered] accounts_name]];
        [cell.subTitleLabel setTextColor: [UIColor TextGray_Color]];
        [cell.titleLabel setHidden: YES];
        [cell.photoImageView setHidden: NO];
    }
    else{
        [cell.titleLabel setHidden: NO];
        [cell.subTitleLabel setTextColor: [UIColor TextGray_Color]];
        [cell.photoImageView setHidden: YES];
        if([floorName isEqualToString: @"资金账户"]){
            [cell.subTitleLabel setText: [NSString stringWithFormat:@"¥%@", [self.mainService.memberInfo memberBalance]]];
            [cell.subTitleLabel setTextColor: [UIColor Money_Color]];
        }
        else if([floorName isEqualToString: @"快捷支付"]){
            [cell.subTitleLabel setText: ([self.mainService.memberInfo isOpenQuicklyPay] ? @"已开通" : @"未开通")];
        }
        else{
            [cell.subTitleLabel setText: @""];
        }
    }
    ///分割线
    [cell.topLineView setHidden: NO];
    if([indexPath row] > 0){
        [cell.topLineView setHidden: YES];
    }
    if([indexPath row] != [[floor moduleList] count] - 1){
        [cell.bottomLineView setLeft: 15.0f];
        [cell.bottomLineView setWidth: SCREEN_WIDTH - 15.0f];
    }
    [cell.titleLabel setText: floorName];
    ///选中背景图
    UIView *selectView = [[UIView alloc]  init];
    [selectView setBackgroundColor: HEX_RGB(0xe8e8e8)];
    [cell setSelectedBackgroundView: selectView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [self.mainService.floorArray objectAtIndex: [indexPath section]];
    return [floor hight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    HomeFloorDTO *floor = [self.mainService.floorArray objectAtIndex: [indexPath section]];
    NSString *floorName = [[floor moduleList] objectAtIndex: indexPath.row];
    if([floorName isEqualToString: @"个人账户"]){
        ///个人资料
        MemberInfoViewController *memberInfo = [[MemberInfoViewController alloc] init];
        [memberInfo.mainService setMemberDTO: [self.mainService memberInfo]];
        [self.navigationController pushViewController: memberInfo animated: YES];
    }
    else if([floorName isEqualToString: @"公司财务信息"]){
        DHBCorporateFinancialViewController *vc = [[DHBCorporateFinancialViewController alloc] init];
        [self.navigationController pushViewController: vc animated: YES];
    }
    else if([floorName isEqualToString: @"收货地址"]){
        DHBAddressDeliveryViewController *address = [[DHBAddressDeliveryViewController alloc] init];
        address.type = LOOK;
        [self.navigationController pushViewController: address animated: YES];
    }
    else if([floorName isEqualToString: @"资金账户"]){
        DHBFinanceAccountViewController *financeVC = [[DHBFinanceAccountViewController alloc] init];
        //                [financeVC setMemberDTO: self.mainService.memberInfo];
        [self.navigationController pushViewController: financeVC animated: YES];
    }
    else if([floorName isEqualToString: @"快捷支付"]){
        DHBQuicklyPayController *quicklyPayVC = [[DHBQuicklyPayController alloc] init];
        quicklyPayVC.is_quickly_pay =self.mainService.memberInfo.isOpenQuicklyPay;
        [self.navigationController pushViewController: quicklyPayVC animated: YES];
    }
    else if([floorName isEqualToString: @"退货单"]){
        ReturnsOrderListViewController *listVC = [[ReturnsOrderListViewController alloc] init];
        [self.navigationController pushViewController: listVC animated: YES];
    }
    else if([floorName isEqualToString: @"联系供货商"]){
        DHBCustomerViewController *listVC = [[DHBCustomerViewController alloc] init];
        [self.navigationController pushViewController: listVC animated: YES];
    }
    else if([floorName isEqualToString: @"关于订货宝"]){
        DHBAboutViewController *aboutVC = [[DHBAboutViewController alloc] init];
        [self.navigationController pushViewController: aboutVC animated: YES];
    }
    else if([floorName isEqualToString: @"系统建议与反馈"]){
        ///系统建议与反馈
        DHBAddMessageViewController *messageVC = [[DHBAddMessageViewController alloc] init];
        [messageVC setTitleStr: @"系统建议与反馈"];
        messageVC.is_feedback = YES;
        [self.navigationController pushViewController: messageVC animated: YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0 ? 0 : DEFAULT_SECTION_HEIGHT);
}

#pragma mark - MemberCenterFooterView_Delegate(切换账号)
- (void)footerView_DidChangeAccountButtonClick:(UIButton *)button{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"确定退出当前账号吗？" delegate: self cancelButtonTitle: @"取消" otherButtonTitles: @"确定", nil];
    [alertView show];
}

#pragma mark - alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self.mainService loginOut];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
