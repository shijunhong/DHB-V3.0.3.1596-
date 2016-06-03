//
//  RBCustomDatePickerView.h
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//  2016-3-24: －－－由熊梓君修改如下：
//  1.优化时间控件
//  2.解决时间选择的极限问题和滑动效果不流畅。
//  3.简化代码

#import <UIKit/UIKit.h>

@class RBCustomDatePickerView;
@protocol RBCustomDatePickerViewDelegate <NSObject>
-(void)RBCustomDatePickerView:(RBCustomDatePickerView*)pickerView selectOkAction:(NSString*)selectTime;
-(void)selectNOAction;
@end

@interface RBCustomDatePickerView : UIView 
@property(weak,nonatomic) id<RBCustomDatePickerViewDelegate> delegate;
@end
