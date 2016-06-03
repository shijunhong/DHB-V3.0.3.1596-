//
//  DHBOrderGoodsListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOMVIEW_HEIGHT 74.0f
#import "DHBOrderGoodsListViewController.h"
#import "DHBGoodsViewCell_2.h"
#import "OrderModuleDTO.h"
#import "DHBGoodsDetailsViewController.h"
#import "MultiModuleDTO.h"
#import "DHBOrdersCopyRequest.h"
#import "DHBShoppingViewController.h"
@interface DHBOrderGoodsListViewController ()<UITableViewDataSource,UITableViewDelegate,OrderGoodsListServiceDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation DHBOrderGoodsListViewController
static NSString *identifier_1 = @"goodsCell";

#pragma mark - lazyload

-(OrderGoodsListService *)service{
    if (!_service)
    {
        _service = [[OrderGoodsListService alloc] init];
        _service.orders_id = self.orders_id;
        _service.delegate = self;
    }
    return _service;
}

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - BOTTOMVIEW_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor: [UIColor clearColor]];
    }
    return _tableView;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- BOTTOMVIEW_HEIGHT, SCREEN_WIDTH, BOTTOMVIEW_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, (BOTTOMVIEW_HEIGHT - DEFAULT_BUTTON_HEIGHT) / 2.0f, SCREEN_WIDTH-30, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue4];
        [btn setBackgroundColor: [UIColor clearColor]];
        [btn setTitle:@"再次订购" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"商品清单"];
    if (self.orders_id)
    {
        [self.service queryOrderDetailData];
    }
    [self.view addSubview:self.tableView];
    if (self.HiddenBottomView)
    {
        self.tableView.height += BOTTOMVIEW_HEIGHT;
    }
    else
    {
        [self.view addSubview:self.bottomView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.orderslist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBGoodsViewCell_2 *product_cell = nil;
    product_cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!product_cell)
    {
        product_cell = [[DHBGoodsViewCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
        [product_cell.shoppingCar_btn setHidden:YES];
        [product_cell.num_lb setHidden:NO];
    }
    OrdersgoodsModuleDTO *ordersgoods = self.orderslist[indexPath.row];
    [product_cell updateViewWithProductDTO:ordersgoods.goods];
    NSString *price = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),ordersgoods.orders_price,ordersgoods.goods.base_units];
    [product_cell.price_lb setText:price afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"￥%@",ordersgoods.orders_price] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[HEX_RGB(0xff0000) CGColor] range:redRange];
        
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *RMBFont = [UIFont systemFontOfSize:11];
        CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
        if (RMBfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:RMBRange];
            CFRelease(RMBfont);
        }
        
        NSRange unitRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",ordersgoods.goods.base_units] options:NSCaseInsensitiveSearch];
        UIFont *unitsFont = [UIFont systemFontOfSize:14];
        CTFontRef unitsfont = CTFontCreateWithName((__bridge CFStringRef)unitsFont.fontName, unitsFont.pointSize, NULL);
        if (unitsfont) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)unitsfont range:unitRange];
            CFRelease(unitsfont);
        }
        return mutableAttributedString;
    }];
    [product_cell.num_lb setText:[NSString stringWithFormat:@"%d %@",(int)ordersgoods.orders_number,ordersgoods.goods.base_units]];
    
    NSMutableString *options = [NSMutableString string];
    for (NSDictionary *multi in ordersgoods.goods.multi_data)
    {
        
//        NSLog_Red(@"%@",ordersgoods.goods.multi_data);
        [options appendString:[NSString stringWithFormat:@"%@,",[multi EncodeStringFromDicWithKey:@"options_name"]]];
    }
    options = [[NSMutableString alloc] initWithString:[options substringToIndex:([options length]>0?[options length]-1:[options length])]];
    product_cell.options_lb.text = options;
    product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [product_cell setBackgroundColor: [UIColor clearColor]];
    return product_cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
    GoodsModuleDTO *goods = [self.orderslist safeObjectAtIndex:indexPath.row];
    goodsDetails.goodsDetailsService.goods_id = goods.goods_id;
    [self.navigationController pushViewController:goodsDetails animated:YES];
}


#pragma mark - OrderGoodsListServiceDelegate
-(void)orderGoodsListServiceComplete:(OrderGoodsListService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.orderslist = service.dataArray;
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }

}

#pragma mark -
-(void)copyAction:(UIButton*)sender{
    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"再次订购，购物车中的原有商品会被清空哟" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [msg show];
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        DHBOrdersCopyRequest *request = [[DHBOrdersCopyRequest alloc] init];
        request.orders_id = self.orders_id;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            if ([[data objectForKey:@"code"] intValue] ==100)
            {
                BOOL is_success = [[[data objectForKey:@"data"] EncodeNumberFromDicWithKey:@"is_success"] integerValue]== 1 ?YES:NO;
                if (!is_success)
                {
                    UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"再次订购失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [msgbox show];
                }
                else
                {
                    DHBShoppingViewController *shopping = [[DHBShoppingViewController alloc] init];
                    [self.navigationController pushViewController:shopping animated:NO];
                }
            }
            else
            {
                NSLog_Red(@"error code=%d ",[[data objectForKey:@"code"] intValue]);
            }
            
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        }];
    }
}

@end
