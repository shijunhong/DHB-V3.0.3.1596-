//
//  GoodsNumberView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/4.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardNumberPadReturnTextField.h"
#import "GoodsModuleDTO.h"

#define GoodsNumberDefaultWidth 110.0f
#define GoodsNumberDefaultHeight 25.0f

@class GoodsNumberView;
@protocol GoodsNumberViewDelegate <NSObject>
@optional
-(void)GoodsNumberView_textFieldShouldBeginEditing:(UITextField *)textField;
-(void)GoodsNumberView:(GoodsNumberView*)goodsNumberView changeNum:(NSString *)text;
@end

@interface GoodsNumberView : UIView<UITextFieldDelegate>
@property(strong, nonatomic)GoodsModuleDTO *goods;
@property(strong, nonatomic)UIButton *btnAdd;
@property(strong, nonatomic)UIButton *btnDelete;
@property(assign, nonatomic)double max_num;
@property(assign, nonatomic)double min_num;
@property(strong ,nonatomic)KeyboardNumberPadReturnTextField *numberTF;
@property(weak ,nonatomic)id<GoodsNumberViewDelegate> delegate;
@end
