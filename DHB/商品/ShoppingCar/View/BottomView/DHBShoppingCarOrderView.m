//
//  DHBShoppingCarOrderView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#import "DHBShoppingCarOrderView.h"

@implementation DHBShoppingCarOrderView
@synthesize mainTableView;
#pragma mark - getters and setters 
- (DHBSubmitOrderService *)mainService{
    if(!_mainService){
        _mainService = [[DHBSubmitOrderService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

#pragma mark - init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setBackgroundColor: [UIColor whiteColor]];
        mainTableView = [[UITableView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, frame.size.height - 50.0f)];
        [mainTableView setDelegate: self];
        [mainTableView setDataSource: self];
        [mainTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        [mainTableView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        [self addSubview: mainTableView];
    }
    return self;
}

#pragma mark - 重新加载数据
- (void)reloadData{
    [self.mainService setUserInfoDTO: _userInfoDTO];
    [self.mainService createFloor];
}

#pragma mark - DHBSubmitOrderService_Delegate
- (void)DHBSubmitOrderService_Complete:(id)service isSuceess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.mainTableView reloadData];
    }
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mainService floorArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBShoppingCarOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBShoppingCarOrderTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    [cell setDelegate: self];
    HomeFloorDTO *floor = [[self.mainService floorArray] objectAtIndex: [indexPath row]];
    [cell updateViewWithDTO: floor];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [[self.mainService floorArray] objectAtIndex: [indexPath row]];
    if([[floor floorName] isEqualToString: @"时间筛选器"]){
        return floor.hight;
    }
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.mainTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    HomeFloorDTO *floor = [[self.mainService floorArray] objectAtIndex: section];
    if([floor.floorName isEqualToString: @"商品金额"]){
        [view setBackgroundColor: [UIColor TextRed_Color]];
    }
    else{
        [view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    }
    return view;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [[self.mainService floorArray] objectAtIndex: [indexPath row]];
    if([[floor floorName] isEqualToString: @"发票类型"]){
        if([_delegate respondsToSelector: @selector(shoppingCarOrderView_DidInvoiceAction:)]){
            [_delegate shoppingCarOrderView_DidInvoiceAction: [mainTableView cellForRowAtIndexPath: indexPath]];
        }
    }
    else if([[floor floorName] isEqualToString: @"交货日期"]){
        for(HomeFloorDTO *floor in [self.mainService floorArray]){
            if([[floor floorName] isEqualToString: @"时间筛选器"]){
                [floor setHight: DATEPICKER_HEIGHT];
            }
        }
        [mainTableView beginUpdates];
        [mainTableView endUpdates];
        [mainTableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow: [[self.mainService floorArray] count] - 1 inSection: 0] atScrollPosition: UITableViewScrollPositionBottom animated: YES];
    }
    else if([[floor floorName] isEqualToString: @"收货信息"]){
        if([_delegate respondsToSelector: @selector(shoppingCarOrderView_DidAddressAction:)]){
            [_delegate shoppingCarOrderView_DidAddressAction: [mainTableView cellForRowAtIndexPath: indexPath]];
        }
    }
}

#pragma mark - DHBShoppingCarOrderTableViewCell_Delegate Delegate
/**
 *  点击时间控件的取消按钮
 */
- (void)shoppingCarOrderTableViewCell_DidCancelButtonClick{
    for(HomeFloorDTO *floor in [self.mainService floorArray]){
        if([[floor floorName] isEqualToString: @"时间筛选器"]){
            [floor setHight: 0.0f];
        }
    }
    [mainTableView beginUpdates];
    [mainTableView endUpdates];
    [mainTableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow: [[self.mainService floorArray] count] - 1 inSection: 0] atScrollPosition: UITableViewScrollPositionBottom animated: YES];
}

/**
 *  点击时间控件的确定按钮
 *
 *  @param button     当前点击的按钮
 *  @param selectTime 选择的时间值
 */
- (void)shoppingCarOrderTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *)button selectTime:(NSString *)selectTime{
    [self shoppingCarOrderTableViewCell_DidCancelButtonClick];
    [self.mainService.userInfoDTO setDelivery_date: selectTime];
    [mainTableView reloadData];
}

/**
 *  备注视图的textView，开始编辑的时候，调整本视图的位置
 *
 *  @param textView 当前编辑的TextView
 *  @param cell     当前编辑的Cell
 */
- (void)shoppingCarOrderTableViewCell_textViewDidBeginEditing:(UITextView *)textView cell:(DHBShoppingCarOrderTableViewCell *)cell{
    WS(weakSelf);
    defaultViewTop = self.top;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.top  = weakSelf.top - 216.0;
    }];
}

/**
 *  备注视图的textView，结束编辑的时候，调整本视图的位置
 *
 *  @param textView 当前编辑的TextView
 *  @param cell     当前编辑的Cell
 */
- (void)shoppingCarOrderTableViewCell_textViewDidEndEditing:(UITextView *)textView cell:(DHBShoppingCarOrderTableViewCell *)cell{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.top  = defaultViewTop;
    }];
    self.mainService.userInfoDTO.remark = textView.text;
}

#pragma mark - 更新住视图数据
- (void)updateOrderViewWithDTO:(UserInformationModuleDTO *)dto{
    DHBShoppingCarOrderTableViewCell *operateCell = [[self mainTableView] cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 1 inSection: 0]];
    ///发票
    switch (dto.venders.invoice_type)
    {
        case BK:
            [operateCell.invoiceTypeLabel setText:@"不需要发票"];
            break;
        case PT:
        {
            [operateCell.invoiceTypeLabel setText:[NSString stringWithFormat:@"普通发票(%%%@税点)", dto.venders.pt_taxing_point]];
        }
            break;
        case ZZ:
        {
            [operateCell.invoiceTypeLabel setText:[NSString stringWithFormat:@"增值税发票(%%%@税点)", dto.venders.zz_taxing_point]];
        }
            break;
        default:
            break;
    }
    
    ///商品金额
    operateCell = [[self mainTableView] cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    [[operateCell priceLabel] setText: [NSString  stringWithFormat:@"%@%@",L(@"￥"),dto.total_price]];
    
    //收货信息
    operateCell = [[self mainTableView] cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 2]];
    [operateCell.receiveNameLabel setText: dto.purchasers.address.contact];
    [operateCell.phoneLabel setText: dto.purchasers.address.phone];
    [operateCell.addressLabel setText: dto.purchasers.address.address];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
