//
//  DHBCustomerViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCustomerViewController.h"
@implementation DHBCustomerViewController
#pragma mark - init
- (TencentOAuth *)tencentOAuth{
    if(!_tencentOAuth){
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId: @"dhb" andDelegate:nil];
    }
    return _tencentOAuth;
}

- (DHBCustomerService *)mainService{
    if(!_mainService){
        _mainService = [[DHBCustomerService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"联系供应商"];
    ///tableView
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorColor: HEX_RGB(0xdcdcdc)];
    if([self.tableView respondsToSelector: @selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector: @selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    ///service
    [self.mainService queryData];
}

#pragma mark - DHBCustomerService_Delegate
- (void)customerService_Compelete:(id)service isSuccess:(BOOL)isSuccess{
    self.mainService = service;
    if(isSuccess){
        [self.tableView reloadData];
        ////数据为空
        if([self.mainService.floorsArray count] == 0){
            [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"暂无联系方式"];
        }
    }
    else{
        [self.mainService.floorsArray removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.mainService floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    HomeFloorDTO *dto = [[self.mainService floorsArray] objectAtIndex: section];
//    return [[dto moduleList] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBCustomerTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell" size: CGSizeMake(SCREEN_WIDTH, SERVICE_CELL_HEIGHT)];
    }
    HomeFloorDTO *floor = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    DHBCustomerModuleDTO *dto = [[floor moduleList] firstObject];
    [cell updateviewWithDTO: dto];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SERVICE_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floor = [[self.mainService floorsArray] objectAtIndex: section];
    return [floor sectionHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tempView = [[UIView alloc] init];
    [tempView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    ///分割线
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, tableView.frame.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [tempView addSubview: lineView];
    HomeFloorDTO *floor = [[self.mainService floorsArray] objectAtIndex: section];
    lineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, [floor sectionHeight] - DEFAULT_LINE_HEIGHT, tableView.frame.size.width, DEFAULT_LINE_HEIGHT)];
    [lineView setBackgroundColor: HEX_RGB(0xdcdcdc)];
    [tempView addSubview: lineView];
    return tempView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell respondsToSelector: @selector(setLayoutMargins:)]){
        [cell setLayoutMargins: UIEdgeInsetsZero];
    }
    if([cell respondsToSelector: @selector(setSeparatorInset:)]){
        [cell setSeparatorInset: UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [[self.mainService floorsArray] objectAtIndex: [indexPath section]];
    DHBCustomerModuleDTO *dto = [[floor moduleList] firstObject];
    if([[dto type] isEqualToString: @"个人QQ"] || [[dto type] isEqualToString:@"企业QQ"]){
        ///打开QQ进行聊天
        QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin: [dto contactMethod]];
        [SendMessageToQQReq reqWithContent:wpaObj];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        [self handleSendResult:sent];
    }
    else if([[dto type] isEqualToString: @"旺旺"]){
    }
    else if([[dto type] isEqualToString: @"微信"]){
    }
    else if([[dto type] isEqualToString: @"电话"]){
        //拨打电话
        [self callPhone: [dto contactMethod]];
    }
}

#pragma mark - 处理QQ相关操作
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手机QQ" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手机QQ" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - 拨打电话
- (void)callPhone:(NSString *)phoneNumber{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [[NSString stringWithCString: systemInfo.machine encoding: NSUTF8StringEncoding] lowercaseString];
    if([deviceString hasPrefix: @"iphone"])
    {
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: [NSString stringWithFormat:@"tel://%@",phoneNumber]]]];
        [self.view addSubview: callWebView];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"对不起，您的设备不支持呼叫功能" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles:  nil];
        [alertView show];
    }
}

#pragma mark - EGO Delegate下拉刷新
-(void)HeaderRefreshView{
    [self.mainService queryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
