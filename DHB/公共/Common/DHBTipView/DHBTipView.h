//
//  DHBTipView.h
//  DHB
//  项目中的提示消息视图，黑色透明背景，白色字体，提示之后2s自动消失
//  Created by 阿商信息技术有限公司 on 2/26/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBTipView : UIView
- (void)showInSuperView:(UIView *) parentView message:(NSString *) message;
@end
