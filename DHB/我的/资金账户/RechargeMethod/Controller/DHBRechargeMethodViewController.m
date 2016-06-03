//
//  DHBRechargeMethodViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BOTOMVIEW_HEIGHT 74.0F
#import "DHBRechargeMethodViewController.h"
#import "PayType.h"
#import "DHBFinanceAccountViewController.h"
#import "DHBDepositPayRequest.h"
#import "DHBDepositPayView.h"
#import "DHBAlipayPayRequest.h"
#import "DHBAlipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DHBQuicklyPayWebController.h"
#import "DHBRechargeResultViewController.h"
//#import "YijiPayLib.h"

@interface DHBRechargeMethodViewController ()<DHBDepositPayView_Delegate>
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)DHBDepositPayView *deposit_v;
//背景灰色透明图
@property (nonatomic,strong)UIView *shareBackGroundView;
@end

@implementation DHBRechargeMethodViewController

#pragma mark - init
- (DHBTipView *)tipView{
    if(!_tipView){
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (DHBRechargeMethodService *)mainService{
    if(!_mainService){
        _mainService = [[DHBRechargeMethodService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height- BOTOMVIEW_HEIGHT -Titel_HEIGHT, SCREEN_WIDTH, BOTOMVIEW_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, (BOTOMVIEW_HEIGHT - DEFAULT_BUTTON_HEIGHT) / 2.0f, SCREEN_WIDTH-30, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue4];
        [btn setBackgroundColor: [UIColor clearColor]];
        [btn setTitle:@"查看订单" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}


-(DHBDepositPayView *)deposit_v{
    if (!_deposit_v)
    {
        _deposit_v = [[DHBDepositPayView alloc] init];
        [_deposit_v setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350.0f)];
        [_deposit_v setDelegate: self];
        [self.view addSubview:_deposit_v];
    }
    return _deposit_v;
}

-(UIView *)shareBackGroundView{
    if (!_shareBackGroundView)
    {
        _shareBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _shareBackGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_shareBackGroundView addGestureRecognizer:gesture];
    }
    return _shareBackGroundView;
}

#pragma mark -
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///查询数据
    [self.mainService queryData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showBackgroundView:NO onClick:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    if(self.mainService.order){
        [self showTitel: YES andTitelText: @"支付"];
        [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - BOTOMVIEW_HEIGHT)];
    }
    else{
        [self showTitel: YES andTitelText: @"充值"];
        [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    }
    ///tableView
    [self removeHeaderView];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    if (self.mainService.order)
    {
        [self showBack: NO];
        [self.view addSubview:self.bottomView];
        [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - self.bottomView.height)];
    }
}

#pragma mark - DHBRechargeMethodService_Delegate
- (void)rechargeMethodService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.tableView reloadData];
    }
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mainService floorsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBRechargeMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBRechargeMethodTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
        [cell setDelegate: self];
    }
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];

    [cell updateViewWithFloorDTO: dto];
    if([[dto templateID] isEqualToString: @"2"]){
        firstResponser = [cell priceTextFiled];
    }
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];
    return [dto hight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];
    curPayType = [[dto.moduleList firstObject] objectForKey:@"pay"];
    if (!curPayType)
    {
        return;
    }
    if([[curPayType is_client] isEqualToString: @"F"] || [[curPayType is_manager]  isEqualToString: @"F"]){
        ///供应商或者经销商未开通该支付方式
        if(curPayType.type == Quick && [[curPayType is_manager] isEqualToString: @"F"]){
            [self.tipView showInSuperView: self.view message: @"您的供货商未开通快捷支付，您可以去提醒开通"];
        }
        else if(curPayType.type == Quick && [[curPayType is_client] isEqualToString: @"F"])
        {
            [self.tipView showInSuperView: self.view message: @"请到【我的】页面开通快捷支付"];
        }
        return;
    }
    NSString *str = [(DHBTextField*)firstResponser text];
    if (!str ||[str doubleValue] == 0)
    {
        [[DHBAlertView sharedManagered] showMessage: (self.mainService.order ? @"请输入支付金额！" : @"请输入充值金额！")];
    }
    else if (self.mainService.order && [self.mainService.order.account_notpaid doubleValue]<[str doubleValue])
    {
        [[DHBAlertView sharedManagered] showMessage:@"支付金额大于订单未付金额!"];
    }
    else
    {
        switch (curPayType.type){
            case Offline:
            {
                DHBOfflineRechargeViewController *offlineVC = [[DHBOfflineRechargeViewController alloc] init];
                offlineVC.order = self.mainService.order;
                offlineVC.amount = str;
                offlineVC.paytype = curPayType;
                [self.navigationController pushViewController: offlineVC animated: YES];
            }
                break;
            case Deposit:
            {
                if ([str doubleValue]> [curPayType.money doubleValue])
                {
                    //余额不足
                    CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
                    UIView *contentView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0, SCREEN_WIDTH- 90 * Multiple, 120.0f * Multiple)];
                    ///label
                    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0, contentView.width - 30.0f, contentView.height)];
                    [messageLabel setFont: [UIFont systemFontOfSize: 15.0f]];
                    [messageLabel setTextAlignment: NSTextAlignmentCenter];
                    [messageLabel setNumberOfLines: 0];
                    [messageLabel setLineBreakMode: NSLineBreakByCharWrapping];
                    messageLabel.text = @"可支付余额不足，请先充值";
                    [contentView addSubview: messageLabel];
                    [alert setContainerView: contentView];
                    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":@"取消",@"type":@(kDHBButton_StyleValue4)},@{@"name":@"确定",@"type":@(kDHBButton_StyleValue3)}, nil]];
                    [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                        if(buttonIndex == 1)
                        {
                            DHBFinanceAccountViewController *financeVC = [[DHBFinanceAccountViewController alloc] init];
                            [self.navigationController pushViewController: financeVC animated: YES];
                        }
                    }];
                    [alert show];
                }
                else
                {
                    [self.deposit_v updateData:[NSMutableArray arrayWithObjects:
                                                @{@"name":@"当前余额",@"value":curPayType.money},
                                                @{@"name":@"本次支付",@"value":str}, nil]];
                    [self showBottomDepositView];
                }
                
            }
                break;
            case Alipay:
            {
                DHBAlipayPayRequest *request = [[DHBAlipayPayRequest alloc] init];
                request.orders_num = self.mainService.order.orders_num?self.mainService.order.orders_num:@"";
                request.amount = str;
                request.remark = @"";
                WS(weakSelf);
                [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
//                    NSLog_Red(@"%@",data);
                    NSDictionary *dic = (NSDictionary*)data;
                    BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
                    if(isSuccess)
                    {
                        NSDictionary *dict = [dic objectForKey:@"data"];
                        DHBAlipay *alipay_order = [[DHBAlipay alloc] init];
                        [alipay_order parseFromDict:[dict EncodeDicFromDicWithKey:@"para"]];
                        NSString *orderSpec = [alipay_order description];
                        NSString *signedString = [[[dict EncodeDicFromDicWithKey:@"para"] EncodeStringFromDicWithKey:@"sign"] URLEncoding];
                        NSString *orderString = nil;
                        if (signedString != nil || ![signedString isEqualToString:@""])
                        {
                            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                           orderSpec, signedString, [[dict EncodeDicFromDicWithKey:@"para"] EncodeStringFromDicWithKey:@"sign_type"]];
                            [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"hk.dhb.newdhb" callback:^(NSDictionary *resultDic) {
//                                NSLog_Blue(@"reslut = %@",resultDic);
                                NSInteger resultStatus= [[resultDic EncodeNumberFromDicWithKey:@"resultStatus"] integerValue];
                                if (resultStatus == 9000)
                                {
                                    BOOL success = NO;
                                    NSString *result = [resultDic EncodeStringFromDicWithKey:@"result"];
                                    if (result&&[result length]>0)
                                    {
                                        NSArray *result_arr = [result componentsSeparatedByString:@"&"];
                                        for (NSString *result_sub in result_arr)
                                        {
                                            NSArray *resultsub_arr = [result_sub componentsSeparatedByString:@"="];
                                            if ([[resultsub_arr safeObjectAtIndex:0] isEqualToString:@"success"])
                                            {
                                                success = [[resultsub_arr safeObjectAtIndex:1] isEqualToString:@"\"true\""]?YES:NO;
                                            }
                                        }
                                    }
                                    if (success)
                                    {
                                        //支付成功跳转 成功页面
                                        DHBRechargeResultViewController *rechargeResult = [[DHBRechargeResultViewController alloc] init];
                                        rechargeResult.order = weakSelf.mainService.order;
                                        rechargeResult.mainView.amount = str;
                                        rechargeResult.mainView.type = curPayType;
                                        [weakSelf.navigationController pushViewController:rechargeResult animated:NO];
                                        
                                    }
                                }
                            }];
                        }
                    }
                } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
                    
                }];
            }
                break;
            case Quick:
            {
                DHBQuicklyPayWebController *quicklyPay = [[DHBQuicklyPayWebController alloc] init];
                quicklyPay.payType = PAY;
                quicklyPay.order = self.mainService.order;
                quicklyPay.amount = str;
                quicklyPay.curPayType = curPayType;
                [self.navigationController pushViewController:quicklyPay animated:YES];
            }
                break;
            case BaiTiao:
            {
                [self.tipView showInSuperView: self.view message: @"白条支付，暂时未正式推出"];
                break;
            }
            default:
                break;
        }
    }
}


