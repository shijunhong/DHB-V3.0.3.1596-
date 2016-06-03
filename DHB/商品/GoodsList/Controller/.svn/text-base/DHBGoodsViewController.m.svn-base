//
//  DHBProductViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsViewController.h"
#import "DHBGoodsViewCell_1.h"
#import "DHBGoodsViewCell_2.h"
#import "DHBGoodsViewCell_3.h"
#import "DHBGoodsDetailsViewController.h"
#import "DHBCategoryViewController.h"
#import "DHBSiftingWithMarkCell.h"
#import "SiftingModuleDTO.h"
#import "DHBSearchViewController.h"
#import "DHBScanningErWeiMaViewController.h"
#import "HomeFloorDTO.h"
#import "DHBBrandTableViewCell.h"
#import "MultiModuleDTO.h"
#import "DHBGoodsViewCell_5.h"
#import "DHBGoodsViewCell_4.h"
#import "MainPageViewController.h"
#import "DHBFollowGoodsRequest.h"
#import "DHBGoodsHeadView.h"

@interface DHBGoodsViewController ()<DHBSiftingWithMarkDelegate,DHBGoodsViewCellDelegate,DHBSearchViewControllerDelegate,DHBGoodsHeadViewDelegate>
{
    UIView *_sectionView;
}
@property(nonatomic,strong)NSMutableArray *goods_arr;
//sifting 筛选视图in
@property(nonatomic,strong)SiftingService *siftingService;
@property(strong, nonatomic)CDRTranslucentSideBar *siftingView;
@property(strong, nonatomic)UIView *sifting;
@property(weak, nonatomic) IBOutlet UIView *sifting_titelView;
@property(weak, nonatomic) IBOutlet UITableView *sifting_tableView;
@property(strong, nonatomic)NSMutableArray *marks_arr;
@property(nonatomic, strong)UITextField *min_tf;
@property(nonatomic, strong)UITextField *max_tf;
//品牌
@property (strong, nonatomic)CDRTranslucentSideBar *brandViewController;
@property (weak, nonatomic) IBOutlet UITableView *brand_tableView;
@property(strong, nonatomic)NSMutableArray *brand_arr;

//option 规格视图in
@property (nonatomic,strong)MultiOptionsService *multiOptionsService;
@property (strong, nonatomic)CDRTranslucentSideBar *optionViewController;
@property (weak, nonatomic) IBOutlet UITableView *option_tableView;
@property (nonatomic,strong)NSMutableArray *option_arr;
@property (weak, nonatomic) IBOutlet UIButton *addShoppingCar_btn;
@property (weak, nonatomic) IBOutlet UIButton *follow_btn;

//category 分类
@property (nonatomic,strong)DHBCategoryViewController *category;

//背景灰色透明图
@property (nonatomic,strong)UIView *shareBackGroundView;

//搜索
@property(nonatomic, strong) UILabel *search_lb;
@end

@implementation DHBGoodsViewController
static NSString *identifier_1 = @"BrandCell";

#pragma mark - lazyload

-(UIView *)shareBackGroundView{
    if (!_shareBackGroundView)
    {
        _shareBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _shareBackGroundView.opaque = NO;
        [self.view addSubview: _shareBackGroundView];
    }
    return _shareBackGroundView;
}

-(CDRTranslucentSideBar *)siftingView{
    if (!_siftingView)
    {
        _siftingView = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _siftingView.sideBarWidth = SCREEN_WIDTH-60;
        self.siftingView.delegate = self;
        _siftingView.translucentAlpha =0;
        _siftingView.tag = 0;
        UIView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"DHBSiftingView" owner:self options:nil] objectAtIndex:0];
        [_siftingView setContentViewInSideBar:contentView];
        self.sifting_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _siftingView;
}

