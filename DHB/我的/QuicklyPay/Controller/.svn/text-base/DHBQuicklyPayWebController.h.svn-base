//
//  DHBQuicklyPayWebController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/11.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "OrderModuleDTO.h"
#import "PayType.h"

typedef enum {
    LOGIN,//登录
    REGISTER,//注册
    PAY//支付
}QuickPayType;

@protocol DHBQuicklyPayWebControllerDelegate <NSObject>
-(void)RegisterUserId:(NSString *)userId;
-(void)PayCompelete:(NSString *)userId;
@end

@interface DHBQuicklyPayWebController : DHBCommonViewController<UIWebViewDelegate,UIImagePickerControllerDelegate>
@property(nonatomic, retain) JSContext *jsContext;
@property(nonatomic, retain) UIWebView *mainWebView;
@property(nonatomic, weak)id <DHBQuicklyPayWebControllerDelegate> delegate;
@property(nonatomic,assign)QuickPayType payType;
@property(nonatomic, strong) OrderModuleDTO *order;//订单
@property(nonatomic, strong)NSString *amount;//付款金额
@property(nonatomic, strong)PayType *curPayType;
@end
