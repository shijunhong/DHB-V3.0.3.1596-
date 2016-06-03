//
//  DHBAlertView.h
//  DHB
//  消息提示单例视图（避免重复显示提示视图而编写的一个单例类）
//  Created by 阿商信息技术有限公司 on 3/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "CustomIOSAlertView.h"

@interface DHBAlertView : CustomIOSAlertView

@property(nonatomic, assign) BOOL isShow;

//单例方法
+(DHBAlertView *)sharedManagered;

- (void)showMessage:(NSString *) message;


//
@property(nonatomic,strong)UILabel *lable;

@end
