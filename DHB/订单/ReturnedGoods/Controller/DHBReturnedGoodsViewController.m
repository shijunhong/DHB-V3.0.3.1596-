//
//  DHBReturnedGoodsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedGoodsViewController.h"
#import "DHBReturnedGoodsTableViewCell.h"
#import "OrderModuleDTO.h"
#import "ReturnedSubmitViewController.h"

@interface DHBReturnedGoodsViewController ()<DHBReturnedGoodsTableViewCellDelegate,ReturnedGoodsServiceDelegate>
//底部视图
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)TTTAttributedLabel *total_lb;
@property(nonatomic,strong)UILabel *goods_lb;
@property(nonatomic,assign) double price;
@property(nonatomic,assign) double num;
@end

@implementation DHBReturnedGoodsViewController
static NSString *identifier_1 = @"returnGoodsCell";
-(DHBReturnedGoodsService *)service{
    if (!_service)
    {
        _service = [[DHBReturnedGoodsService alloc] init];
        _service.orders_id = self.orders_id;
        _service.delegate = self;
    }
    return _service;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - Titel_HEIGHT - 50.0f, SCREEN_WIDTH, 50.0f)];
        [_bottomView setBackgroundColor:HEX_RGB(0xf2f2f2)];
        //顶部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
        [topImageView setBackgroundColor:HEX_RGB(0xc5c5c5)];
        [_bottomView addSubview:topImageView];
        
        UIButton *shopping_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150*Multiple, 0, 150*Multiple, 50)];
        [shopping_btn setBackgroundColor:[UIColor BtnSelectBorder_Color]];
        [shopping_btn setTitle:@"提交" forState:UIControlStateNormal];
        [shopping_btn setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
        [shopping_btn addTarget:self action:@selector(addSubimtAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:shopping_btn];
    }
    return _bottomView;
}

-(TTTAttributedLabel *)total_lb{
    if (!_total_lb)
    {
        _total_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15*Multiple, 7, 150, 15)];
        _total_lb.font = [UIFont systemFontOfSize:13];
        [_total_lb setTextColor:[UIColor TextGray_Color]];
        [_total_lb setText:@"合计："];
    }
    return _total_lb;
}

-(UILabel *)goods_lb{
    if (!_goods_lb)
    {
        _goods_lb = [[UILabel alloc] initWithFrame:CGRectMake(15*Multiple, 29, 150, 15)];
        _goods_lb.font = [UIFont systemFontOfSize:13];
        [_goods_lb setTextColor:[UIColor TextGray_Color]];
        [_goods_lb setText:@"商品："];
    }
    return _goods_lb;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.service queryOrderDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTabBar:NO];
    [self showTitel:YES andTitelText:@"选择退货商品"];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.total_lb];
    [self.bottomView addSubview:self.goods_lb];
    
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- Titel_HEIGHT - self.bottomView.frame.size.height)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TreeView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBReturnedGoodsTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell)
    {
        cell = [[DHBReturnedGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateViewWithGoods:[self.data_arr safeObjectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark TreeView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

#pragma mark ButtonAction
-(void)addSubimtAction:(UIButton*)sender{
    ReturnedSubmitViewController *returnedSubmit = [[ReturnedSubmitViewController alloc] init];
    NSMutableArray *selet_goods_arr = [NSMutableArray array];
    for (OrdersgoodsModuleDTO  *ordersgoods in self.data_arr)
    {
        if (ordersgoods.is_select)
        {
            [selet_goods_arr addObject:ordersgoods];
        }
    }
    if ([selet_goods_arr count] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:@"请选择退货商品" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    returnedSubmit.service.totalPrice = [NSString stringWithFormat:@"%.2lf",self.price];
    returnedSubmit.service.goodsnum = [NSString stringWithFormat:@"%.2lf",self.num];
    returnedSubmit.service.orders_num = self.service.orders_num;
    returnedSubmit.service.goods_arr = selet_goods_arr;
    [self.navigationController pushViewController:returnedSubmit animated:YES];
}

#pragma mark DHBReturnedGoodsTableViewCellDelegate
-(void)DHBReturnedGoodsTableViewCell:(DHBReturnedGoodsTableViewCell *)cell is_select:(OrdersgoodsModuleDTO *)ordersgoods{
    self.price = 0.0;
    self.num = 0.0;
    for (OrdersgoodsModuleDTO *ordersgoods in self.data_arr)
    {
        if (ordersgoods.is_select)
        {
            self.price += [ordersgoods.orders_price doubleValue]*[ordersgoods.goods.number doubleValue];
            self.num ++;
        }
    }
    WS(weakSelf);
    [self.total_lb setText:[NSString stringWithFormat:@"合计：%@%.2lf",L(@"￥"),self.price] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@%.2lf",L(@"￥"),weakSelf.price] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextRed_Color] range:redRange];
        
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%.2lf",weakSelf.price] options:NSCaseInsensitiveSearch];
        UIFont *RMBFont = [UIFont systemFontOfSize:15];
        CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
        if (RMBfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
            CFRelease(RMBfont);
        }
        return mutableAttributedString;
    }];
    
    self.goods_lb.text = [NSString stringWithFormat:@"商品：%d",(int)self.num];
}


#pragma mark ReturnedGoodsServiceDelegate
-(void)returnedGoodsServiceComplete:(DHBReturnedGoodsService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.dataArray;
        [self.tableView reloadData];
        ////数据为空
        if([self.data_arr count] == 0)
        {
            [[DHBNoDataView sharedManagered] showInParentView:self.tableView message: @"没有可退商品"];
        }
    }
    else
    {
        [self.data_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}


@end
