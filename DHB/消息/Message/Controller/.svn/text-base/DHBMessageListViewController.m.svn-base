//
//  DHBMessageListViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOMVIEW_HEIGHT 78.0f
#import "DHBMessageListViewController.h"
#import "DHBMsgListCell.h"
#import "DHBMessageContentViewController.h"
#import "DHBAddMessageViewController.h"

@interface DHBMessageListViewController ()<MessageServiceDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation DHBMessageListViewController
static NSString *identifier_1 = @"messageCell";
#pragma mark - lazyload
-(MessageService *)service{
    if (!_service)
    {
        _service= [[MessageService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BOTTOMVIEW_HEIGHT-Titel_HEIGHT, SCREEN_WIDTH, BOTTOMVIEW_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
        DHBButton *btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, (BOTTOMVIEW_HEIGHT - DEFAULT_BUTTON_HEIGHT) / 2.0f, SCREEN_WIDTH-30, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue3];
        [btn setTitle:@"新增留言" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addMessageAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"留言咨询"];
    [self showTabBar:NO];
    [self.service queryMessageData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bottomView];
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.bottomView.height-Titel_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"DHBMsgListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier_1];
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBMsgListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    NSDictionary *dic = [self.service.messagelist safeObjectAtIndex:indexPath.row];
    cell.name_lb.text = [dic objectForKey:@"content"];
    
    UIImageView *headimage_vi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0f, cell.head_vi.bounds.size.width, cell.head_vi.bounds.size.height)];
    [headimage_vi setImage:[UIImage imageNamed:@"admin"]];
    [cell.head_vi addSubview:headimage_vi];
    [cell.brage_vi removeAllSubviews];
    if ([[dic objectForKey:@"is_view"] isEqualToString:@"C"])
    {
        UIImageView *brageimage_vi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.brage_vi.bounds.size.width, cell.brage_vi.bounds.size.height)];
        [brageimage_vi setImage:[UIImage imageNamed:@"new"]];
        [cell.brage_vi addSubview:brageimage_vi];
    }
    [cell.bottomLineView setHidden: NO];
    if([indexPath row] == [self.data_arr count] - 1){
        [cell.bottomLineView setHidden: YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.service.messagelist safeObjectAtIndex:indexPath.row];
    DHBMessageContentViewController *messageContent = [[DHBMessageContentViewController alloc] init];
    messageContent.service.post_title_id = [dic objectForKey:@"post_title_id"];
    [self.navigationController pushViewController:messageContent animated:YES];
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    self.service.page = 1;
    [self.service queryMessageData];
    [self ShowFootView:NO];
}

-(void)FooterRefreshView{
    [super FooterRefreshView];
    ///当前页码小于总页码的时候，不再请求数据
    if([self.service cpage] < [self.service totalPage]){
        self.service.page = self.service.cpage+1;
        [self.service queryMessageData];
        [self ShowFootView:NO];
    }
    else{
        [self ShowFootView:YES];
        [self loadOver];
    }
}

#pragma mark - MessageServiceDelegate
-(void)messageServiceComplete:(MessageService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.messagelist;
//        if ([self.data_arr count] == 0)
//        {
//            DHBAddMessageViewController *addMessage = [[DHBAddMessageViewController alloc] init];
//            [self.navigationController pushViewController:addMessage animated:YES];
//        }
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }
}

-(void)addMessageAction:(UIButton*)sender;{
    DHBAddMessageViewController *addMessage = [[DHBAddMessageViewController alloc] init];
    [self.navigationController pushViewController:addMessage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
