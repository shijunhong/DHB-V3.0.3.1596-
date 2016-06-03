//
//  DHBMessageSystemViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "MessageSystemService.h"

@interface DHBMessageSystemViewController : DHBTableViewController
@property(nonatomic,strong)MessageSystemService *service;
@property(nonatomic,assign)BOOL is_affiche;//是否自定义栏目
@property(nonatomic,strong)NSString *title_str;
@end
