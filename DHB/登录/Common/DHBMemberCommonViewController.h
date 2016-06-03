//
//  DHBMemberCommonViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHBMemberCommonViewController : UIViewController
@property(nonatomic, assign) BOOL isRoot;
@property(nonatomic, retain) UILabel *titel_lb;
@property(nonatomic, retain) UIButton *backButton;
@property(strong, nonatomic)UIView *navigationView;
@end
