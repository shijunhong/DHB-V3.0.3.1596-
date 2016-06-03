//
//  DHBTableViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
@implementation DHBTableViewController
#pragma mark -
#pragma mark 初始化工作

-(UIView *)foot_vi{
    if (!_foot_vi) {
        _foot_vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.size.width, 0.0f)];
        UIImage *img = [UIImage imageNamed:@"刷新图标"];
        UIImageView *statusImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.tableView.centerX-img.size.width/2, 10.0f, img.size.width, img.size.height)];
        [statusImgView setImage:img];
        [_foot_vi addSubview:statusImgView];
    }
    return _foot_vi;
}

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.0f, self.view.frame.size.width, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setBackgroundColor: [UIColor clearColor]];
        [_tableView setShowsVerticalScrollIndicator: NO]; //默认不显示滚动条
        [self.view addSubview:_tableView];
        ///footerView
        UIView *tableViewFooterView = [[UIView alloc] init];
        [tableViewFooterView setBackgroundColor: [UIColor clearColor]];
        [_tableView setTableFooterView: tableViewFooterView];
    }
    return _tableView;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.currentPage = 0;
        self.totalPage   = 0;
        _isfirst = YES;
    }
    return self;
}

#pragma mark -
#pragma mark ViewController 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    ///不允许屏幕延伸
    [self setEdgesForExtendedLayout: UIRectEdgeNone];
    ///navigation
    [self.navigationView setBackgroundColor:[[UIColor NavBack_Red_Color] colorWithAlphaComponent:1]];
    ///默认创建HeaderView
    [self createHeaderView];
}

#pragma mark TableView
#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark －
#pragma mark -EGORefresh 相关处理方法
/*创建HeaderView*/
-(void)createHeaderView{
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.tableView.bounds.size.height,self.tableView.frame.size.width,self.tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.tableView addSubview:_refreshHeaderView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}
/*销毁HeaderView*/
-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}

/*创建FooterView*/
-(void)createFooterView{
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]){
        //更新footerVeiw的Frame
        _refreshFooterView.frame = CGRectMake(0.0f,height,self.tableView.frame.size.width,SCREEN_HEIGHT);
    }
    else{
        //创建footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,self.tableView.frame.size.width,SCREEN_HEIGHT)];
    }
    _refreshFooterView.delegate = self;
    [self.tableView addSubview:_refreshFooterView];
    [_refreshFooterView refreshLastUpdatedDate];
    _reloading = NO;
}

#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll" object:nil];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.tableView)
    {
        _isfirst = NO;
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}

#pragma mark -
#pragma mark EGORefreshTable Delegate
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    if (aRefreshPos == EGORefreshHeader)
    {
        ///下拉刷新
        [self performSelector:@selector(HeaderRefreshView) withObject:nil afterDelay:0.0f];
    }
    else if(aRefreshPos == EGORefreshFooter)
    {
        ///上拉加在更多
        [self performSelector:@selector(FooterRefreshView) withObject:nil afterDelay:0.0f];
    }
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay: 1.0f];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
    //返回当前刷新状态：是否在刷新
    return _reloading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    //返回刷新时间
    return [NSDate date];
}


#pragma mark -
#pragma mark 数据加载完毕的方法
- (void)finishReloadingData{
    _reloading = NO;
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading: self.tableView];
    }
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading: self.tableView];
    }
}

#pragma mark - 加载完毕
- (void)loadOver{
    [_refreshFooterView setState: EGOOPullRefreshNotMore];
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    [_refreshFooterView setFrame:CGRectMake(0.0f, height,self.tableView.frame.size.width,SCREEN_HEIGHT)];
}

#pragma mark -
#pragma mark 父类方法
/*向上Header刷新获取上一页的数据*/
-(void)HeaderRefreshView{
}
/*向下Foot刷新获取下一页数据*/
-(void)FooterRefreshView{
}
/*是否在顶部*/
-(void)scrollViewisHeader:(BOOL)isHeader{
}

/*是否显示无数据视图*/
-(void)ShowFootView:(BOOL)is_show{
    if (is_show)
    {
        [self.foot_vi setFrame:CGRectMake(0, 0, self.tableView.size.width, 80.0f)];
        [self.foot_vi setHidden:NO];
        self.tableView.tableFooterView = self.foot_vi;
    }
    else
    {
        [self.foot_vi setFrame:CGRectMake(0, 0, self.tableView.size.width, 0.0f)];
        [self.foot_vi setHidden:YES];
        self.tableView.tableFooterView = self.foot_vi;
    }
}


#pragma mark -
#pragma mark 内存处理
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_refreshHeaderView);
    TT_RELEASE_SAFELY(_refreshFooterView);
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    TT_RELEASE_SAFELY(_tableView);
}

#pragma mark - 获取当前cell在self.view的坐标（用于控制键盘的位置）
-(void)DHBTableViewCellBeginEditing:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    curOperateCellRect = [self.tableView convertRect: rectInTableView toView:[self.tableView superview]];
}


#pragma mark - 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *) note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = rect.size.height;
    WS(weakSelf);
    if (curOperateCellRect.origin.y + curOperateCellRect.size.height > self.view.frame.size.height - keyBoardHeight){
        CGFloat origin_y = curOperateCellRect.origin.y + curOperateCellRect.size.height - (self.view.frame.size.height - keyBoardHeight);
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            weakSelf.view.transform = CGAffineTransformMakeTranslation(0, -origin_y);
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    WS(weakSelf);
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        weakSelf.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
