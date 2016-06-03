//
//  DHBActivitiesViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBActivitiesViewController.h"
@interface DHBActivitiesViewController ()

@end

@implementation DHBActivitiesViewController

#pragma mark - lazyload


#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}
#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTabBar:NO];
    [self showBack:YES];
    [self showTitel:YES andTitelText:L(@"优惠")];
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"DHBActivitiesTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Activities_Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBActivitiesTableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Activities_Cell"];
    
    [cell.name_lb setText:@"满100赠加多宝,老板大放血，赶紧抢！"];
    
    NSString *text = [NSString stringWithFormat:@"促销时间：%@至%@",@"2015-10-01",@"2015-11-01"];
    [cell.time_lb setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange garyRange = [[mutableAttributedString string] rangeOfString:@"促销时间：" options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[HEX_RGB(0x757575) CGColor] range:garyRange];
        return mutableAttributedString;
    }];
    
    text = [NSString stringWithFormat:@"促销描述：%@",@"只要满100，马上送你30元加多宝！机不可失，失不再来，先到先得！"];
    [cell.content_lb setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange garyRange = [[mutableAttributedString string] rangeOfString:@"促销描述：" options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[HEX_RGB(0x757575) CGColor] range:garyRange];
        return mutableAttributedString;
    }];
    
    if (indexPath.row == 0)
    {
        [cell.detail_btn setHidden:NO];
        [cell.detail_vi setHidden:NO];
        [cell.state_vi setHidden:YES];
    }
    else
    {
        [cell.detail_btn setHidden:YES];
        [cell.detail_vi setHidden:YES];
        [cell.state_vi setHidden:NO];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 325;
}

@end
