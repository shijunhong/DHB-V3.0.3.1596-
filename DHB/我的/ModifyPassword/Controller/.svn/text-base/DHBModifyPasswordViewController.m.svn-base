//
//  DHBModifyPasswordViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 60.0f
#import "DHBModifyPasswordViewController.h"
@implementation DHBModifyPasswordViewController
#pragma mark - getters and setters
- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray arrayWithObjects: [NSArray arrayWithObject: @"原密码"],[[NSArray alloc] initWithObjects: @"新密码",@"确认密码", nil], nil];
    }
    return _dataArray;
}

- (NSArray *)placeholderDataArray{
    if(!_placeholderDataArray){
        _placeholderDataArray = [NSArray arrayWithObjects: [NSArray arrayWithObject: @"请输入原密码"],[[NSArray alloc] initWithObjects: @"6-16位数字、字母",@"请再次输入密码", nil], nil];
    }
    return _placeholderDataArray;
}

#pragma mark - compeleteButton
- (UIButton *)compeleteButton{
    if(!_compeleteButton){
        _compeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- 15.0f - 36.0f, 20.0f, 36.0f, self.navigationView.height-20.0f)];
        [_compeleteButton setTitle: @"确定" forState: UIControlStateNormal];
        [_compeleteButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_compeleteButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0f]];
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
    [self showTitel:YES andTitelText:@"设置新密码"];
    [self showBack: YES];
    [self showTabBar: NO];
    ///tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    ///
//    [[KeyboardManager cleanMaskView] setHidden: YES];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview: self.compeleteButton];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArray objectAtIndex: section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBModifyPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBModifyPasswordTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"listCell" size: CGSizeMake(SCREEN_WIDTH, CELL_HEIGHT)];
        [cell setDelegate: self];
    }
    [cell.titleLabel setText: [[self.dataArray objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]]];
    [cell.contentTextFiled setPlaceholder: [[self.placeholderDataArray objectAtIndex: [indexPath section]] objectAtIndex: [indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0 ? 0 : DEFAULT_SECTION_HEIGHT);
}

#pragma mark - DHBModifyPasswordTableViewCell Delegate
- (void)modifyPasswordTableViewCell_TextFieldDidBeginEditing:(UITextField *)textField cell:(UITableViewCell *)cell{
    firstResponser = textField;
}

#pragma mark - compeleteButtonClick
- (void)compeleteButtonClick:(UIButton *)sender{
    DHBModifyPasswordTableViewCell *cell = nil;
    cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    NSString *oldPwd = [cell.contentTextFiled text];

    cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 1]];
    NSString *newPwd = [cell.contentTextFiled text];

    cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 1 inSection: 1]];
    NSString *repeatNewPwd = [cell.contentTextFiled text];

    ///完成按钮
    DHBModifyPasswordViewRequest *request = [[DHBModifyPasswordViewRequest alloc] init];
    request.old_pwd = oldPwd;
    request.n_pwd = newPwd;
    request.n_pwd_repeat = repeatNewPwd;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            isSuccess = [[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 0 ? NO : YES;
        }
        if(!isSuccess){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: [dic objectForKey: @"message"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else{
            [self.navigationController popViewControllerAnimated: YES];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"密码修改失败，请稍候再试" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
