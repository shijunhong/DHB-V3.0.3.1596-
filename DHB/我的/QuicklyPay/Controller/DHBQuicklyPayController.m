//
//  DHBQuicklyPayController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/10/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBQuicklyPayController.h"
#import "DHBQuicklyPayWebController.h"

@implementation DHBQuicklyPayController
#pragma mark - init
- (DHBQuicklyPayService *)mainService{
    if(!_mainService){
        _mainService = [[DHBQuicklyPayService alloc] init];
        WS(weakSelf);
        //数据请求block
        _mainService.DHBQuicklyPayService_Compelete = ^(DHBQuicklyPayService *service, BOOL isSuccess){
            weakSelf.mainService = service;
            [weakSelf.tableView reloadData];
        };
        //提醒开通block
        _mainService.DHBQuicklyPayService_AlertOpenAuicklyPay = ^(DHBQuicklyPayService *service, BOOL isSuccess){
            if(isSuccess){
                [[DHBAlertView sharedManagered] showMessage: @"已提醒供货商，请耐心等待"];
            }
        };
    }
    return _mainService;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainService queryData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"快捷支付"];
    [self showShoppingCar: NO];
    ///
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
}

#pragma mark - tableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBQuicklyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBQuicklyTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
//    HomeFloorDTO *floor = [self.mainService.floorArray objectAtIndex: [indexPath row]];
    [cell updateView: self.is_quickly_pay];
    WS(weakSelf);
    cell.onOperationButtonClick = ^(UIButton *sender){
//        NSLog(@"提醒开通");
//        [self.mainService setContent: @"您好，请开通快捷支付"];
//        [self.mainService alertOpenAuicklyPay];
        DHBQuicklyPayWebController *quicklyPay = [[DHBQuicklyPayWebController alloc] init];
        if(weakSelf.is_quickly_pay){
            ///登录
            quicklyPay.payType = LOGIN;
        }
        else{
            ///开通快捷支付
            quicklyPay.payType = REGISTER;
        }
        [weakSelf presentViewController:quicklyPay animated:YES completion:nil];
    };
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}
@end
