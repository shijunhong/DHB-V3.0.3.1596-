//
//  DHBProductDetailsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/5.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsDetailsViewController.h"
#import "DHBGoodsDetailsCell.h"
#import "MultiModuleDTO.h"
#import "HomeFloorDTO.h"
#import "DHBAddShoppingCarRequest.h"
#import "DHBFollowGoodsRequest.h"
#import "DHBAlertView.h"

@interface DHBGoodsDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,GoodsDetailsServiceDelegate,DHBGoodsDetailsCellDelegate>{
    UIView *_selectView;
    BOOL correlationState;
//    EGOImageViewEx *_addShoppingCar_iv;
}
@property (strong ,nonatomic) DHBButton *shopping_btn;
@property (strong ,nonatomic) UIView *bottomView;
//@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data_arr;
@property (strong, nonatomic) UIButton *like_btn;
@end

@implementation DHBGoodsDetailsViewController

#pragma mark - lazyload
//-(UITableView *)tableView{
//    if (!_tableView) {
//        //创建 RATreeView∫
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-40)];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView setBackgroundColor: [UIColor clearColor]];
//    }
//    return _tableView;
//}


- (DHBGoodsDetailsService *)goodsDetailsService {
    if (!_goodsDetailsService) {
        _goodsDetailsService = [[DHBGoodsDetailsService alloc] init];
        _goodsDetailsService.delegate = self;
    }
    return _goodsDetailsService;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - Titel_HEIGHT -48, SCREEN_WIDTH, 48)];
        [_bottomView setBackgroundColor:HEX_RGB(0xf2f2f2)];
        //顶部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [topImageView setBackgroundColor: [UIColor CellLine_Color]];
        [_bottomView addSubview:topImageView];
        
        self.shopping_btn = [[DHBButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 48) style: kDHBButton_StyleValue1];
        [self.shopping_btn setTitle:@"加入购物车" forState:UIControlStateNormal];
//        [self.shopping_btn setTitle:@"不能加入购物车" forState:UIControlStateDisabled];
        [self.shopping_btn addTarget:self action:@selector(addShoppingAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.shopping_btn setEnabled: NO];
        [_bottomView addSubview:self.shopping_btn];
        
        self.like_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 48)];
        [self.like_btn setImage:[UIImage imageNamed:@"like2"] forState:UIControlStateSelected];
        [self.like_btn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [self.like_btn setTitle:@"  收藏" forState:UIControlStateNormal];
        [self.like_btn setTitleColor:HEX_RGB(0x757575) forState:UIControlStateNormal];
        [self.like_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.like_btn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.like_btn];
        
    }
    return _bottomView;
}

#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
    [self.goodsDetailsService queryGoodsDetailData];
}

//80
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navView
    [self showTitel:YES andTitelText:@"商品详情"];
    [self showBack:YES];
    [self showShoppingCar:YES];
    //创建 底部视图
    [self.view addSubview:self.bottomView];
    //创建 TableView
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- Titel_HEIGHT - self.bottomView.frame.size.height)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self removeHeaderView];
}


