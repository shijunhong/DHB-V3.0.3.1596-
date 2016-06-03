//
//  DHBBaseNetworkRequest.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"
#import "DHBLoginViewController.h"
#import "AppDelegate.h"
#import "DHBAlertView.h"

static AFHTTPRequestOperationManager *defaultManager;
static NSTimeInterval defaultTimeoutInterval = 10;

@interface DHBBaseNetworkRequest ()
{
    NSString *skey;
}
@property(nonatomic, retain) DHBTipView *tipView;
@end

@implementation DHBBaseNetworkRequest

- (DHBTipView *)tipView{
    if(!_tipView){
        _tipView = [[DHBTipView alloc] init];
    }
    return _tipView;
}

- (instancetype)init{
    self  = [super init];
    if (self) {
        if (!defaultManager) {
            defaultManager = [AFHTTPRequestOperationManager manager];
            defaultManager.requestSerializer.timeoutInterval = defaultTimeoutInterval;
        }
        _timeoutInterval = defaultTimeoutInterval;
        ///获取skey
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        skey = ([userdefaults objectForKey: @"skey"] == nil ? FREE_ACCOUNT_SKEY : [userdefaults objectForKey: @"skey"]);
    }
    return self;
}

- (NSString *)fullURLPath
{
    //TODO:注意将此处地址集中管理。
    NSString *urlStr = DEVHTTPURL;
    if ([self hostName])
    {
        urlStr = [self hostName];
    }
    if ([self interfaceName])
    {
        urlStr = [urlStr stringByAppendingString:[self interfaceName]];
    }
    NSLog(@"Current requestURL: %@", urlStr);
    return urlStr;
}

- (void)cancelOldOperation
{
    NSArray *operations = defaultManager.operationQueue.operations;
    for (AFHTTPRequestOperation *httpOperation in operations) {
        NSString *oldRequestURLStr = httpOperation.request.URL.absoluteString;
        if ([oldRequestURLStr isEqualToString:[self fullURLPath]]) {
            [operation cancel];
        }
    }
}

- (void)getDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    //TODO:注意更新domain。
    [self cancelOldOperation];
    
    //是否存在自定义HTTP头，如果存在则添加。
    NSDictionary *headerDic = [self headerField];
    if (headerDic){
        for(NSString *key in [headerDic allKeys]){
            [defaultManager.requestSerializer setValue:[headerDic objectForKey:key]  forHTTPHeaderField:key];
        }
    }
    
    //设置自定义超时时间。
    if (self.timeoutInterval != defaultTimeoutInterval && self.timeoutInterval > 0) {
        defaultManager.requestSerializer.timeoutInterval = _timeoutInterval;
    }
    NSLog(@"%@", NSStringFromClass([self class]));
//    NSLog_Red(@"%@",[self parameters]);
    //请求开始前禁用用户交互(解决网络差时，连续操作出现崩溃的问题)
    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    operation = [defaultManager GET:[self fullURLPath] parameters:[self parameters] success:^ void(AFHTTPRequestOperation *operation, id responseObject) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(self, responseObject);
        }
        else
        {
            success(self, @"数据格式有问题");
        }
    } failure:^ void(AFHTTPRequestOperation * operation, NSError *error) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if (failure) {
            failure(self, error);
        }
    }];
}

- (void)postDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    
    ////第一步: 验证提交的数据是否规范 并 验证是否能够连接到服务器(![[ParameterPublic sharedManagered] isNetWorking])
    if(![self submitValidate]){
        ///验证不通过或者无法连接到服务器，不进行数据请求
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        return;
    }
    
    ////第二步: 请求数据
    [self cancelOldOperation];
    NSDictionary *headerDic = [self headerField];
    if (headerDic){
        for(NSString *key in [headerDic allKeys]){
            [defaultManager.requestSerializer setValue:[headerDic objectForKey:key]  forHTTPHeaderField:key];
        }
    }
    //设置自定义超时时间。
    if (self.timeoutInterval != defaultTimeoutInterval && self.timeoutInterval > 0) {
        defaultManager.requestSerializer.timeoutInterval = _timeoutInterval;
    }     
    if (!self.hidden_effect)
    {
        //显示一个新的加载动画之前，需要将之前的加载动画隐藏
        [GiFHUD dismiss];
        [GiFHUD setGifWithImageName:@"loading.gif"];
        [GiFHUD show];
        //请求开始前禁用用户交互(解决网络差时，连续操作出现崩溃的问题)
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
        [[DHBNoDataView sharedManagered] dismiss];
    }
    NSLog_Blue(@"调用的请求类:%@",NSStringFromClass([self class]));
//    NSLog_Red(@"%@",[self parameters]);
    //设置隐藏"没有数据"的提示视图
    [[DHBNoDataView sharedManagered] dismiss];
    operation = [defaultManager POST:[self fullURLPath] parameters:[self parameters] success:^ void(AFHTTPRequestOperation *operation, id responseObject) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        //设置隐藏"没有数据"的提示视图
        [[DHBNoDataView sharedManagered] dismiss];
        //隐藏“数据加载”视图
        [GiFHUD dismiss];
        ////第三步：返回结果的验证
        if([self returnDataValidate: responseObject]) {
            if (success) success(self, responseObject);
        }
    } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if (failure) failure(self, error);
    }];
}

