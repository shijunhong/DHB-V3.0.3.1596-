//
//  DHBReturnedGoodsListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 130.f
#define FOOTER_HEIGHT 45.0F
#import "DHBReturnedGoodsListViewController.h"
@implementation DHBReturnedGoodsListViewController

- (DHBReturnedGoodsListService *)mainService{
    if(!_mainService){
        _mainService = [[DHBReturnedGoodsListService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (NSMutableArray *)dataKeysArray{
    if(!_dataKeysArray){
        _dataKeysArray = [NSMutableArray array];
    }
    return _dataKeysArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTitel: YES andTitelText: @"退货清单"];
    [self showTabBar: NO];
    ///tableView
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    ///service
    [self.mainService queryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark DHBReturnedGoodsListService_Delegate
- (void)returnedGoodsListService_Compelete:(id)service isSuccess:(BOOL)isSuccess{
    self.mainService = service;
    [self.dataKeysArray removeAllObjects];
    for(NSString *key in [[self.mainService dataDictionary] allKeys]){
        [self.dataKeysArray addObject: key];
    }
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataKeysArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [self.dataKeysArray objectAtIndex: section];
    return [[[self.mainService dataDictionary] objectForKey: key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBGoodsViewCell_2 *product_cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if (!product_cell)
    {
        product_cell = [[DHBGoodsViewCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        [product_cell.shoppingCar_btn setHidden:YES];
        [product_cell.num_lb setHidden:NO];
    }
    NSString *key = [self.dataKeysArray objectAtIndex: [indexPath section]];
    DHBReturnsGoodsModuleDTO *ordersgoods = (DHBReturnsGoodsModuleDTO *)[[[self.mainService dataDictionary] objectForKey: key] objectAtIndex: [indexPath row]];
     [product_cell updateViewWithProductDTO:ordersgoods.goods];
    if([ordersgoods returns_price]){
        NSString *price = [NSString stringWithFormat:@"%@%@/%@",L(@"￥"),[ordersgoods returns_price],ordersgoods.goods.base_units];
        [product_cell.price_lb setText:price afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"￥%@",[ordersgoods returns_price]] options:NSCaseInsensitiveSearch];
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
    }
    [product_cell.num_lb setText:[NSString stringWithFormat:@"%d %@",(int)ordersgoods.returns_number,ordersgoods.goods.base_units]];
    
    NSMutableString *options = [NSMutableString string];
    for (NSDictionary *multi in ordersgoods.goods.multi_data)
    {
        [options appendString:[NSString stringWithFormat:@"%@,",[multi EncodeStringFromDicWithKey:@"options_name"]]];
    }
    options = [[NSMutableString alloc] initWithString:[options substringToIndex:([options length]>0?[options length]-1:[options length])]];
    product_cell.options_lb.text = options;
    product_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [product_cell.main_v setBackgroundColor: [UIColor whiteColor]];
    [product_cell.bottomImageView setFrame: CGRectMake(0.0f, CELL_HEIGHT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [product_cell.topImageView setHidden: YES];
    return product_cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DHBReturnedGoodsFooterView *view = [[DHBReturnedGoodsFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, FOOTER_HEIGHT)];
    NSString *key = [self.dataKeysArray objectAtIndex: section];
    [view setDelegate: self];
    [view setSection: section];
    [view.orderIDLabel setText: key];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return FOOTER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section > 0)
        return DEFAULT_SECTION_HEIGHT;
    else
        return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: HEX_RGB(0xe8e8e8)];
    return view;
}

#pragma mark - DHBReturnedGoodsFooterView_Delegate(相关订单)
- (void)returnedGoodsFooterView_DidCilck:(NSInteger)section{
    DHBOrderDetailsViewController *orderDetails = [[DHBOrderDetailsViewController alloc] init];
    NSString *key = [self.dataKeysArray objectAtIndex: section];
    orderDetails.orderDetailsService.orders_id = key;
    [self.navigationController pushViewController:orderDetails animated:YES];
}

#pragma mark - EGO Delegate(刷新和加载更多)
- (void)HeaderRefreshView{
    [super HeaderRefreshView];
    [self.mainService queryData];
}
@end
