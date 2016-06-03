//
//  DHBMessageContentViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/13.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageContentViewController.h"
#import "DHBMessageContentCell.h"
#import "DHBMessageSendRequest.h"

@interface DHBMessageContentViewController ()<MessageContentServiceDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray *data_arr;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)DHBTextView *text_ft;
@property(nonatomic,assign)BOOL keyboard_isShow;
@end

@implementation DHBMessageContentViewController
static NSString *identifier_1 = @"cell";
#pragma mark - getters and setters
- (UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc]  init];
        [_maskView setBackgroundColor: [UIColor clearColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewClick)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

-(MessageContentService *)service{
    if (!_service)
    {
        _service= [[MessageContentService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-80*Multiple-Titel_HEIGHT, SCREEN_WIDTH, 80*Multiple)];
        [_bottomView setBackgroundColor:HEX_RGB(0xf8f8f8)];
        DHBButton *submit_btn = [[DHBButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-70, 20, 70, _bottomView.height-40) style:kDHBButton_StyleValue3];
        [submit_btn setTitle:@"确定" forState:UIControlStateNormal];
        [submit_btn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:submit_btn];
        
        self.text_ft = [[DHBTextView alloc] initWithFrame:CGRectMake(15, 20, submit_btn.left-30, _bottomView.height-40)];
        self.text_ft.layer.borderWidth = 1;
        self.text_ft.layer.borderColor = [UIColor InputBorder_Color].CGColor;
        self.text_ft.layer.cornerRadius = 2.5;
        self.text_ft.font = [UIFont systemFontOfSize:15];
        self.text_ft.delegate = self;
        self.text_ft.tintColor = [UIColor TextRed_Color];
        [_bottomView addSubview:self.text_ft];
    }
    return _bottomView;
}

#pragma mark - load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"留言咨询"];
    [self showTabBar:NO];
    [self.service queryMessageData];
    [self.view addSubview:self.bottomView];
    
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-self.bottomView.height-Titel_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.data_arr safeObjectAtIndex:indexPath.row];
    DHBMessageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
    if (!cell)
    {
        cell = [[DHBMessageContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
    }
    [cell updateViewWithMessageDTO:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

#pragma mark - MessageContentServiceDelegate
-(void)messageContentServiceComplete:(MessageContentService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        self.data_arr = service.messagelist;
        [self.tableView reloadData];
        if (self.tableView.contentSize.height>self.tableView.bounds.size.height)
        {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
        }
    }
    else
    {
        NSLog(@"error = %@",service.error);
    }
}

#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = rect.size.height;
    WS(weakSelf);
    if (self.tableView.contentSize.height>self.view.frame.size.height-Titel_HEIGHT-ty-self.bottomView.frame.size.height)
    {
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//            [weakSelf.tableView setContentOffset:CGPointMake(0.0, weakSelf.tableView.contentSize.height-ty+weakSelf.bottomView.height)];
            /**
             *  调整mask视图
             */
            [weakSelf.maskView setHidden: NO];
            
            [weakSelf.maskView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - ty - self.bottomView.height)];
            [weakSelf.view addSubview: weakSelf.maskView];
            [weakSelf.view bringSubviewToFront: weakSelf.maskView];
            /**
             *  调整tableView的视图
             */
            [weakSelf.tableView setHeight: weakSelf.maskView.height];
            [weakSelf.tableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow: [self.data_arr count] - 1 inSection: 0] atScrollPosition: UITableViewScrollPositionBottom animated: YES];
            /**
             *  调整底部视图
             */
            weakSelf.bottomView.transform = CGAffineTransformMakeTranslation(0, -ty);
        } completion:^(BOOL finished) {
            weakSelf.keyboard_isShow = YES;
        }];
    }
    else
    {
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            weakSelf.bottomView.transform = CGAffineTransformMakeTranslation(0, -ty);
        } completion:^(BOOL finished) {
            weakSelf.keyboard_isShow = YES;
        }];
    }
}

#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    WS(weakSelf);
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [weakSelf.maskView setHidden: YES];
        [weakSelf.tableView setHeight: SCREEN_HEIGHT - weakSelf.bottomView.height - Titel_HEIGHT];
        weakSelf.view.transform = CGAffineTransformIdentity;
        weakSelf.bottomView.transform = CGAffineTransformIdentity;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.data_arr.count - 1 inSection:0];
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    } completion:^(BOOL finished) {
        weakSelf.keyboard_isShow = NO;
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
}


#pragma mark ButtonAction
-(void)submitAction:(UIButton*)sender{
    [self.text_ft resignFirstResponder];
    // 1、增加数据源
    NSString *content = self.text_ft.text;
    [self.data_arr addObject:@{@"content":content,@"create_date":@"尚未发送成功",@"is_manager":@"F"}];
    
    // 2、刷新表格
    [self.tableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.data_arr.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    // 4、清空文本框内容
    self.text_ft.text = nil;
    
    [self senderMessage:content];
}

#pragma mark 提交消息
-(void)senderMessage:(NSString*)content{
    WS(weakSelf);
    DHBMessageSendRequest *request = [[DHBMessageSendRequest alloc] init];
    request.post_title_id = self.service.post_title_id;
    request.content = content;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        if ([[(NSDictionary*)data objectForKey:@"code"] intValue] ==100)
        {
            [weakSelf.service queryMessageData];
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"发送失败")
    }];
}

#pragma mark - maskViewClick
- (void)maskViewClick{
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder) to: nil from: nil forEvent: nil];
}
@end
