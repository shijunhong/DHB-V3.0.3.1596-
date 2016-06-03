//
//  DHBSupplierListViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBSupplierListService.h"
#import "DHBSupplierListTableViewCell.h"
#import "AppDelegate.h"
#import "MainPageViewController.h"

@interface DHBSupplierListViewController : UIViewController<DHBSupplierListService_Delegate, UITableViewDataSource, UITableViewDelegate>
{
    /**
     *  curOperateDTO: 当前选择的供应商数据模型
     */
    DHBSupplierModuleDTO *curOperateDTO;
}
/**
 *  mainTableView: 主数据源的tableView
 */
@property(nonatomic, retain) UITableView *mainTableView;
/**
 *  mainService: 供应商服务类
 */
@property(nonatomic, retain) DHBSupplierListService *mainService;
/**
 *  titel_lb: 导航栏标题视图
 */
@property(strong,nonatomic)UILabel *titel_lb;
/**
 *  back_btn: 返回按钮视图
 */
@property(strong, nonatomic)UIButton *back_btn;
/**
 *  navigationView: 导航栏视图
 */
@property(strong, nonatomic)UIView *navigationView;

/**
 *  company_id: 推送消息的供应商
 */
@property(nonatomic,assign)NSInteger company_id;

@end
