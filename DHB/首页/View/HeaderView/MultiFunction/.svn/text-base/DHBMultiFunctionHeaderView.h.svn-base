//
//  DHBMultiFunctionHeaderView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DHBMultiFunctionHeaderView_Delegate <NSObject>
- (void)multiFunctionHeaderView_DidSearchButtonClick:(UIButton *) button;
- (void)multiFunctionHeaderView_TextFieldDidBeginEditing:(UITextField *)textField;
- (void)multiFunctionHeaderView_DidScanButtonClick:(UIButton *) button;
- (void)multiFunctionHeaderView_DidCatgoryButtonClick;
@end

@interface DHBMultiFunctionHeaderView : UIView<UITextFieldDelegate>
@property(nonatomic, strong) UIView *categoryView;
@property(nonatomic, strong) UIView *searchView;
@property(nonatomic, assign) id <DHBMultiFunctionHeaderView_Delegate> delegate;
@end