- (void)postJSONDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    
    ////第一步: 验证提交的数据是否规范 并 验证是否能够连接到服务器(![[ParameterPublic sharedManagered] isNetWorking])
    if(![self submitValidate]){
        ///验证不通过或者无法连接到服务器，不进行数据请求
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        return;
    }
    
    ////第二步: 请求数据
    [self cancelOldOperation];
    defaultManager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *headerDic = [self headerField];
    if (headerDic){
        for(NSString *key in [headerDic allKeys]){
            [defaultManager.requestSerializer setValue:[headerDic objectForKey:key]  forHTTPHeaderField:key];
        }
    }
    //设置自定义超时时间。
    if (self.timeoutInterval != defaultTimeoutInterval && self.timeoutInterval > 0) {
        defaultManager.requestSerializer.timeoutInterval = _timeoutInterval;
    }
    NSLog(@"%@", NSStringFromClass([self class]));
    //设置隐藏"没有数据"的提示视图
    [[DHBNoDataView sharedManagered] dismiss];
//    //请求开始前禁用用户交互(解决网络差时，连续操作出现崩溃的问题)
//    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    operation = [defaultManager POST:[self fullURLPath] parameters:[self parameters] success:^ void(AFHTTPRequestOperation *operation, id responseObject)
    {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        //设置隐藏"没有数据"的提示视图
        [[DHBNoDataView sharedManagered] dismiss];
        //隐藏“数据加载”视图
        [GiFHUD dismiss];
        ////第三步：返回结果的验证
        if([self returnDataValidate: responseObject]){
            success(self, responseObject);
        }
    } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        [GiFHUD dismiss];
        if (failure) {
            failure(self, error);
        }
    }];
}

- (void)uploadDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    [self cancelOldOperation];
    
    NSDictionary *headerDic = [self headerField];
    if (headerDic)
    {
        for(NSString *key in [headerDic allKeys])
        {
            [defaultManager.requestSerializer setValue:[headerDic objectForKey:key]  forHTTPHeaderField:key];
        }
    }
    
    //设置自定义超时时间。
    if (self.timeoutInterval != defaultTimeoutInterval && self.timeoutInterval > 0)
    {
        defaultManager.requestSerializer.timeoutInterval = _timeoutInterval;
    }
    
    [defaultManager POST:[self fullURLPath] parameters:[self parameters] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:[self uploadData] name:@"file_value" fileName:@"IOS.jpeg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            success(self, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure(self, error);
        }
    }];
}

- (void)cancel
{
    [operation cancel];
}



#pragma mark - 转JSON
- (NSString *)toJSONData:(id)theData{
    
    NSString *jsonString = @"";
    if(![NSJSONSerialization isValidJSONObject:theData])
    {
        NSLog(@"不是JSON类型数据");
        return jsonString = @"不是JSON类型数据";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil)
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return jsonString = @"JSON转义失败";
}


#pragma mark - 由子类实现

- (NSString *)hostName
{
    return nil;
}

- (NSString *)interfaceName
{
    return nil;
}

#pragma mark 构造请求参数
- (id)parameters
{
    NSMutableDictionary *val = [[NSMutableDictionary alloc] initWithDictionary:[self value]];
    [val setValue: skey forKey:@"skey"];
//    NSLog_Red(@"skey = %@",val);
    return @{@"c":[self controller],
             @"a":[self action],
             @"val":[self toJSONData:val]};
}

- (NSData *)uploadData
{
    return nil;
}

- (NSDictionary *)headerField
{
    return nil;
}

- (NSString *)controller{
    return nil;
}

- (NSString *)action{
    return nil;
}

- (id)value{
    return nil;
}

#pragma mark 验证提交数据，默认有返回YES(不验证), 子类重写该方法可进行数据验证
- (BOOL)submitValidate{
    return YES;
}

#pragma mark 验证接口返回的数据，默认有返回YES(不验证), 子类重写该方法可进行数据验证
- (BOOL)returnDataValidate:(id) returnData{
    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
    if (![returnData isKindOfClass:[NSDictionary class]])
    {
        [self showMessage: @"数据格式有问题"];
        return NO;
    }
    else if([[returnData objectForKey: @"code"] isEqualToString: @"119"] || [[returnData objectForKey: @"code"] isEqualToString: @"200"]){
        ///当接口状态是200时，提示用户skey过期，重新登录
        [[DHBAlertView sharedManagered]  setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            [alertView close];
            ///先清空当前账号
            NSUserDefaults *userDefatuls = [NSUserDefaults standardUserDefaults];
            [userDefatuls removeObjectForKey: @"skey"];
            [userDefatuls removeObjectForKey: @"accounts_id"];
            [userDefatuls synchronize];
            ///跳转至登录页面
            ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[DHBLoginViewController alloc] init]];
        }];
        if([[returnData objectForKey: @"message"] length] > 0){
            [[DHBAlertView sharedManagered]  showMessage: [returnData objectForKey: @"message"]];
        }
        else{
            [[DHBAlertView sharedManagered]  showMessage: @"账号信息认证失败,请重新登录"];
        }
        [GiFHUD dismiss];
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled:YES];
        return NO;
    }
    else if([[returnData objectForKey: @"code"] isEqualToString: @"101"] || [[returnData objectForKey: @"code"] isEqualToString: @"102"] || [[returnData objectForKey: @"code"] isEqualToString: @"110"]){
        [self showMessage: [returnData objectForKey: @"message"]];
        return NO;
    }
    return YES;
}

#pragma mark - 显示提示信息
- (void)showMessage:(NSString *)str{
    [self.tipView showInSuperView: [[UIApplication sharedApplication] keyWindow] message: str];
}

#pragma mark - Notification
- (void)sendAuthorizationErrorNotification
{
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RLUserLogined"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:RLRequestAuthorizationErrorMessage object:nil];
}

//- (void)dealloc{
//    /**
//     *  当self对象销毁时，要将defaultManager(数据请求对象)清空，不然会成为野指针，引起崩溃
//     */
//    defaultManager = nil;
//}
@end
