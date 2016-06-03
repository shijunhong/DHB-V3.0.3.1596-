//
//  DHBHomePageViewController.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/10/12.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define SECTION_HEIGHT 54.0f
#define FOOTER_HEIGHT 59.0f

#import "DHBHomePageViewController.h"
#import "ActivityModuleDTO.h"
#import "GoodsModuleDTO.h"
#import "FunctionDTO.h"
#import "DHBActivitiesViewController.h"
#import "DHBGoodsViewController.h"
#import "DHBLoginViewController.h"
#import "DHBScanningErWeiMaViewController.h"
#import "SystemSetService.h"
#import "DHBNotificationManager.h"
#import "UMessage.h"
#import "DHBTipView.h"

@interface DHBHomePageViewController ()<SystemSetService_Delegate>{
    //存放楼层数据
    NSMutableArray *_floorDataArray;
    BOOL _isInit;//是否第一次进入页面NO :第一次 YES:不是第一次
}
@property(nonatomic,strong)SystemSetService *systemService;
@end

@implementation DHBHomePageViewController

#pragma mark - lazyload
- (HomePageService *)homePageService {
    if (!_homePageService) {
        _homePageService = [[HomePageService alloc] init];
        _homePageService.delegate = self;
    }
    return _homePageService;
}

-(SystemSetService *)systemService{
    if (!_systemService) {
        _systemService = [[SystemSetService alloc] init];
        [_systemService setDelegate: self];
    }
    return _systemService;
}

- (DHBMultiFunctionHeaderView *)functionHeaderView{
    if(!_functionHeaderView){
        _functionHeaderView = [[DHBMultiFunctionHeaderView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SECTION_HEIGHT)];
        [_functionHeaderView setBackgroundColor: HEX_RGB(0xf0f0f0)];
        [_functionHeaderView setDelegate: self];
    }
    return _functionHeaderView;
}

- (UIView *)sectionHeaderView{
    if(!_sectionHeaderView){
        _sectionHeaderView = [[UIView alloc] init];
        [_sectionHeaderView setBackgroundColor: HEX_RGB(0xf0f0f0)];
    }
    return _sectionHeaderView;
}

#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if (self)
    {
        _floorDataArray = [[NSMutableArray alloc] init];
        [_refreshFooterView setState:EGOOPullRefreshNormal];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取系统基础配置信息
    [self.systemService querySystemData];
    [self showTabBar:YES];
    //
    [self showVender:YES andVenderName:nil];
    //读取消息
    [[DHBNotificationManager sharedInstance].service queryMessageTip];
    
//    [UMessage getTags:^(NSSet *responseTags, NSInteger remain, NSError *error) {
//        //                NSLog_Red(@"responseObject = %@",responseTags);
//        [[[DHBTipView alloc] init] showInSuperView:[[UIApplication sharedApplication] keyWindow] message:[NSString stringWithFormat:@"tag:%@",responseTags]];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置DivceToken
    [self.systemService setDivceToken];
    //设置navView
    [self showShoppingCar:YES];
    //设置tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - TabBar_HEIGHT)];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SystemSetService_Delegate
- (void)SystemSetService_Compelete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self showVender: YES andVenderName: nil];
        /**
         *  当系统配置证书获取成功之后，再获取首页数据
         */
        if (!_isInit)
        {
            [self.homePageService queryHomePageData];
            _isInit = YES;
        }
    }
    else{
        [_floorDataArray removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"配置信息获取失败"];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_floorDataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:section];
    return floor.floors;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBHomePageTableViewCell *cell = nil;
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:indexPath.section];
    NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)[floor.orderNO integerValue]];
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[DHBHomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    [cell updateViewWithFloorDTO:floor cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:indexPath.section];
    return floor.hight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:section];
    if (floor.is_showHeade)
    {
        return SECTION_HEIGHT;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:section];
    if (floor.is_showHeade)
    {
       [self.sectionHeaderView addSubview: self.functionHeaderView];
        return self.sectionHeaderView ;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:indexPath.section];
    if([floor.templateID isEqualToString: @"5"]){
        GoodsModuleDTO *goods = [floor.moduleList objectAtIndex: [indexPath row]];
        DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
        goodsDetails.goodsDetailsService.goods_id = goods.goods_id;
        [self.navigationController pushViewController:goodsDetails animated:YES];
    }
}

