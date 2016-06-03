//
//  DHBChildCategoryViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBChildCategoryViewController.h"
#import "DHBCategoryTableViewCell.h"
#import "DHBCategoryTableView.h"

@interface DHBChildCategoryViewController ()<DHBCategoryTableViewDelegate>
@property(strong,nonatomic)DHBCategoryTableView *first_vi;
@property(strong,nonatomic)DHBCategoryTableView *second_vi;
@end


@implementation DHBChildCategoryViewController

#pragma mark - lazyload
-(DHBCategoryTableView *)first_vi{
    if (!_first_vi) {
        _first_vi = [[DHBCategoryTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
        _first_vi.delegate = self;
        [_first_vi setBackgroundColor:self.view.backgroundColor];
    }
    return _first_vi;
}

-(DHBCategoryTableView *)second_vi{
    if (!_second_vi)
    {
        _second_vi = [[DHBCategoryTableView alloc] initWithFrame:CGRectMake(self.view.width, 0.0f, self.view.width/2, self.view.height)];
        _second_vi.delegate = self;
        [_second_vi setBackgroundColor:self.view.backgroundColor];
    }
    return _second_vi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack:YES];
    [self showTitel:YES andTitelText:self.category.category_name];
    [self.view addSubview:self.first_vi];
    [self.view addSubview:self.second_vi];
    NSMutableArray *first_arr = [self.categoryService getNextCategory:self.category];
    [self.first_vi showCategory:first_arr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark DHBCategoryTableViewDelegate Methods
-(void)DHBCategoryTableView:(DHBCategoryTableView*)view didSelectCategory:(CategoryModuleDTO *)category{
    if (view == self.first_vi)
    {
        //第一层分类点击
        NSMutableArray *second_arr = [self.categoryService getNextCategory:category];
        if ([second_arr count]>0)
        {
            [self.first_vi setIs_child:YES ChildViewWidht:self.second_vi.width];
            [self.second_vi showCategory:second_arr];
            WS(weakSelf);
            [UIView animateWithDuration:.3 animations:^{
                [weakSelf.second_vi setLeft:weakSelf.view.width-weakSelf.second_vi.width];
            }];
        }
        else [self ENDCategoryPush:category];
    }
    else if (view == self.second_vi)
    {
        //第二层分类点击
        NSMutableArray *child_arr = [self.categoryService getNextCategory:category];
        if ([child_arr count]>0)
        {
            DHBChildCategoryViewController *childCategory = [[DHBChildCategoryViewController alloc] init];
            childCategory.categoryService = self.categoryService;
            [childCategory setPresentMode: self.presentMode];
            childCategory.category = category;
            [self.navigationController pushViewController:childCategory animated:YES];
        }
        else [self ENDCategoryPush:category];
    }
}


/**
 *  没有子分类跳转商品列表
 *
 *  @param category
 */
-(void)ENDCategoryPush:(CategoryModuleDTO*)c{
    CategoryModuleDTO * category = [c copy];
    if([category category_id] == -1)
    {
        ///当选择的全部商品时，需要将类别id变成父id进行查询
        category.category_id = category.parent_id;
    }
    [[ParameterPublic sharedManagered] setCategory:category];
    if(self.presentMode == kNewPush_Mode_Type)
    {
        DHBGoodsViewController *goodsListVC = [[DHBGoodsViewController alloc] init];
        goodsListVC.is_Category = YES;
        [goodsListVC setSelectedCategory: category];
        [self.navigationController pushViewController: goodsListVC animated: YES];
    }
    else
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]animated:YES];
    }
}



@end
