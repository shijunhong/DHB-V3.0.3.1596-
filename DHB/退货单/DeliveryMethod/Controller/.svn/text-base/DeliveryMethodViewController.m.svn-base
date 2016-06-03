//
//  DeliveryMethodViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define CUR_DATEPICKER_HEIGHT 160.0f
#import "DeliveryMethodViewController.h"
@implementation DeliveryMethodViewController
#pragma mark - DHBDeliveryService
- (DHBDeliveryService *)mainService{
    if(!_mainService){
        _mainService = [[DHBDeliveryService alloc] init];
        [_mainService setDelegate: self];
        [_mainService setDeliveryMethodDTO: self.deliveryMethodDTO];
    }
    return _mainService;
}


#pragma mark - compeleteButton
- (UIButton *)compeleteButton{
    if(!_compeleteButton){
        _compeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15.0f-18.0f*2,20.0f,18*2,self.navigationView.height-20.0f)];
        [_compeleteButton setTitle: @"确定" forState: UIControlStateNormal];
        [_compeleteButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_compeleteButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0f]];
        //        [tmpbutton setTitleEdgeInsets: UIEdgeInsetsMake(0.0f, 25.0f, 0.0f, 0.0f)];
        [_compeleteButton addTarget: self action: @selector(compeleteButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _compeleteButton;
}

#pragma mark -
-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.compeleteButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTitel:YES andTitelText:@"确认发货"];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showShoppingCar: NO];
    datePicker_height = 0.0f;
    ///tabelView
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    ///service
    [self.mainService queryData];
}

#pragma mark - DHBDeliveryService delegate
- (void)deliveryServiceComplete:(DHBDeliveryService *)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.dataArray = [service dataArray];
        [self.tableView reloadData];
    }
}

- (void)deliveryService_DidSettingDeliveryMethod:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self dataArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeliveryBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DeliveryBaseTableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"ListCell"];
    }
    [cell setDelegate: self];
    HomeFloorDTO *floor = [self.dataArray objectAtIndex: indexPath.section];
    [cell updateViewWithDTO: floor pickerHeight: datePicker_height];
    if([[floor floorName] isEqualToString: @"发货日期"]){
        self.sendTimeTextField = [cell contentTextFiled];
    }
    if([[floor floorName] isEqualToString: @"物流公司"]){
        self.sendCompanyTextField = [cell contentTextFiled];
    }
    else if([[floor floorName] isEqualToString: @"物流单号"]){
        self.sendNOTextField = [cell contentTextFiled];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [self.dataArray objectAtIndex: indexPath.section];
    if([[floor floorName] isEqualToString: @"时间筛选器"]){
        return datePicker_height;
    }
    else{
        return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : DEFAULT_SECTION_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: HEX_RGB(0xf8f8f8)];
    return view;
}

#pragma mark - DeliveryBaseTableViewCell delegate
- (void)baseTableViewCell_openDatePicker:(DeliveryBaseTableViewCell *)cell{
//    [firstResponser resignFirstResponder];
    [self.sendNOTextField resignFirstResponder];
    [self.sendCompanyTextField resignFirstResponder];
    datePicker_height = CUR_DATEPICKER_HEIGHT;
    [self.tableView reloadData];
}

- (void)baseTableViewCell_closeDatePicker{
    datePicker_height = 0.0f;
    [self.tableView reloadData];
}

- (void)baseTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *)button selectTime:(NSString *)selectTime{
    DHBDeliveryMethodMoudleDTO *model = [[[self.dataArray firstObject] moduleList] firstObject];
    [model setSend_date: selectTime];
    [self.sendTimeTextField setText: selectTime];
    [self baseTableViewCell_closeDatePicker];
}

- (void)baseTableViewCell_textEndEidt:(DeliveryBaseTableViewCell *)cell textFiled:(UITextField *)textFiled{
    DHBDeliveryMethodMoudleDTO *deliveryModel = [[cell.floorDTO moduleList] firstObject];
    if([[cell.floorDTO floorName] isEqualToString: @"物流公司"]){
        [deliveryModel setSend_company: [cell.contentTextFiled text]];
    }
    else if([[cell.floorDTO floorName] isEqualToString: @"物流单号"]){
        [deliveryModel setSend_no: [cell.contentTextFiled text]];
    }
}

#pragma mark - compeleteButtonClick
- (void)compeleteButtonClick:(UIButton *)sender{
//    [self.deliveryMethodDTO setSend_mode: [self.sendModeTextField text]];
    [self.sendNOTextField resignFirstResponder];
    [self.sendCompanyTextField resignFirstResponder];
    [self.deliveryMethodDTO setSend_date: [self.sendTimeTextField text]];
    [self.deliveryMethodDTO setSend_company: [self.sendCompanyTextField text]];
    [self.deliveryMethodDTO setSend_no: [self.sendNOTextField text]];
    ////提交数据
    NSString *isAddDelivery = (self.operationMode == kAddDeliveryMode_type ? @"T" : @"F");
    [self.mainService setIsAddDelivery: isAddDelivery];
    [self.mainService settingReturnedOrderDeliveryMethod: self.returns_id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