-(CDRTranslucentSideBar *)brandViewController{
    if (!_brandViewController)
    {
        _brandViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _brandViewController.sideBarWidth = SCREEN_WIDTH-60;
        _brandViewController.delegate = self;
        _brandViewController.translucentAlpha =0;
        _brandViewController.tag = 0;
        [_brandViewController setContentViewInSideBar:[[[NSBundle mainBundle] loadNibNamed:@"DHBBrandView" owner:self options:nil] objectAtIndex:0]];
        self.brand_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *nib = [UINib nibWithNibName:@"DHBBrandTableViewCell" bundle:nil];
        [self.brand_tableView registerNib:nib forCellReuseIdentifier:identifier_1];
    }
    return _brandViewController;
    
}

-(CDRTranslucentSideBar *)optionViewController{
    if (!_optionViewController)
    {
        _optionViewController = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
        _optionViewController.sideBarWidth = SCREEN_WIDTH-60;
        _optionViewController.view.height = SCREEN_HEIGHT - TabBar_HEIGHT;
        self.optionViewController.delegate = self;
        _optionViewController.translucentAlpha =0;
        _optionViewController.tag = 0;
        [_optionViewController setContentViewInSideBar:[[[NSBundle mainBundle] loadNibNamed:@"DHBOptionViewController" owner:self options:nil] objectAtIndex:0]];
    }
    return _optionViewController;
}



-(GoodsListService *)goodsListService{
    if (!_goodsListService)
    {
        _goodsListService = [[GoodsListService alloc] init];
        _goodsListService.delegate = self;
    }
    return _goodsListService;
}

-(SiftingService *)siftingService{
    if (!_siftingService)
    {
        _siftingService = [[SiftingService alloc] init];
        _siftingService.delegate = self;
        [_siftingService querySiftingData];
    }
    return _siftingService;
}

-(MultiOptionsService *)multiOptionsService{
    if (!_multiOptionsService)
    {
        _multiOptionsService = [[MultiOptionsService alloc] init];
        _multiOptionsService.delegate = self;
    }
    return _multiOptionsService;
}

-(NSMutableArray *)goods_arr{
    if (!_goods_arr)
    {
        _goods_arr = [NSMutableArray array];
    }
    return _goods_arr;
}

