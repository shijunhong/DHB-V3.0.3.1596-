//
//  DHBOrderAttachmentViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 40.0f
#import "DHBOrderAttachmentViewController.h"

@implementation DHBOrderAttachmentViewController

- (DHBOrderAttachmentService *)mainService{
    if(!_mainService){
        _mainService = [[DHBOrderAttachmentService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"附件"];
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    if([self.tableView respondsToSelector: @selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector: @selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 30.0f)];
    [tipLabel setBackgroundColor: [UIColor clearColor]];
    [tipLabel setText: @"(请使用电脑，在订单详情页面，下载查看附件)"];
    [tipLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [tipLabel setTextAlignment: NSTextAlignmentCenter];
    [tipLabel setTextColor: [UIColor TextGray_Color]];
    [self.tableView setTableFooterView: tipLabel];
    
    if(self.isReturnsOrder){
        [self.mainService queryReturnsOrderData];
        [tipLabel setText: @"(请使用电脑，在退单详情页面，下载查看附件)"];
    }
    else{
        [self.mainService queryData];
        [tipLabel setText: @"(请使用电脑，在订单详情页面，下载查看附件)"];
    }
}


#pragma mark DHBReturnedGoodsListService_Delegate
- (void)orderAttachmentService_Compelete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.tableView reloadData];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mainService.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    DHBOrderAttachmentModuleDTO *dto = [self.mainService.dataArray objectAtIndex: [indexPath row]];
    [cell.textLabel setText: [dto attatchName]];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell.textLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [cell.textLabel setTextColor: [UIColor TextGray_Color]];
    if([cell respondsToSelector: @selector(setLayoutMargins:)]){
        [cell setLayoutMargins: UIEdgeInsetsZero];
    }
    if([cell respondsToSelector: @selector(setSeparatorInset:)]){
        [cell setSeparatorInset: UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
