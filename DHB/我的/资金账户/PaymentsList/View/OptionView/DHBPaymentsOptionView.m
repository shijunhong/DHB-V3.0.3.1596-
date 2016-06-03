//
//  DHBPaymentsOptionView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 50.0f
#import "DHBPaymentsOptionView.h"

@implementation DHBPaymentsOptionView
@synthesize mainTableView;
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        mainTableView = [[UITableView alloc] initWithFrame: CGRectMake(0.0f, Titel_HEIGHT, SCREEN_WIDTH - 60.0f, SCREEN_HEIGHT - Titel_HEIGHT)];
        [mainTableView setBackgroundColor: [UIColor clearColor]];
        [mainTableView setDelegate: self];
        [mainTableView setBackgroundColor: [UIColor whiteColor]];
        [mainTableView setDataSource: self];
//        [mainTableView setSeparatorColor: HEX_RGB(0xe8e8e8)];
        [mainTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        UIView *footerView = [[UIView alloc] init];
        [footerView setBackgroundColor: [UIColor clearColor]];
        [mainTableView setTableFooterView: footerView];
        [self addSubview: mainTableView];
    }
    return self;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBPaymentsOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBPaymentsOptionTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"ListCell" size: CGSizeMake(self.size.width, CELL_HEIGHT)];
        [cell setDelegate: self];
    }
    if(self.isPayType){
        DHBPayTypeModuleDTO *dto = [self.dataArray objectAtIndex: [indexPath row]];
        [cell updateViewWithPayTypeDTO: dto];
        if([dto is_select]){
            curOperateIndexPath = indexPath;
        }
    }
    else{
        DHBDepositTypeModuleDTO *dto = [self.dataArray objectAtIndex: [indexPath row]];
        [cell updateViewWithDepositeTypeDTO: dto];
        if([dto is_select]){
            curOperateIndexPath = indexPath;
        }
    }
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setTextAlignment: NSTextAlignmentCenter];
    [titleLabel setFont: [UIFont systemFontOfSize: 16.0f]];
    [titleLabel setText: @"筛选"];
    [titleLabel setTextColor: [UIColor TextGray_Color]];
    ///
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, CELL_HEIGHT - DEFAULT_LINE_HEIGHT, self.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: [UIColor CellLine_Color]];
    [titleLabel addSubview: lineView];
    return titleLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isPayType){
        //取消之前选中的
        DHBPayTypeModuleDTO *dto = [self.dataArray objectAtIndex: [curOperateIndexPath row]];
        [dto setIs_select: NO];
        //
        dto = [self.dataArray objectAtIndex: [indexPath row]];
        [dto setIs_select: YES];
        [[tableView cellForRowAtIndexPath: indexPath] updateViewWithPayTypeDTO: dto];
    }
    else{
        DHBDepositTypeModuleDTO *dto = [self.dataArray objectAtIndex: [curOperateIndexPath row]];
        [dto setIs_select: NO];
        dto = [self.dataArray objectAtIndex: [indexPath row]];
        [dto setIs_select: YES];
        [[tableView cellForRowAtIndexPath: indexPath] updateViewWithDepositeTypeDTO: dto];
    }
    curOperateIndexPath = indexPath;
    if([_delegate respondsToSelector: @selector(paymentsOptionView_DidSelectRowAtIndexPath: isPayType:)]){
        [_delegate paymentsOptionView_DidSelectRowAtIndexPath: indexPath isPayType: self.isPayType];
    }
}

#pragma mark - 
//- (void)paymentsOptionTableViewCell_DidClickCell:(DHBPaymentsOptionTableViewCell *)cell{
//    [curOperateCell selectedCell: NO];
//    curOperateCell = cell;
//}
@end