#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if([[ParameterPublic sharedManagered] observationInfo]){
        [[ParameterPublic sharedManagered] removeObserver:self forKeyPath:@"category"];
    }
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
    [self requetData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navView
    [self showShoppingCar:YES];
    [self showBack:YES];
    //tableView
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT - Titel_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.is_Barcode)
    {
        self.goodsListService.page = 1;
        [self.goodsListService barcodeQueryGoodsData];
    }
    else
    {
        [self.goodsListService queryGoodsData];
    }
    [self requetData];
    /////KVO
    [[ParameterPublic sharedManagered] addObserver:self forKeyPath:@"category" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateData:) name:@"shoppingCarGoodsUpdate" object:nil];
    
}
#pragma mark - 请求数据
- (void)requetData{
    ///如果有选择的分类，需要初始化选择的列表信息
    if(self.selectedCategory){
        self.goodsListService.page = 1;
        self.goodsListService.category_id = self.selectedCategory.category_id;
        self.goodsListService.min_price = 0;
        self.goodsListService.max_price = 0;
        self.goodsListService.goods_type = @"0";
        self.goodsListService.brand_id = 0;
        self.goodsListService.search_content = @"";
        [self.goodsListService queryGoodsData];
    }
    ///如果有搜索内容的话，需要初始化搜索的内容
    if(self.searchContent)
    {
        self.goodsListService.page = 1;
        self.goodsListService.min_price = 0;
        self.goodsListService.max_price = 0;
        self.goodsListService.goods_type = @"0";
        self.goodsListService.brand_id = 0;
        self.goodsListService.category_id = 0;
        self.goodsListService.search_content = _searchContent;
        [self.goodsListService queryGoodsData];
    }
    
    if (self.is_Barcode)
    {
        self.goodsListService.page = 1;
        [self.goodsListService barcodeQueryGoodsData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTitelView{
    [super initTitelView];
    UIButton *search_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6.4, 28, SCREEN_WIDTH-SCREEN_WIDTH/6.4-SCREEN_WIDTH/7.0, 30)];
    [search_btn setBackgroundColor:HEX_RGB(0xc63700)];
    search_btn.layer.cornerRadius = 5;
    [search_btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:search_btn];
    
    UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(search_btn.left+5.0f, search_btn.top + 5.0f, 20.0f, 20.0f)];
    [search setImage:[UIImage imageNamed:@"search_normal"]];
    [self.navigationView addSubview:search];
    
    UIButton *scanning_btn = [[UIButton alloc] initWithFrame:CGRectMake(search_btn.right - 25.0f, search_btn.top + 5.0f, 20.0f, 20.0f)];
    [scanning_btn setImage:[UIImage imageNamed:@"scanning_normal"] forState:UIControlStateNormal];
    [scanning_btn setImage:[UIImage imageNamed:@"scanning_focused"] forState:UIControlStateSelected];
    [scanning_btn addTarget:self action:@selector(scanningAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:scanning_btn];
    
    if(!_search_lb){
        _search_lb = [[UILabel alloc] initWithFrame:CGRectMake(search.right+5, search_btn.bottom-7-16, scanning_btn.left-(search.right+5), 15)];
        _search_lb.font = [UIFont systemFontOfSize:14];
        _search_lb.textColor = HEX_RGB(0xff6046);
        _search_lb.alpha = 0.9;
        _search_lb.text = (self.searchContent ? self.searchContent : @"商品名称/编号/条形码");
    }
    [self.navigationView addSubview: _search_lb];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.option_tableView)
    {
        return [self.option_arr count];
    }
    else if (tableView == self.sifting_tableView)
    {
        return [self.marks_arr count];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.sifting_tableView)
    {
        HomeFloorDTO *floor= [self.marks_arr safeObjectAtIndex:section];
        return floor.floors;
    }
    else if (tableView == self.brand_tableView)
    {
        return [self.brand_arr count];
    }
    else if (tableView == self.option_tableView)
    {
        HomeFloorDTO *floor= [self.option_arr safeObjectAtIndex:section];
        return floor.floors;
    }
    return [self.goods_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.sifting_tableView)
    {
        DHBSiftingWithMarkCell *siftingWithMark_cell = nil;
        HomeFloorDTO *floor = [self.marks_arr safeObjectAtIndex:indexPath.section];
        NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)[floor.orderNO integerValue]];
        siftingWithMark_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!siftingWithMark_cell)
        {
            siftingWithMark_cell = [[DHBSiftingWithMarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            siftingWithMark_cell.delegate = self;
        }
        [siftingWithMark_cell updateViewWithFloorDTO:floor cellForRowAtIndexPath:indexPath];
        siftingWithMark_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return siftingWithMark_cell;
    }
    else if (tableView == self.option_tableView)
    {
        DHBOptionTableViewCell *option_cell = nil;
        HomeFloorDTO *floor = [self.option_arr safeObjectAtIndex:indexPath.section];
        NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)[floor.orderNO integerValue]];
        option_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!option_cell)
        {
            option_cell = [[DHBOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            option_cell.delegate = self;
        }
        [option_cell updateViewWithFloorDTO:floor cellForRowAtIndexPath:indexPath];
        option_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return option_cell;
    }
    else if (tableView == self.brand_tableView)
    {
        BrandModuleDTO *brand = [self.brand_arr safeObjectAtIndex:indexPath.row];
        DHBBrandTableViewCell *brand_cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
        [brand_cell.name_lb setText:brand.brand_name];
        brand_cell.brand_id = brand.brand_id;
        [brand_cell.name_lb setTextColor:[UIColor TextBlack_Color]];
        if (brand.brand_id == 0)
        {
            [brand_cell.name_lb setTextColor:[UIColor TextRed_Color]];
        }
        return brand_cell;
    }
    NSString *identifier = @"goodsCell";
    if ([[ParameterPublic sharedManagered] goods_multi])//启用多规格
    {
        if ([[ParameterPublic sharedManagered] noPic])
        {
            DHBGoodsViewCell_3 *product_cell = nil;
            product_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!product_cell)
            {
                product_cell = [[DHBGoodsViewCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                product_cell.delegate = self;
            }
            [product_cell updateViewWithProductDTO:self.goods_arr[indexPath.row]];
            product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return product_cell;
        }
        identifier = @"goodsCell_1";
        DHBGoodsViewCell_2 *product_cell = nil;
        product_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!product_cell)
        {
            product_cell = [[DHBGoodsViewCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            product_cell.delegate = self;
        }
        [product_cell updateViewWithProductDTO:self.goods_arr[indexPath.row]];
        product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return product_cell;
    }
    else//不启用多规格
    {
        if ([[ParameterPublic sharedManagered] noPic])
        {
            DHBGoodsViewCell_5 *product_cell = nil;
            product_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!product_cell)
            {
                product_cell = [[DHBGoodsViewCell_5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                product_cell.delegate = self;
            }
            [product_cell updateViewWithProductDTO:self.goods_arr[indexPath.row]];
            product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return product_cell;
        }
        identifier = @"goodsCell_1";
        DHBGoodsViewCell_4 *product_cell = nil;
        product_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!product_cell)
        {
            product_cell = [[DHBGoodsViewCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            product_cell.delegate = self;
        }
        [product_cell updateViewWithProductDTO:self.goods_arr[indexPath.row]];
        product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return product_cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.sifting_tableView)
    {
        HomeFloorDTO *floor = [self.marks_arr safeObjectAtIndex:indexPath.section];
        return floor.hight;
    }
    else if (tableView == self.option_tableView)
    {
        HomeFloorDTO *floor = [self.option_arr safeObjectAtIndex:indexPath.section];
        return floor.hight == -1?[self cellHeightForIndexPath:indexPath cellContentViewWidth: SCREEN_WIDTH tableView:self.option_tableView]:floor.hight;
    }
    else if (tableView == self.brand_tableView)
    {
        return 44;
    }
    return 130.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView)
    {
        return 41;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView)
    {
        DHBGoodsHeadView *goodsHead_vi = [[DHBGoodsHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41.0f)];
        [goodsHead_vi setBackgroundColor:[UIColor UIViewBackGroundColor]];
        goodsHead_vi.delegate = self;
        [goodsHead_vi updateViewWithDTO:self.goodsListService];
        
        return goodsHead_vi;
    }
    else if (tableView == self.option_tableView && section == 2)
    {
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor: [UIColor whiteColor]];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.sifting_tableView)
    {
        if (indexPath.section == 2)
        {
            HomeFloorDTO *floor = [self.marks_arr safeObjectAtIndex:indexPath.section];
            [self.brand_arr removeAllObjects];
            self.brand_arr = [NSMutableArray arrayWithArray: floor.moduleList];
            BrandModuleDTO *brand_all = [[BrandModuleDTO alloc] init];
            brand_all.brand_name = @"全部";
            brand_all.brand_id = 0;
            [self.brand_arr insertObject:brand_all atIndex:0];
            [self.brandViewController show];
            curOperateTableViewCell = [tableView cellForRowAtIndexPath: indexPath];
//            [self.siftingView showInViewController:self.brandViewController];
//            [self.brandViewController showInViewController:self.siftingView];
        }
    }
    else if (tableView == self.brand_tableView)
    {
        BrandModuleDTO *brand = [self.brand_arr safeObjectAtIndex:indexPath.row];
        self.goodsListService.brand_id = brand.brand_id;
        self.goodsListService.page = 1;
//        [self.goodsListService queryGoodsData];
        [self.brandViewController dismiss];
        if([curOperateTableViewCell isKindOfClass: [DHBSiftingWithMarkCell class]]){
            [(DHBSiftingWithMarkCell *)curOperateTableViewCell updateBrandViewWithDTO: brand];
        }
        
    }
    else if(tableView == self.tableView)
    {
        DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
        GoodsModuleDTO *goods = [self.goods_arr safeObjectAtIndex:indexPath.row];
        goodsDetails.goodsDetailsService.goods_id = goods.goods_id;
        [self.navigationController pushViewController:goodsDetails animated:YES];
        
    }
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    self.goodsListService.page = 1;
//    [self.goods_arr removeAllObjects];
    [self.goodsListService queryGoodsData];
    [self ShowFootView:NO];
}

-(void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.goodsListService cpage] < [self.goodsListService totalPage]){
        self.goodsListService.page = self.goodsListService.cpage+1;
        [self.goodsListService queryGoodsData];
        [self ShowFootView:NO];
    }
    else
    {
        [self ShowFootView:YES];
        [self loadOver];
    }
}


