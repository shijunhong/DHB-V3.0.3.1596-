//
//  MemberInfoViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/25/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "MemberInfoViewController.h"
@implementation MemberInfoViewController

#pragma mark - mainService
- (DHBMemberInfoService *)mainService{
    if(!_mainService){
        _mainService = [[DHBMemberInfoService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

#pragma mark - compeleteButton
- (UIButton *)compeleteButton{
    if(!_compeleteButton){
        _compeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15.0f- 18 * 2, 20.0f, 18*2, self.navigationView.height-20.0f)];
        [_compeleteButton setTitle: @"确定" forState: UIControlStateNormal];
        [_compeleteButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_compeleteButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0f]];
//        [tmpbutton setTitleEdgeInsets: UIEdgeInsetsMake(0.0f, 25.0f, 0.0f, 0.0f)];
        [_compeleteButton addTarget: self action: @selector(compeleteButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _compeleteButton;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel:YES andTitelText:@"我的账号"];
    [self showBack: YES];
    [self showTabBar: NO];
    ///tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];

    ///service
    [self.mainService queryData];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.compeleteButton];
}

#pragma mark - DHBMemberInfoService delegate
- (void)memberInfoService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.tableView reloadData];
    }
}

- (void)memberInfoService_ModifyMemberInfoResult:(BOOL)isSuccess{
    if(isSuccess){
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.mainService floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBMemberInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBMemberInfoTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
        [cell setDelegate: self];
    }
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    [cell updateViewWithFloorDTO: floorDTO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: section];
    return [floorDTO sectionHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    return [floorDTO hight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    if([[floorDTO templateID] integerValue] == 3){
        ///修改密码
        DHBModifyPasswordViewController *modifyPasswordVC = [[DHBModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController: modifyPasswordVC animated: YES];
    }
}

#pragma mark - DHBMemberInfoTableViewCell Delegate
- (void)memberInfoTableViewCell_TextFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
}

#pragma mark - compeleteButtonClick
- (void)compeleteButtonClick:(UIButton *)sender{
    ///完成按钮
    DHBMemberInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 2]];
    self.mainService.memberDTO.memberName = [cell.contentTextFiled text];
    
    cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 3]];
    self.mainService.memberDTO.memberPhone = [cell.contentTextFiled text];
    
    cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 4]];
    self.mainService.memberDTO.memberMail = [cell.contentTextFiled text];
    
    [self.mainService submitMemberInfoData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