#pragma mark TreeView UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data_arr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:section];
    return floor.floors;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBGoodsDetailsCell *cell = nil;
    
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:indexPath.section];
    NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)[floor.orderNO integerValue]];
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[DHBGoodsDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.delegate = self;
    [cell updateViewWithFloorDTO:floor cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark TreeView UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:indexPath.section];
//    if ([floor.floorName isEqualToString:@"活动"])
//    {
//        if (floor.floors == indexPath.row+1)
//        {
//            return floor.hight+45;
//        }
//    }
    return floor.hight == -1?[self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView]:floor.hight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:section];
    if (floor.is_showHeade)
    {
        if ([floor.templateID isEqualToString:@"3"])
        {
            HomeFloorDTO *tmpFloor = [self.data_arr safeObjectAtIndex: section - 1];
            NSDictionary *tmpDictionary = [[tmpFloor moduleList] firstObject];
            if(tmpDictionary){
                if([[tmpDictionary objectForKey: @"price_arr"] count] > 1){
                    return 10.0f;
                }
            }
            return 0.0f;
        }
        return 45;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floor = [self.data_arr safeObjectAtIndex:section];
    if (floor.is_showHeade)
    {
        if ([floor.templateID isEqualToString:@"3"])
        {
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor: [UIColor whiteColor]];
            return view;
        }
        else{
            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
            [sectionView setBackgroundColor:[UIColor whiteColor]];
            UIButton *goodsIntroduce = [[UIButton alloc] initWithFrame:CGRectMake(sectionView.center.x-98, 0, 98, 42)];
            [goodsIntroduce setTitle:@"商品介绍" forState:UIControlStateNormal];
            [goodsIntroduce.titleLabel setFont:[UIFont systemFontOfSize:15]];
            goodsIntroduce.tag = 0;
            [goodsIntroduce addTarget:self action:@selector(goodsShowAction:) forControlEvents:UIControlEventTouchUpInside];
            [sectionView addSubview:goodsIntroduce];
            
            UIButton *goodsRelevant = [[UIButton alloc] initWithFrame:CGRectMake(sectionView.center.x, 0, 98, 42)];
            [goodsRelevant setTitle:@"相关商品" forState:UIControlStateNormal];
            [goodsRelevant.titleLabel setFont:[UIFont systemFontOfSize:15]];
            goodsRelevant.tag = 1;
            [goodsRelevant addTarget:self action:@selector(goodsShowAction:) forControlEvents:UIControlEventTouchUpInside];
            [sectionView addSubview:goodsRelevant];
            
            //底部还需要划线
            UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45-1, SCREEN_WIDTH, 0.5)];
            [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
            [sectionView addSubview:bottomImageView];
            TT_RELEASE_SAFELY(bottomImageView);
            
            
            if(correlationState)
            {
                _selectView = [[UIView alloc] initWithFrame:CGRectMake(goodsRelevant.left, sectionView.bounds.size.height-2, 98, 2)];
                [goodsRelevant setTitleColor:[UIColor TextRed_Color] forState:UIControlStateNormal];
                [goodsIntroduce setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
            }
            else
            {
                _selectView = [[UIView alloc] initWithFrame:CGRectMake(goodsIntroduce.left, sectionView.bounds.size.height-2, 98, 2)];
                [goodsRelevant setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
                [goodsIntroduce setTitleColor:[UIColor TextRed_Color] forState:UIControlStateNormal];
            }
            [_selectView setBackgroundColor:[UIColor TextRed_Color]];
            [sectionView addSubview:_selectView];
            return sectionView;
        }
    }
    return nil;
}



#pragma mark TreeView ProductDetailsServiceDelegate
- (void)goodsDetailsServiceComplete:(DHBGoodsDetailsService *)service isSuccess:(BOOL )isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.dataArray;
        [self.tableView reloadData];
        [self.like_btn setSelected:service.goods.is_follow];
        if (self.goodsDetailsService.goods.is_out_of_stock)
        {
            [self.shopping_btn setEnabled:NO];
            [self.shopping_btn setBackgroundColor:[UIColor BtnBorder_Color]];
        }
        else{
            [self.shopping_btn setEnabled:YES];
            [self.shopping_btn setBackgroundColor:HEX_RGB(0xfe4600)];
        }
        ////重新加载时，显示上次操作的section
        if(curOperateButton){
            HomeFloorDTO *floor = [self.goodsDetailsService.dataArray objectAtIndex:[self.goodsDetailsService.dataArray count]-1];
            if (curOperateButton.tag ==0)
            {
                floor.templateID = @"7";
                floor.floors = 1;
                floor.hight = 15.0f+(10.0f+12.0f)*[self.goodsDetailsService.goods.field_data count]+20.0f+self.goodsDetailsService.webView.height;
                if ([self.goodsDetailsService.goods.field_data count] == 0 && self.goodsDetailsService.webView.height<=1)
                {
                    floor.hight = 220.0f;
                }
                correlationState = NO;
                floor.orderNO = @"7";
            }
            else if (curOperateButton.tag ==1)
            {
                floor.templateID = @"8";
                floor.hight = 220.0f;
                floor.orderNO = @"8";
                if ([[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]>0)
                {
                    floor.floors = [[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]/2+[[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]%2;
                   
                }
                else
                {
                    floor.floors = 1;
                }
                correlationState = YES;
            }
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:[self.goodsDetailsService.dataArray count]-1] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }
}


-(void)goodsContentComplete:(DHBGoodsDetailsService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.dataArray;
        if (curOperateButton.tag ==0)
        {
            HomeFloorDTO *floor = [self.goodsDetailsService.dataArray objectAtIndex:[self.goodsDetailsService.dataArray count]-1];
            floor.templateID = @"7";
            floor.floors = 1;
            floor.hight = 15.0f+(10.0f+12.0f)*[self.goodsDetailsService.goods.field_data count]+20.0f+self.goodsDetailsService.webView.height;
            if ([self.goodsDetailsService.goods.field_data count] == 0 && self.goodsDetailsService.webView.height<=1)
            {
                floor.hight = 220.0f;
            }
            correlationState = NO;
            floor.orderNO = @"7";
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:[self.goodsDetailsService.dataArray count]-1] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll" object:nil];
//    [firstResponser resignFirstResponder];
}


#pragma mark ButtonAction


//加入购物车
-(void)addShoppingAction:(UIButton*)sender{
    if([[ParameterPublic sharedManagered] client_view_goods_price])//允许查看商品才能添加购物车
    {
        WS(weakSelf);
        [self.goodsDetailsService addShoppingCar:^(NSDictionary *data){
            CGRect rect = [weakSelf.navigationController.view convertRect:sender.frame fromView:sender.superview];
            EGOImageViewEx* shopping_iv = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(rect.origin.x+sender.bounds.size.width/2, rect.origin.y, 44.0f, 44.0f)];
            shopping_iv.layer.cornerRadius = 5;
            shopping_iv.layer.masksToBounds = YES;
            shopping_iv.placeholderImage = [UIImage imageNamed:@"shoppingcart_focused"];
            shopping_iv.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", weakSelf.goodsDetailsService.goods.goods_picture]];
            [weakSelf.navigationController.view addSubview:shopping_iv];
            [shopping_iv bringSubviewToFront:weakSelf.tableView];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [shopping_iv setFrame:CGRectMake(SCREEN_WIDTH-22-5, 15, 22, 22)];
            } completion:^(BOOL finished) {
                [shopping_iv removeFromSuperview];
                [[ParameterPublic sharedManagered] setCart_count:[[data objectForKey:@"number"] integerValue]];
            }];
        }];
    }
    else
    {
        [[DHBAlertView sharedManagered] showMessage:@"对不起，权限不够，您暂时不能添加购物车！"];
    }
}