#pragma mark - 通知 Methods
#pragma mark - 通知修改列表数据 Methods
-(void)UpdateData:(NSNotification *)noti{
    if ([noti.userInfo objectForKey:@"goods_list"])
    {
        NSMutableArray *goods_list = [noti.userInfo  objectForKey:@"goods_list"];
        for (GoodsModuleDTO *goods in goods_list)
        {
            [self.goods_arr enumerateObjectsUsingBlock:^(GoodsModuleDTO *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.goods_id == goods.goods_id)
                {
                    [obj getSelectOptions].units = [goods getSelectOptions].units;
                    [obj getSelectOptions].number = [goods getSelectOptions].number;
                    obj.number = goods.number;
                    if (goods.number>0)
                    {
                        obj.in_cart = YES;
                    }
                }
            }];
        }
    }
    [self.tableView reloadData];
}


#pragma mark － ButtonAction
#pragma mark 打开侧边栏的筛选视图
-(void)DHBGoodsViewCell_didSelectSifting{
    self.siftingService.category_id = [[ParameterPublic sharedManagered] category].category_id;
    self.siftingService.tag_id = [self.goodsListService.goods_type integerValue];
    //    [self.self.siftingView show];
    [self.siftingView showInViewController:self];
}

#pragma mark 跳装至类别选择页面
-(void)DHBGoodsViewCell_didSelectCategory{
    if (self.is_Category)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        self.category = [[DHBCategoryViewController alloc] init];
        self.category.presentMode = kNewPush_Mode_Type;
        [self.navigationController pushViewController:self.category animated:YES];
    }
}

