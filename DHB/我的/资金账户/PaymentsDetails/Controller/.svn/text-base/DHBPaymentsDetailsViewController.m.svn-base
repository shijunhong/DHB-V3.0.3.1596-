//
//  PaymentsDetailsViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/1/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBPaymentsDetailsViewController.h"

@implementation DHBPaymentsDetailsViewController

- (DHBPaymentsDetailsService *)mainService{
    if(!_mainService){
        _mainService = [[DHBPaymentsDetailsService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showTabBar: NO];
    [self showBack: YES];
    [self showTitel:YES andTitelText: @"详情"];
    [self showShoppingCar: NO];
    ///
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    ///
    [self.mainService queryDetailsData];
}

- (void)DHBPaymentsDetailsService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mainService floorsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBPaymentsDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBPaymentsDetailsTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    HomeFloorDTO *dto = [[self.mainService floorsArray]  objectAtIndex: [indexPath row]];
    [cell updateViewWithFloorDTO: dto];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: SCREEN_WIDTH tableView: self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
