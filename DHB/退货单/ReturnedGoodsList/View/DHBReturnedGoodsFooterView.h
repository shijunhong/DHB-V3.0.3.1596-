//
//  DHBReturnedGoodsFooterView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHBReturnedGoodsFooterView_Delegate<NSObject>
- (void)returnedGoodsFooterView_DidCilck:(NSInteger) section;
@end

@interface DHBReturnedGoodsFooterView : UIView
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, assign) id<DHBReturnedGoodsFooterView_Delegate> delegate;
@property(nonatomic, retain) UILabel *orderIDLabel;
@property(nonatomic, assign) NSInteger section;
@end
