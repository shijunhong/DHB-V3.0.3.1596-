//
//  DHBOperatingLogViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOperatingLogViewController.h"
#import "DHBOperatingLogTableViewCell.h"
#import "OrderModuleDTO.h"

@interface DHBOperatingLogViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation DHBOperatingLogViewController
static NSString *identifier_1 = @"OperatingLogCell";

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_tableView setBackgroundColor: [UIColor clearColor]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [lineView setBackgroundColor: [UIColor CellLine_Color]];
        [_tableView setTableFooterView: lineView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"操作日志"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark TableView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.logs_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBOperatingLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if(!cell){
        cell = [[DHBOperatingLogTableViewCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier_1];
    }
    LogordersModuleDTO *log = [self.logs_arr safeObjectAtIndex:indexPath.row];
    [cell updateView:log];
    if (indexPath.row ==0)
    {
        [cell.time_lb setTextColor:[UIColor TextRed_Color]];
        [cell.type_lb setTextColor:[UIColor TextRed_Color]];
        [cell.content_lb setTextColor:[UIColor TextRed_Color]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.bottomLineView setHidden: NO];
    if([indexPath row] == [self.logs_arr count] - 1){
        [cell.bottomLineView setHidden: YES];
    }
    return cell;
}

#pragma mark TableView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}
@end
