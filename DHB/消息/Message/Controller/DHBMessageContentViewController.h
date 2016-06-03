//
//  DHBMessageContentViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "MessageContentService.h"

@interface DHBMessageContentViewController : DHBTableViewController
@property(nonatomic,strong)MessageContentService *service;
@property(nonatomic,strong)UIView *maskView;
@end