- (void)DHBHomePageTableViewCell_didSelectRow:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell: cell];
    HomeFloorDTO *floor = [_floorDataArray safeObjectAtIndex:indexPath.section];
    if([floor.templateID isEqualToString: @"5"]){
        GoodsModuleDTO *goods = [floor.moduleList objectAtIndex: [indexPath row]];
        DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
        goodsDetails.goodsDetailsService.goods_id = goods.goods_id;
        [self.navigationController pushViewController:goodsDetails animated:YES];
    }
}

#pragma mark scrollViewisHeader Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /* Description:取出顶部Bannar的DTO，并判断当前的滚动位置来调整“搜索视图”的父视图
       -->1:当滚动视图滚动到Bannar上面的位置时，需要将“搜索视图”的父视图调整为self.view
       -->2:当滚动视图滚动到Bannar下面的位置时，需要将“搜索视图”的父视图调整为tableView的headerView中
    */
    [super scrollViewDidScroll: scrollView];
    HomeFloorDTO *floorDTO = [_floorDataArray firstObject];
    if(floorDTO){
        if(scrollView.contentOffset.y >= floorDTO.hight){
            [self.view insertSubview: self.functionHeaderView aboveSubview: self.tableView];
        }
        else{
            [self.sectionHeaderView addSubview: self.functionHeaderView];
        }
    }
}

#pragma mark HomePageServiceDelegate Methods
- (void)homePageServiceComplete:(HomePageService *)service isSuccess:(BOOL )isSuccess{
    ///加载tableView的footerView
    DHBHomePageFooterView *footerView = [[DHBHomePageFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, FOOTER_HEIGHT)];
//    [footerView setBackgroundColor: [UIColor whiteColor]];
    [footerView setDelegate: self];
    [self.tableView setTableFooterView: footerView];
    
    if (isSuccess)
    {
        _floorDataArray = service.floorArray;
        [self.tableView reloadData];
        //推送进入
        [[DHBNotificationManager sharedInstance] NotificationStartPush];
    }
    else
    {
        [_floorDataArray removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}

#pragma mark - DHBHomePageFooterView_Delegate
- (void)homePageFooterView_DidGoodsListButtonClick{
    DHBGoodsViewController *goodController = [[DHBGoodsViewController alloc] init];
    [self.navigationController pushViewController:goodController animated:YES];
}

#pragma mark - DHBMultiFunctionHeaderView_Delegate
- (void)multiFunctionHeaderView_DidSearchButtonClick:(UIButton *)button
{
    //搜索按钮
    DHBSearchViewController *search = [[DHBSearchViewController alloc] init];
    [search setPresentType: kNew_SearchPresentType];
    [self.navigationController pushViewController:search animated:NO];
}

- (void)multiFunctionHeaderView_TextFieldDidBeginEditing:(UITextField *)textField
{
    DHBSearchViewController *search = [[DHBSearchViewController alloc] init];
    [search setPresentType: kNew_SearchPresentType];
    [self.navigationController pushViewController:search animated:NO];
}

- (void)multiFunctionHeaderView_DidCatgoryButtonClick{
    //分类按钮
    DHBCategoryViewController *categoryVC = [[DHBCategoryViewController alloc] init];
    [categoryVC setPresentMode: kNewPush_Mode_Type];
    [self.navigationController pushViewController: categoryVC animated:YES];
}

- (void)multiFunctionHeaderView_DidScanButtonClick:(UIButton *)button{
    //二维码
    DHBScanningErWeiMaViewController *scanning = [[DHBScanningErWeiMaViewController alloc] init];
    [self.navigationController pushViewController:scanning animated:YES];
}

#pragma mark DHBHomePageTableViewCellDelegate
- (void)selectHomeFloor:(HomeFloorDTO *)floor WithModuleDTO:(NSObject *)dto{
    //方法
    FunctionDTO *module = (FunctionDTO*)dto;
    DHBGoodsViewController *goodController = [[DHBGoodsViewController alloc] init];
    [goodController.goodsListService setGoods_type: [NSString stringWithFormat: @"%ld",(long)[module functionId]]];
    [self.navigationController pushViewController:goodController animated:YES];
}

-(void)homePageTableViewCell_DidGoodsListButtonClick{
    DHBGoodsViewController *goodController = [[DHBGoodsViewController alloc] init];
    [self.navigationController pushViewController:goodController animated:YES];
}

#pragma mark - EGO Delegate下拉刷新
-(void)HeaderRefreshView{
    [self.systemService querySystemData];
    _isInit = NO;
}

@end
