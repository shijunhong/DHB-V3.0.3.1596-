//
//  DHBDepositPayView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBDepositPayView.h"
#import "DHBRechargeMethodTableViewCell.h"
#import "DHBDepositCell.h"

@implementation DHBDepositPayView


-(instancetype)init{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:HEX_RGB(0xf8f8f8)];
        
        self.type_lb = [UILabel new];
        self.type_lb.font = [UIFont systemFontOfSize:15.0f];
        self.type_lb.textColor = [UIColor TextBlack_Color];
        self.type_lb.text = @"预存款支付";
        [self addSubview:self.type_lb];
        self.type_lb.sd_layout.topSpaceToView(self,15.0f).centerXEqualToView(self).widthIs(15.0f*5).autoHeightRatio(0);
        
        UIView *typebtm_l = [UIView new];
        typebtm_l.backgroundColor = [UIColor CellLine_Color];
        [self addSubview:typebtm_l];
        typebtm_l.sd_layout.topSpaceToView(self.type_lb,15.0f).leftSpaceToView(self,0.0f).rightSpaceToView(self,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
        
        self.depositPay_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue3];
        [self.depositPay_btn setTitle: @"确认支付" forState: UIControlStateNormal];
        [self.depositPay_btn addTarget: self action: @selector(depositButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:self.depositPay_btn];
        self.depositPay_btn.sd_layout.bottomSpaceToView(self,15.0f).leftSpaceToView(self,15.0f).rightSpaceToView(self,15.0f).heightIs(DEFAULT_BUTTON_HEIGHT);
        
        self.tableView = [[UITableView alloc] init];
        [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = HEX_RGB(0xf8f8f8);
        [self addSubview:self.tableView];
        self.tableView.sd_layout.topSpaceToView(typebtm_l,0.0f).leftSpaceToView(self,0.0f).rightSpaceToView(self,0.0f).bottomSpaceToView(self.depositPay_btn,0.0f);
        
        self.data_arr = [NSMutableArray array];
    }
    return self;
}



-(void)updateData:(NSMutableArray *)arr{
    [self.data_arr removeAllObjects];
    self.data_arr = arr;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    DHBDepositCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DepositCell"];
    if(!cell){
        cell = [[DHBDepositCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"DepositCell"];
    }
    [cell updateViewWithData:dic];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}


-(void)depositButtonClick:(UIButton*)sender{
    if([self.data_arr count] > 0){
        if([_delegate respondsToSelector: @selector(DHBDepositPayView_PayButtonClick: payValue:)]){
            [_delegate DHBDepositPayView_PayButtonClick: sender payValue: [[self.data_arr objectAtIndex: 1] objectForKey: @"value"]];
        }
    }
}

@end
