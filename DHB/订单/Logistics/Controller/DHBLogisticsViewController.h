//
//  DHBLogisticsViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "LogisticsService.h"
@interface DHBLogisticsViewController : DHBCommonViewController
@property (weak, nonatomic) IBOutlet UILabel *logistState_lb;
@property (weak, nonatomic) IBOutlet UILabel *logistDate_lb;
@property (weak, nonatomic) IBOutlet UILabel *logistCompy_lb;
@property (weak, nonatomic) IBOutlet UILabel *logistNum_lb;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong) LogisticsService *logisticsService;
@end