-(void)likeAction:(UIButton*)sender{
    [sender setEnabled:NO];
    DHBFollowGoodsRequest *request = [[DHBFollowGoodsRequest alloc] init];
    request.goods_id = self.goodsDetailsService.goods.goods_id;
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
            [sender setEnabled:YES];
            NSLog_Red(@"error code=%d ",[[data objectForKey:@"code"] intValue]);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        [sender setEnabled:YES];
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

#pragma mark - 相关商品和商品介绍的切换
-(void)goodsShowAction:(UIButton*)sender{
    for (NSObject *obj in [[sender superview] subviews])
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)obj;
            [btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:[UIColor TextRed_Color] forState:UIControlStateNormal];
    CGRect farme = _selectView.frame;
    
    [UIView animateWithDuration:.3 animations:^{
         _selectView.frame = CGRectMake(sender.left, farme.origin.y, farme.size.width, farme.size.height);
    } completion:^(BOOL finished) {
        curOperateButton = sender;
        HomeFloorDTO *floor = [self.goodsDetailsService.dataArray objectAtIndex:[self.goodsDetailsService.dataArray count]-1];
        if (sender.tag ==0)
        {
            //商品详情
            floor.templateID = @"7";
            floor.floors = 1;
            floor.hight = 15.0f+(10.0f+12.0f)*[self.goodsDetailsService.goods.field_data count]+20.0f+self.goodsDetailsService.webView.height;
            if ([self.goodsDetailsService.goods.field_data count] == 0 && self.goodsDetailsService.webView.height<=1)
            {
                floor.hight = 220.0f;
            }
            correlationState = NO;
            floor.orderNO = @"7";
        }
        else if (sender.tag ==1)
        {
            //相关商品
            floor.templateID = @"8";
            floor.hight= 220.0f;
            if ([[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]>0)
            {
                floor.orderNO = @"8";
                floor.floors = [[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]/2+[[[floor.moduleList safeObjectAtIndex:0] objectForKey:@"goods"] count]%2;
            }
            else
            {
                floor.floors = 1;
            }
            correlationState = YES;
        }
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:[self.goodsDetailsService.dataArray count]-1] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
}

#pragma mark DHBGoodsDetailsCellDelegate
-(void)selectMulti:(NSString *)multiId{
    if (self.goodsDetailsService.goods.is_out_of_stock)
    {
        [self.shopping_btn setEnabled:NO];
        [self.shopping_btn setBackgroundColor:[UIColor BtnBorder_Color]];
    }
    else
    {
        OptionModuleDTO *options = [self.goodsDetailsService.goods getSelectOptions];
        if (options)
        {
            [self.shopping_btn setEnabled:YES];
            [self.shopping_btn setBackgroundColor:HEX_RGB(0xfe4600)];
        }
        else
        {
            [self.shopping_btn setEnabled:NO];
            [self.shopping_btn setBackgroundColor:[UIColor BtnBorder_Color]];
        }
    }
    [self.tableView reloadData];
}

-(void)selectGoods:(GoodsModuleDTO *)goods{
    DHBGoodsDetailsViewController *goodsdetails = [[DHBGoodsDetailsViewController alloc] init];
    goodsdetails.goodsDetailsService.goods_id = goods.goods_id;
    [self.navigationController pushViewController:goodsdetails animated:YES];
}


@end
