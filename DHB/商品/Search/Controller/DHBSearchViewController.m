//
//  DHBSearchViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSearchViewController.h"

@interface DHBSearchViewController ()
@property (nonatomic, strong) DHBSearchBar *searchBar;
@property (nonatomic, strong) UIButton *search_btn;
@property (strong,nonatomic) SearchService *searchService;
//@property (strong,nonatomic) YAScrollSegmentControl *scrollSegment;
@property (strong,nonatomic) UIView* hisHeadView;
@property (strong,nonatomic) UITableView* histableView;
@property (strong,nonatomic) NSMutableArray *historyArray;
@property (strong,nonatomic) UIButton *deleteHistory_btn;
@property (strong, nonatomic) UIButton *scanning_btn;
@end

@implementation DHBSearchViewController

#pragma mark - lazyload

-(SearchService *)searchService{
    if (!_searchService)
    {
        _searchService = [[SearchService alloc] init];
        if (!self.table_name)
        {
            self.table_name = @"search_history";
        }
        _searchService.table_name = self.table_name;
    }
    return _searchService;
}

-(DHBSearchBar *)searchBar{
    if (!_searchBar)
    {
        _searchBar = [[DHBSearchBar alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6.4, 28, SCREEN_WIDTH-SCREEN_WIDTH/6.4-SCREEN_WIDTH/7.0, 30)];
        _searchBar.searchTextField.text = self.search_text;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(UIButton *)search_btn{
    if (!_search_btn) {
        _search_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-10, self.searchBar.bottom-7-16, 30, 15)];
        [_search_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_search_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_search_btn setTitle:L(@"搜索") forState:UIControlStateNormal];
        [_search_btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _search_btn;
}

- (UIButton *)scanning_btn{
    if(!_scanning_btn){
        _scanning_btn = [[UIButton alloc] initWithFrame:CGRectMake(_searchBar.right - 25.0f, _searchBar.top + 5.0f, 20.0f, 20.0f)];
        [_scanning_btn setImage:[UIImage imageNamed:@"scanning_normal"] forState:UIControlStateNormal];
        [_scanning_btn setImage:[UIImage imageNamed:@"scanning_focused"] forState:UIControlStateSelected];
        [_scanning_btn addTarget:self action:@selector(scanningAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanning_btn;
}

-(NSMutableArray *)historyArray{
    if (!_historyArray)
    {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

//-(YAScrollSegmentControl *)scrollSegment{
//    if (!_scrollSegment)
//    {
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 45)];
//        [backView setBackgroundColor:[UIColor whiteColor]];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 13, 60 , 20)];
//        [label setTextColor:HEX_RGB(0x999999)];
//        [label setFont:[UIFont systemFontOfSize:14]];
//        [label setText:L(@"热词搜索")];
//        [backView addSubview:label];
//        _scrollSegment = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(60, 0, self.view.bounds.size.width-50, 44)];
//        _scrollSegment.delegate = self;
//        _scrollSegment.edgeMargin = 1;
//        [_scrollSegment setFont:[UIFont systemFontOfSize:12]];
//        [_scrollSegment setTitleColor:HEX_RGB(0x000000) forState:UIControlStateNormal];
//        [backView addSubview:_scrollSegment];
//        [self.view addSubview:backView];
//    }
//    return _scrollSegment;
//}


-(UIView *)hisHeadView{
    if (!_hisHeadView) {
        _hisHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, Titel_HEIGHT, SCREEN_WIDTH, 45)];
        [_hisHeadView setBackgroundColor:[UIColor whiteColor]];
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:HEX_RGB(0x333333)];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setText:L(@"历史搜索")];
        [_hisHeadView addSubview:label];
        label.sd_layout.leftSpaceToView(_hisHeadView, 15.0f).topSpaceToView(_hisHeadView, (_hisHeadView.height - 20.0f) / 2.0f).widthIs(_hisHeadView.width - 30.0f).heightIs(20.0f);
        
        //底部还需要划线
        UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45-1, SCREEN_WIDTH, 0.5)];
        [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
        [_hisHeadView addSubview:bottomImageView];
        TT_RELEASE_SAFELY(bottomImageView);
    }
    return _hisHeadView;
}