#pragma mark 无图有图切换
-(void)DHBGoodsViewCell_didSelectExchangePic{
    [[ParameterPublic sharedManagered] setNoPic:![[ParameterPublic sharedManagered] noPic]];
    [self.tableView reloadData];
}

#pragma mark 搜索
- (void)searchAction:(UIButton *)sender{
    DHBSearchViewController *search = [[DHBSearchViewController alloc] init];
    search.delegate = self;
    search.table_name = @"search_history";
    search.search_text = self.goodsListService.search_content?self.goodsListService.search_content:@"";
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark 二维码扫描
- (void)scanningAction:(UIButton *)sender{
    DHBScanningErWeiMaViewController *scanning = [[DHBScanningErWeiMaViewController alloc] init];
    [self.navigationController pushViewController:scanning animated:YES];
}

#pragma mark 加入关注
- (IBAction)focusAction:(UIButton *)sender {
    [sender setEnabled:NO];
    DHBFollowGoodsRequest *request = [[DHBFollowGoodsRequest alloc] init];
    request.goods_id = self.multiOptionsService.goods.goods_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        [sender setEnabled:YES];
        if ([[data objectForKey:@"code"] intValue] ==100)
        {
            BOOL is_success = [[[data objectForKey:@"data"] EncodeNumberFromDicWithKey:@"is_success"] integerValue]== 1 ?YES:NO;
            if (is_success)
            {
                [sender setSelected:!sender.selected];
            }
            else
            {
                UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"关注失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [msgbox show];
            }
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[data objectForKey:@"code"] intValue]);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        [sender setEnabled:YES];
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

#pragma mark 加入购物车
- (IBAction)joinShoppingCarAction:(UIButton *)sender {
    if([[ParameterPublic sharedManagered] client_view_goods_price])//允许查看商品才能添加购物车
    {
        WS(weakSelf);
        [self.goodsListService submitToShoppingCar: self.multiOptionsService.goods complete:^(BOOL isSuccess, NSDictionary *responseDic) {
            if(isSuccess){
                CGRect rect = [self.navigationController.view convertRect:sender.frame fromView:sender.superview];
                EGOImageViewEx* shopping_iv = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(rect.origin.x+sender.bounds.size.width/2, rect.origin.y, 44.0f, 44.0f)];
                shopping_iv.layer.cornerRadius = 5;
                shopping_iv.layer.masksToBounds = YES;
                shopping_iv.placeholderImage = [UIImage imageNamed:@"shoppingcart_focused"];
                shopping_iv.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", weakSelf.multiOptionsService.goods.goods_picture]];
                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:shopping_iv];
                [shopping_iv bringSubviewToFront:weakSelf.optionViewController.view];
                
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [shopping_iv setFrame:CGRectMake(SCREEN_WIDTH-22-5, 15, 22, 22)];
                } completion:^(BOOL finished) {
                    [shopping_iv removeFromSuperview];
                    [[ParameterPublic sharedManagered] setCart_count:[[[responseDic objectForKey: @"data"]  objectForKey:@"number"] integerValue]];
                    weakSelf.multiOptionsService.goods.in_cart = YES;
                    NSInteger index = [weakSelf.optionViewController tag];
                    [[weakSelf.goods_arr objectAtIndex: index] setIn_cart: YES];
                    [weakSelf.tableView reloadData];
                }];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:[responseDic objectForKey:@"message"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:  @"对不起，权限不够，您暂时不能添加购物车！" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - GoodsListServiceDelegate Methods
#pragma mark 获取商品数据
-(void)goodsListServiceComplete:(GoodsListService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        if (service.cpage == 1)
        {
            [self.goods_arr removeAllObjects];
        }
        [self.goods_arr addObjectsFromArray:service.goodslist];
        [self.tableView reloadData];
        [self createFooterView];
        ////数据为空
        if(!self.goods_arr || [self.goods_arr count] == 0)
        {
            if ([service isAllGoods])
                [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"您的供货商还未添加商品，您可以去提醒添加"];
            else
                [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"无相关商品"];
        }
    }
    else{
        ////请求错误
        [self.goods_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
    [_refreshFooterView setState:EGOOPullRefreshNormal];
    [_refreshHeaderView setState:EGOOPullRefreshNormal];
    
}


#pragma mark － SiftingButtonAction 筛选控制 处理
#pragma mark 清空筛选
- (IBAction)siftingClear:(UIButton *)sender {
    self.goodsListService.min_price = 0;
    self.goodsListService.max_price = 0;
    self.goodsListService.goods_type = @"0";
    self.goodsListService.brand_id = 0;
    self.min_tf.text = @"";
    self.max_tf.text = @"";
    [self.siftingService setTag_id: 0];
    [self.siftingService querySiftingData];
//    [self.goodsListService queryGoodsData];
}

#pragma mark 筛选确认
- (IBAction)siftingSure:(UIButton *)sender {
    NSString *min_str = self.min_tf.text?self.min_tf.text:@"";
    NSString *max_str = self.max_tf.text?self.max_tf.text:@"";
    if (![min_str isEqualToString:@""] && ![max_str isEqualToString:@""])
    {
        double min = [[NSString stringWithString:self.min_tf.text] doubleValue];
        double max = [[NSString stringWithString:self.max_tf.text] doubleValue];
        if(min>max){
            [[[DHBTipView alloc] init] showInSuperView: [[UIApplication sharedApplication] keyWindow] message: @"最小金额不能大于最大金额"];
            return;
        }
    }
    
    self.goodsListService.page = 1;
    self.goodsListService.min_price = self.min_tf.text;
    self.goodsListService.max_price = self.max_tf.text;
    [self.goodsListService queryGoodsData];
    [self.siftingView dismiss];
}

#pragma mark － CDRTranslucentSideBarDelegate 侧滑栏处理
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated{
    if(sideBar != self.brandViewController)
    {
        self.shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        MainPageViewController *root = (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [root makeTabBarMask: YES];
        WS(weakSelf);
        [self showBackgroundView:YES onClick:^{
            [weakSelf.siftingView dismiss];
            [weakSelf.optionViewController dismiss];
        }];
    }
}
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated{
    if(sideBar != self.brandViewController){
        [self.shareBackGroundView removeFromSuperview];
        self.shareBackGroundView = nil;
        [self showBackgroundView:NO onClick:nil];
        MainPageViewController *root = (MainPageViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [root makeTabBarMask: NO];
    }
}

#pragma mark - DHBSiftingWithMarkDelegate
-(void)selectSiftingCell:(DHBSiftingWithMarkCell*)cell markBtnIndex:(NSUInteger)index{
    HomeFloorDTO *floor = [self.marks_arr safeObjectAtIndex:0];
    TagModuleDTO *tag  = [floor.moduleList safeObjectAtIndex:index];
    self.goodsListService.goods_type = [NSString stringWithFormat: @"%ld", (long)tag.tag_id];
//    for (TagModuleDTO *tag in floor.moduleList)
//    {
//        if (tag.tag_id == index)
//        {
//            tag.is_select = !tag.is_select;
//        }
//    }
}

-(void)selectSiftingCell:(DHBSiftingWithMarkCell*)cell textField:(UITextField*)textField{
    if (textField.tag == 1)
    {
        self.min_tf = textField;
    }
    else if (textField.tag == 2)
    {
        self.max_tf = textField;
    }
}

#pragma mark SiftingServiceDelegate Methods
#pragma mark 筛选条件的请求回调
-(void)siftingServiceComplete:(SiftingService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.marks_arr = service.siftinglist;
        [self.sifting_tableView reloadData];
    }
    else{}
}

#pragma mark - DHBGoodsViewCellDelegate Methods 
#pragma mark - 打开购物车侧滑栏
-(void)DHBGoodsViewCell:(DHBGoodsViewCell_2 *)cell didTouchShoppingCar:(UIButton *)sender GoodsModule:(GoodsModuleDTO *)goods{
    if ([[ParameterPublic sharedManagered] goods_multi])//启用多规格
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell: cell];
        [self.optionViewController setTag: [indexPath row]];
        [self.multiOptionsService queryOptionsDataWhitGoodsModuleDTO:goods];
    }
    else//不启用多规格 直接加入购物车
    {
        if([[ParameterPublic sharedManagered] client_view_goods_price])//允许查看商品才能添加购物车
        {
            WS(weakSelf);
            [self.goodsListService submitToShoppingCar:goods complete:^(BOOL isSuccess, NSDictionary *responseDic) {
                if (isSuccess)
                {
                    CGRect rect = [weakSelf.navigationController.view convertRect:sender.frame fromView:sender.superview];
                    UIImageView *shopping_iv = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, 22, 22)];
                    [shopping_iv setImage:[UIImage imageNamed:@"shoppingcart_normal"]];
                    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:shopping_iv];
                    [shopping_iv bringSubviewToFront:self.optionViewController.view];
                    
                    [UIView animateWithDuration:1 animations:^{
                        [shopping_iv setFrame:CGRectMake(SCREEN_WIDTH-22-5, 15, 22, 22)];
                    } completion:^(BOOL finished) {
                        [shopping_iv removeFromSuperview];
                        [[ParameterPublic sharedManagered] setCart_count:[[[responseDic objectForKey: @"data"] objectForKey:@"number"] integerValue]];
                        goods.in_cart = YES;
                        [weakSelf.tableView reloadData];
                    }];
                }
                else
                {
                    if ([[responseDic objectForKey:@"code"] intValue] == 110)
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:[responseDic objectForKey:@"message"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
                        [alertView show];
                    }
                }
            }];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:  @"对不起，权限不够，您暂时不能添加购物车！" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }
}

#pragma mark - MultiOptionsServiceDelegate Methods
#pragma mark 请求多规格的数据，并打开购物车的侧滑栏
-(void)multiOptionsServiceComplete:(MultiOptionsService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        [self.optionViewController showInViewController:self];
//        [self.optionViewController show];
        self.option_arr = service.optionslist;
        self.option_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.option_tableView reloadData];
        [self.follow_btn setSelected:service.goods.is_follow];
        if (self.multiOptionsService.goods.is_out_of_stock)
        {
            [self.addShoppingCar_btn setEnabled:NO];
            [self.addShoppingCar_btn setBackgroundColor:[UIColor BtnBorder_Color]];
        }
    }
    else
    {
        
    }
}

