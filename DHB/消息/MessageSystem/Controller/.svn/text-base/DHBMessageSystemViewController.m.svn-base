//
//  DHBMessageSystemViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageSystemViewController.h"
#import "DHBMessageSystemCell.h"
#import "DHBMessageWebViewController.h"

@interface DHBMessageSystemViewController ()<MessageSystemServiceDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation DHBMessageSystemViewController

static NSString *identifier_1 = @"orderCell";

-(NSMutableArray *)data_arr{
    if (!_data_arr)
    {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

-(MessageSystemService *)service{
    if (!_service)
    {
        _service = [[MessageSystemService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.is_affiche)
    {
        [self.service queryAfficheData];
    }
    else
    {
        [self.service queryMsgData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitel:YES andTitelText:self.title_str];
    [self showBack:YES];
    [self showTabBar: NO];
    [self.tableView setFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"DHBMessageSystemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier_1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBMessageSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    NSDictionary *dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    if ([[dic EncodeStringFromDicWithKey:@"is_view"] isEqualToString:@"T"])
    {
        [cell.time_lb setTextColor:[UIColor TextGray_Color]];
        [cell.content_lb setTextColor:[UIColor TextGray_Color]];
    }
    else
    {
        [cell.time_lb setTextColor:[UIColor TextBlack_Color]];
        [cell.content_lb setTextColor:[UIColor TextBlack_Color]];
    }
    cell.time_lb.text = [dic EncodeStringFromDicWithKey:@"create_date"];
    cell.content_lb.text = [dic EncodeStringFromDicWithKey:@"document_title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    DHBMessageWebViewController *messageWeb = [[DHBMessageWebViewController alloc] init];
    if (self.is_affiche)
    {
        messageWeb.ids = [dic objectForKey:@"affiche_notice_id"];
        messageWeb.action = @"msgAfficheContent";
    }
    else
    {
        messageWeb.ids = [dic objectForKey:@"sys_notice_id"];
        messageWeb.action = @"msgSystemContent";
    }
    [self.navigationController pushViewController:messageWeb animated:YES];
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    self.service.page = 1;
    if (self.is_affiche)
    {
        [self.service queryAfficheData];
    }
    else
    {
        [self.service queryMsgData];
    }
}

-(void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.service cpage] < [self.service totalPage]){
        self.service.page = self.service.cpage+1;
        if (self.is_affiche)
        {
            [self.service queryAfficheData];
        }
        else
        {
            [self.service queryMsgData];
        }
    }
    else{
        [self loadOver];
    }
}


#pragma mark  MessageSystemServiceDelegate
-(void)messageSystemServiceComplete:(MessageSystemService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        if (service.cpage == 1)
        {
            [self.data_arr removeAllObjects];
        }
        [self.data_arr addObjectsFromArray:service.msglist];
        [self.tableView reloadData];
        [self createFooterView];
    }
    else
    {
        
    }
}
@end