#pragma mark - DHBDepositPayView_Delegate
- (void)DHBDepositPayView_PayButtonClick:(UIButton *)sender payValue:(NSString *)payValue{
    DHBDepositPayRequest *request = [[DHBDepositPayRequest alloc] init];
    request.orders_num = self.mainService.order.orders_num;
    request.amount = payValue;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        DHBRechargeResultViewController *resultVC = [[DHBRechargeResultViewController alloc] init];
        resultVC.order = self.mainService.order;
        [resultVC.mainView setAmount: payValue];
        [resultVC.mainView setType: curPayType];
        [self.navigationController pushViewController: resultVC animated: YES];
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
    }];
}

#pragma mark - DHBRechargeMethodTableViewCell_Delegate
- (void)rechargeMethodTableViewCell_textFieldDidBeginEditing:(UITextField *)textField{
    firstResponser = textField;
}

#pragma mark buttonACTION
-(void)orderAction:(UIButton*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil userInfo:@{@"order":self.mainService.order}];
    [self.tabBarController setSelectedIndex:1];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - deposit_v Animations
#pragma mark 显示余额支付页面
-(void)showBottomDepositView{
    [self showBackgroundView:YES onClick:nil];
    [self.view insertSubview:self.shareBackGroundView belowSubview:self.deposit_v];
    WS(weakSelf);
    [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.deposit_v.top = self.view.frame.size.height - 350.0f;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark 隐藏订单填写页面
-(void)dismissBottomDepositView{
    [self showBackgroundView:NO onClick:nil];
    [firstResponser resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.deposit_v.top = self.view.frame.size.height;
    } completion:^(BOOL finished) {
        [weakSelf.shareBackGroundView removeFromSuperview];
    }];
}

#pragma mark BackgroundTapAction
-(void)backgroundTapped:(UIGestureRecognizer*)sender{
    [self dismissBottomDepositView];
}

@end
