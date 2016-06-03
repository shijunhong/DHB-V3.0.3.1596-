//
//  DHBMessageViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageViewController.h"
#import "DHBMessageListCell.h"
#import "DHBMessageOrderViewController.h"
#import "DHBMessageSystemViewController.h"
#import "DHBAddMessageViewController.h"
#import "DHBMessageWebViewController.h"
#import "DHBMessageListViewController.h"
#import "DHBMessageListRequest.h"

@interface DHBMessageViewController ()<MessageListServiceDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation DHBMessageViewController
#pragma mark - lazyload
-(MessageListService *)service{
    if (!_service)
    {
        _service= [[MessageListService alloc] init];
        _service.delegate = self;
    }
    return _service;
}
#pragma mark - Controllerlife
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:YES];
    [self.service queryMessageTip];
    [self.service queryMessageData];
    [self showVender:YES andVenderName:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showShoppingCar:YES];
//    [self showTitel:YES andTitelText:@"消息"];
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - TabBar_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.service.messagelist safeObjectAtIndex:indexPath.row];
    DHBMessageListCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (!cell)
    {
        cell = [[DHBMessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
    [cell updateWithMsgData:dic];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.service.messagelist safeObjectAtIndex:indexPath.row];
//    NSLog_Red(@"dic = %@",dic);
    NSString *name= [dic EncodeStringFromDicWithKey:@"title_value"];
    if ([name isEqualToString:@"order"])
    {
        DHBMessageOrderViewController *messageOrder = [[DHBMessageOrderViewController alloc] init];
        [self.navigationController pushViewController:messageOrder animated:YES];
    }
    else if ([name isEqualToString:@"system"])
    {
        DHBMessageSystemViewController *messageSystem = [[DHBMessageSystemViewController alloc] init];
        messageSystem.title_str = @"系统公告";
        [self.navigationController pushViewController:messageSystem animated:YES];
    }
    else if ([name isEqualToString:@"message"])
    {
        WS(weakSelf);
        DHBMessageListRequest *request = [[DHBMessageListRequest alloc] init];
        request.page = 1;
        request.step = 10;
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            if ([[dic objectForKey:@"code"] intValue] ==100)
            {
                NSDictionary *data = [dic objectForKey:@"data"];
                if ([[data EncodeArrayFromDicWithKey:@"msgPost"] count] == 0)
                {
                    DHBAddMessageViewController *addMessage = [[DHBAddMessageViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addMessage animated:YES];
                }
                else
                {
                    DHBMessageListViewController *messageList = [[DHBMessageListViewController alloc] init];
                    [weakSelf.navigationController pushViewController:messageList animated:YES];
                }
            }
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        }];
    }
    else
    {
        DHBMessageSystemViewController *messageSystem = [[DHBMessageSystemViewController alloc] init];
        messageSystem.title_str = [dic EncodeStringFromDicWithKey:@"title"];
        messageSystem.service.title_value = name;
        messageSystem.is_affiche = YES;
        [self.navigationController pushViewController:messageSystem animated:YES];
    }
}

#pragma mark EGORefresh Methods
-(void)HeaderRefreshView{
    [super HeaderRefreshView];
    [self.service queryMessageData];
}

#pragma mark - MessageListServiceDelegate
- (void)messageListServiceComplete:(MessageListService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.messagelist;
        [self.tableView reloadData];
    }
    else
    {
        [self.data_arr removeAllObjects];
        [self.tableView reloadData];
        [[DHBNoDataView sharedManagered] showInParentView: self.tableView message: @"加载失败，请重新加载"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
