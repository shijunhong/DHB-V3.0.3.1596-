//
//  DHBTableViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface DHBTableViewController : DHBCommonViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,DHBTableCellDelegate>{
    BOOL _isheader;
    BOOL _reloading;//是否刷新数据
    BOOL _isfirst;
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    EGORefreshTableFooterView * _refreshFooterView;
    //////Cell
//    UITableViewCell *curOperateCell; ///当前操作的cell
    CGRect curOperateCellRect; ///当前操作cell的相对于主视图（self.view）的坐标信息
}
@property (strong, nonatomic)UITableView *tableView;
@property(nonatomic,strong)UIView *foot_vi;//刷新已完成视图
@property (assign, nonatomic)NSInteger currentPage;
@property (assign, nonatomic)NSInteger totalPage;
@property (assign, nonatomic)NSInteger totalCount;

-(void)createHeaderView;
-(void)removeHeaderView;
-(void)createFooterView;
-(void)HeaderRefreshView;
-(void)FooterRefreshView;
-(void)ShowFootView:(BOOL)is_show;//是否显示无数据视图
-(void)scrollViewisHeader:(BOOL)isHeader;
-(void)loadOver;///加载完毕
@end
