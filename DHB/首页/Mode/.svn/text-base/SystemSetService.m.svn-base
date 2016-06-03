//
//  SystemSetService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/21.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "SystemSetService.h"
#import "DHBSystemSetRequest.h"
#import "DHBMessageRequest.h"
#import "DHBBindDeviceRequest.h"
#import "UMessage.h"
#import "DHBTipView.h"

@implementation SystemSetService
#pragma mark - 获取系统配置
- (void)querySystemData{
    DHBSystemSetRequest *request = [[DHBSystemSetRequest alloc] init];
    request.hidden_effect = YES;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
//            NSLog_Red(@"%@",[dic objectForKey:@"data"]);
            [[ParameterPublic sharedManagered] parseFromDict:[dic objectForKey:@"data"]];
            [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled:YES];
        }
        if([_delegate respondsToSelector: @selector(SystemSetService_Compelete: isSuccess:)]){
            [_delegate SystemSetService_Compelete: self isSuccess: isSuccess];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        if([_delegate respondsToSelector: @selector(SystemSetService_Compelete: isSuccess:)]){
            [_delegate SystemSetService_Compelete: self isSuccess: NO];
        }
    }];
}


#pragma mark - 设置DivceToken
-(void)setDivceToken{
    if(IsNilOrNull([[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"]) || IsStrEmpty([[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"])){
        return;
    }
    DHBBindDeviceRequest *request = [[DHBBindDeviceRequest alloc] init];
    request.device_only = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSueccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES : NO);
        if (isSueccess)
        {
            NSString *str = [[dic objectForKey:@"data"]EncodeStringFromDicWithKey:@"title"];
            
            NSArray *arr = [str componentsSeparatedByString:@","];
//            NSLog_Red(@"%@ = %@ =  %@",dic,str,arr);
            [UMessage addTag:arr response:^(id responseObject, NSInteger remain, NSError *error) {
//                NSLog_Red(@"responseObject = %@",responseObject);
            }];
        }
        
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
    }];
}

@end
