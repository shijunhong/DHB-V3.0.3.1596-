//
//  DHBPaymentsSiftingView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOM_HEIGHT 50.0F
#define MARGIN_LEFT 10.0F
#import "DHBPaymentsSiftingView.h"

@implementation DHBPaymentsSiftingView
@synthesize mainTableView;

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SCREEN_HEIGHT - BOTTOM_HEIGHT - Titel_HEIGHT, SCREEN_WIDTH - 60.0f, BOTTOM_HEIGHT)];
        [_bottomView setBackgroundColor: [UIColor clearColor]];
        CGFloat size_w = (_bottomView.frame.size.width - 3 * MARGIN_LEFT) / 2.0f;
        ///清空按钮
        DHBButton *clearButton = [[DHBButton alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, size_w, BOTTOM_HEIGHT - MARGIN_LEFT) style: kDHBButton_StyleValue2];
        [clearButton setTitle: @"清空筛选" forState: UIControlStateNormal];
        [clearButton addTarget: self action: @selector(clearButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_bottomView addSubview: clearButton];
        ///确定
        CGFloat origin_x = clearButton.frame.size.width + clearButton.frame.origin.x + MARGIN_LEFT;
        DHBButton *okButton = [[DHBButton alloc] initWithFrame: CGRectMake(origin_x, 0.0f, size_w, BOTTOM_HEIGHT - MARGIN_LEFT) style:kDHBButton_StyleValue3];
        [okButton setTitle: @"确定" forState: UIControlStateNormal];
        [okButton addTarget: self action: @selector(okButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_bottomView addSubview: okButton];
    }
    return  _bottomView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        mainTableView = [[UITableView alloc] initWithFrame: CGRectMake(0.0f, Titel_HEIGHT, SCREEN_WIDTH - 60.0f, SCREEN_HEIGHT - Titel_HEIGHT)];
        [mainTableView setBackgroundColor: [UIColor clearColor]];
        [mainTableView setDelegate: self];
        [mainTableView setBackgroundColor: [UIColor whiteColor]];
        [mainTableView setDataSource: self];
        [mainTableView setScrollEnabled: NO];
//        if([mainTableView respondsToSelector: @selector(setLayoutMargins:)]){
//            [mainTableView setLayoutMargins: UIEdgeInsetsZero];
//        }
//        if([mainTableView respondsToSelector: @selector(setSeparatorInset:)]){
//            [mainTableView setSeparatorInset: UIEdgeInsetsZero];
//        }
//        [mainTableView setSeparatorColor: HEX_RGB(0xe8e8e8)];
        [mainTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        UIView *footerView = [[UIView alloc] init];
        [footerView setBackgroundColor: [UIColor clearColor]];
        [mainTableView setTableFooterView: footerView];
        [self addSubview: mainTableView];
        ///
        [mainTableView addSubview: self.bottomView];
    }
    return self;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBPaymentsSiftingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBPaymentsSiftingTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        [cell setDelegate: self];
    }
    [cell updateViewWithIndexpath: indexPath size: CGSizeMake(self.size.width, CELLHEIGHT)];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([indexPath row] == 3 ? datePickerHeight : CELLHEIGHT);
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([cell respondsToSelector: @selector(setLayoutMargins:)]){
//        [cell setLayoutMargins: UIEdgeInsetsZero];
//    }
//    if([cell respondsToSelector: @selector(setSeparatorInset:)]){
//        [cell setSeparatorInset: UIEdgeInsetsZero];
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CELLHEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setTextAlignment: NSTextAlignmentCenter];
    [titleLabel setFont: [UIFont systemFontOfSize: 16.0f]];
    [titleLabel setText: @"筛选"];
    [titleLabel setTextColor: [UIColor TextGray_Color]];
    ///
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, CELLHEIGHT - DEFAULT_LINE_HEIGHT, self.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: [UIColor CellLine_Color]];
    [titleLabel addSubview: lineView];
    return titleLabel;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_delegate respondsToSelector: @selector(paymentsSiftingView_DidSelectRowAtIndexPath:)]){
        [_delegate paymentsSiftingView_DidSelectRowAtIndexPath: indexPath];
    }
}

#pragma mark - DHBPaymentsSiftingTableViewCell_Delegate
#pragma mark 发货时间输入框开始编辑
- (void)paymentsSiftingTableViewCell_TextFieldDidBeginEditing:(UITextField *)textField{
    datePickerHeight = DATEPICKER_HEIGHT;
    [mainTableView beginUpdates];
    [mainTableView endUpdates];
}

#pragma mark 取消时间选择器
- (void)paymentsSiftingTableViewCell_DidCancelButtonClick{
    datePickerHeight = 0.0f;
    [mainTableView beginUpdates];
    [mainTableView endUpdates];
}

#pragma mark 选择发货时间
- (void)paymentsSiftingTableViewCell_DidOkButtonClick:(id)pickerView selectTime:(id)selectTime{
    [self paymentsSiftingTableViewCell_DidCancelButtonClick];
    DHBPaymentsSiftingTableViewCell *cell = [mainTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 2 inSection: 0]];
    if([cell curOperateIndex] == 0)
        [cell.startTimeTextFiled setText: selectTime];
    else
        [cell.endTimeTextField setText: selectTime];
}

#pragma mark - button click
#pragma mark 清空筛选
- (void)clearButtonClick:(UIButton *)sender{
    if([_delegate respondsToSelector: @selector(paymentsSiftingView_DidClearButton:)]){
        [_delegate paymentsSiftingView_DidClearButton: sender];
    }
}

#pragma mark 确定筛选
- (void)okButtonClick:(UIButton *)sender{
    if([_delegate respondsToSelector: @selector(paymentsSiftingView_DidOkButton:)]){
        [_delegate paymentsSiftingView_DidOkButton: sender];
    }
}
@end
