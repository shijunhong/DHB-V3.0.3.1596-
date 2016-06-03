//
//  DHBAttachmentViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAttachmentViewController.h"

@interface DHBAttachmentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation DHBAttachmentViewController

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"订单附件"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.attachment_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

#pragma mark TableView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91;
}

@end
