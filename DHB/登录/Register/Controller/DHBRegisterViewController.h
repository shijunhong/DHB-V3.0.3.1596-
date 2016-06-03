//
//  DHBRegisterViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/2/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol DHBRegisterViewControllerDelegate <NSObject>
-(void)RegisterUserId:(NSString *)userId;
@end

@interface DHBRegisterViewController : DHBCommonViewController<UIWebViewDelegate>
@property(nonatomic, retain) UIWebView *mainWebView;
@property(nonatomic, weak)id <DHBRegisterViewControllerDelegate> delegate;
@end
