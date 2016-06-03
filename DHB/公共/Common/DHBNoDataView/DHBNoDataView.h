//
//  DHBNoDataView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBNoDataView : UIView

+(DHBNoDataView *)sharedManagered;

- (void)showInParentView:(UIView *) parentView message:(NSString *) message;
- (void)showMessageInParentView:(UIView *) parentView message:(NSString *) message;
- (void)dismiss;
@end