-(UITableView *)histableView{
    if (!_histableView)
    {
        _histableView = [[UITableView alloc] initWithFrame:CGRectMake(0,Titel_HEIGHT+45, self.view.bounds.size.width, self.view.bounds.size.height)];
        _histableView.delegate = self;
        _histableView.dataSource = self;
        [_histableView setBackgroundColor: [UIColor clearColor]];
        _histableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _histableView;
}

-(UIButton *)deleteHistory_btn{
    if (!_deleteHistory_btn)
    {
        _deleteHistory_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.centerX-110/2, self.view.centerY+50, 110, 30)];
        [_deleteHistory_btn setTitleColor:HEX_RGB(0x757575) forState:UIControlStateNormal];
        [_deleteHistory_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_deleteHistory_btn setTitle:L(@"清空历史搜索") forState:UIControlStateNormal];
        [_deleteHistory_btn setBackgroundImage:[UIImage imageNamed:@"bt3_normal"] forState:UIControlStateNormal];
        [_deleteHistory_btn addTarget:self action:@selector(deleteHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteHistory_btn;
}

#pragma mark - Controllerlife
- (void)dealloc {
    TT_RELEASE_SAFELY(self.histableView);
}

#pragma mark - View lifecycle
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.searchBar.searchTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:HEX_RGB(0xf8f8f8)];
    [self showTabBar:NO];
    [self showBack:YES];
    WS(weakSelf);
    [self.searchService getLatestTwentyKeywordsWithCompletionBlock:^(NSArray *list) {
        [weakSelf.historyArray addObjectsFromArray:list];
    }];
    [self.view addSubview:self.hisHeadView];
    [self.view addSubview:self.histableView];
//    [self.view addSubview:self.deleteHistory_btn]; ///暂时不做“清空搜索历史”
}

- (void)viewDidAppear:(BOOL)animated{
    [self.searchBar.searchTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.searchBar];
    [self.navigationView addSubview:self.search_btn];
    [self.navigationView addSubview:self.scanning_btn];
}

-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark YAScrollSegmentControlDelegate
//- (void)didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"Button selected at index: %lu", (long)index);
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.historyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    cell.textLabel.text = self.historyArray[indexPath.row];
    [cell.textLabel setTextColor: [UIColor TextGray_Color]];
    [cell.textLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45-1, SCREEN_WIDTH, 0.5)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [cell.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.presentType == kNew_SearchPresentType){
        DHBGoodsViewController *goodsListVC = [[DHBGoodsViewController alloc] init];
        [goodsListVC setSearchContent: [self.historyArray safeObjectAtIndex:indexPath.row]];
        [self.navigationController pushViewController: goodsListVC animated: YES];
    }
    else{
        [self.delegate DHBSearchViewController:self searchText:[self.historyArray safeObjectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar.searchTextField resignFirstResponder];
}

#pragma mark - DHBSearchBarDelegate
- (void)searchFieldSearchButtonClicked:(UITextField *)searchField{
    [self.searchBar.searchTextField resignFirstResponder];
    ////
    if (self.searchBar.searchTextField.text == nil || [self.searchBar.searchTextField.text isEmptyOrWhitespace])
    {
    }
    else
    {
        WS(weakSelf);
        [self.searchService addKeywordToDB:self.searchBar.searchTextField.text completionBlock:^(NSArray *list) {
            [weakSelf.historyArray removeAllObjects];
            [weakSelf.historyArray addObjectsFromArray:list];
            [weakSelf.histableView reloadData];
        }];
    }
    
    if(self.presentType == kNew_SearchPresentType){
        DHBGoodsViewController *goodsListVC = [[DHBGoodsViewController alloc] init];
        [goodsListVC setSearchContent: self.searchBar.searchTextField.text];
        [self.navigationController pushViewController: goodsListVC animated: YES];
    }
    else{
        [self.delegate DHBSearchViewController:self searchText:self.searchBar.searchTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ButtonAction
-(void)searchAction:(UIButton*)sender{
    if (self.searchBar.searchTextField.text == nil || [self.searchBar.searchTextField.text isEmptyOrWhitespace])
    {
    }
    else
    {
        WS(weakSelf);
        [self.searchService addKeywordToDB:self.searchBar.searchTextField.text completionBlock:^(NSArray *list) {
            [weakSelf.historyArray removeAllObjects];
            [weakSelf.historyArray addObjectsFromArray:list];
            [weakSelf.histableView reloadData];
        }];
    }
    
    if(self.presentType == kNew_SearchPresentType){
        DHBGoodsViewController *goodsListVC = [[DHBGoodsViewController alloc] init];
        [goodsListVC setSearchContent: self.searchBar.searchTextField.text];
        [self.navigationController pushViewController: goodsListVC animated: YES];
    }
    else{
        [self.delegate DHBSearchViewController:self searchText:self.searchBar.searchTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)deleteHistoryAction:(UIButton*)sender{
    WS(weakSelf);
    [self.searchService deleteAllKeywordsFromDBWithCompletionBlock:^(NSArray *list) {
        [weakSelf.historyArray removeAllObjects];
        [weakSelf.histableView reloadData];
    }];
}

#pragma mark - 二维码扫描
- (void)scanningAction:(UIButton *)sender{
    DHBScanningErWeiMaViewController *scanning = [[DHBScanningErWeiMaViewController alloc] init];
    [self.navigationController pushViewController:scanning animated:YES];
}
@end
