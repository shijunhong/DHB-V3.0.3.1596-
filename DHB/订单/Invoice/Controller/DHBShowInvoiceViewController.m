//
//  DHBShowInvoiceViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBShowInvoiceViewController.h"
#import "DHBShowInvoiceCell.h"

@interface DHBShowInvoiceViewController ()
@property(nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation DHBShowInvoiceViewController
static NSString *identifier_1 = @"InvoiceCell";

-(ShowInvoiceService *)service{
    if (!_service)
    {
        _service = [[ShowInvoiceService alloc] init];
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    if ([self.service.invoice.invoice_type isEqualToString:@"P"])
    {
        [self showTitel:YES andTitelText:[NSString stringWithFormat:@"普通发票（%ld%%税点）",(long)self.service.invoice.invoice_tax]];
    }
    else if ([self.service.invoice.invoice_type isEqualToString:@"Z"])
    {
        [self showTitel:YES andTitelText:[NSString stringWithFormat:@"增值税发票（%ld%%税点）",(long)self.service.invoice.invoice_tax]];
    }
    
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.service.invoicelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.service.invoicelist safeObjectAtIndex:indexPath.row];
    DHBShowInvoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if(!cell){
        cell = [[DHBShowInvoiceCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier_1];
    }
    [cell updateView:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth:SCREEN_WIDTH tableView: self.tableView];
}

@end
