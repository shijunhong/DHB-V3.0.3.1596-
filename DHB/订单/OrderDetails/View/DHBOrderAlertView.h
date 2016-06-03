//
//  DHBOrderAlertView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBOrderAlertView : UIView<UITextViewDelegate>

@property(nonatomic,strong)UILabel *titel_lb;
@property(nonatomic,strong)DHBTextView *textView;
@property(nonatomic,strong)UILabel *cntnum_lb;
@end
