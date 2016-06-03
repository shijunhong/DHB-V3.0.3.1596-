//
//  DHBKeyboardManager.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/2.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBCommonViewController.h"
#define DidClickButtonDone @"didClickButtonDone"
#define KeyboardManager [DHBKeyboardManager sharedKeyboardManager]
@interface DHBKeyboardManager : NSObject
+ (DHBKeyboardManager *)sharedKeyboardManager;
@property (strong, nonatomic) UIView *cleanMaskView;
@property (assign, nonatomic) BOOL is_shwoCMview;
- (BOOL)validateNumber:(NSString*)str Format:(NSString*)format;
@end
