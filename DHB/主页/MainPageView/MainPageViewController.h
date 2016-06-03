//
//  MainPageViewController.h
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//


@interface MainPageViewController : UITabBarController<UITabBarControllerDelegate>
@property(nonatomic, retain) UIImageView *messageTipView; //消息提示视图;
@property(nonatomic, retain) UIView *tabBarMaskView; //遮蔽视图;
- (void)makeTabBarHidden:(BOOL)hide;
- (void)makeTabBarMask:(BOOL) isMask;
@end