#pragma mark  DHBSearchViewControllerDelegate Methods
-(void)DHBSearchViewController:(UIViewController *)searchViewController searchText:(NSString *)search{
    self.goodsListService.min_price = 0;
    self.goodsListService.max_price = 0;
    self.goodsListService.goods_type = @"0";
    self.goodsListService.brand_id = 0;
    self.goodsListService.category_id = 0;
//    [[ParameterPublic sharedManagered] setCategory:nil];
    self.goodsListService.search_content = search;
//    [self.goodsListService queryGoodsData];
    ////
    self.searchContent = search;
    [_search_lb setText: [self.searchContent isEqualToString:@""] ?@"商品名称/编号/条形码" : self.searchContent];
}

#pragma mark DHBOptionTableViewCellDelegate
-(void)selectMulti:(NSString*)multiId{
    OptionModuleDTO *option = [self.multiOptionsService.goods getSelectOptions];
    if (self.multiOptionsService.goods.is_out_of_stock)
    {
        [self.addShoppingCar_btn setEnabled:NO];
        [self.addShoppingCar_btn setBackgroundColor:[UIColor BtnBorder_Color]];
    }
    else
    {
        if (option)
        {
            [self.addShoppingCar_btn setEnabled:YES];
            [self.addShoppingCar_btn setBackgroundColor:HEX_RGB(0xfe4600)];
        }
        else
        {
            NSLog(@"不能加入购物车");
            [self.addShoppingCar_btn setEnabled:NO];
            [self.addShoppingCar_btn setBackgroundColor:[UIColor BtnBorder_Color]];
        }
    }
    [self.option_tableView reloadData];
}


#pragma mark KVO Methods
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"category"])
    {
        self.goodsListService.category_id = [[ParameterPublic sharedManagered] category].category_id;
        self.goodsListService.min_price = 0;
        self.goodsListService.max_price = 0;
        self.goodsListService.goods_type = @"0";
        self.goodsListService.brand_id = 0;
        self.goodsListService.search_content = @"";
        ////重新获取商品数据
        self.goodsListService.page = 1; ////⚠注：重新获取数据的时候需要将页面设置在第一页，不然数据源不正常
        [self.goodsListService queryGoodsData];
    }
}

#pragma mark - 导航栏返回按钮点击事件
- (void)viewControllerDidClickBackButton{
    [self.navigationController popToRootViewControllerAnimated: YES];
}
@end
