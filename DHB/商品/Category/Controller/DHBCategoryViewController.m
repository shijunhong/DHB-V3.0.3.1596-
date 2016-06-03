//
//  DHBCategoryViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/12.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCategoryViewController.h"
#import "DHBCategoryTableViewCell.h"
#import "DHBCategoryTableView.h"
#import "DHBGoodsViewController.h"
@interface DHBCategoryViewController ()<DHBCategoryTableViewDelegate>
@property(strong,nonatomic)DHBCategoryTableView *first_vi;
@property(strong,nonatomic)DHBCategoryTableView *second_vi;
@property(strong,nonatomic)DHBCategoryTableView *third_vi;
@end

@implementation DHBCategoryViewController
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
        _second_vi = [[DHBCategoryTableView alloc] initWithFrame:CGRectMake(self.view.width, 0.0f, (self.view.width/3)*2, self.view.height)];
        _second_vi.delegate = self;
        [_second_vi setBackgroundColor:self.view.backgroundColor];
    }
    return _second_vi;
}

-(DHBCategoryTableView *)third_vi{
    if (!_third_vi)
    {
        _third_vi = [[DHBCategoryTableView alloc] initWithFrame:CGRectMake(self.view.width, 0.0f, self.view.width/3, self.view.height)];
        _third_vi.delegate = self;
        [_third_vi setBackgroundColor:self.view.backgroundColor];
    }
    return _third_vi;
}

-(CategoryService *)categoryService{
    if (!_categoryService)
    {
        _categoryService = [[CategoryService alloc] init];
        _categoryService.delegate = self;
    }
    return _categoryService;
}

#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.categoryService queryData];
    [self showBack:YES];
    [self showTabBar:NO];
    [self showTitel:YES andTitelText:L(@"分类")];
    [self.view addSubview:self.first_vi];
    [self.view addSubview:self.second_vi];
    [self.view addSubview:self.third_vi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CategoryServiceDelegate Methods
-(void)categoryServiceComplete:(CategoryService *)service isSuccess:(BOOL)isSuccess{
    if (isSuccess)
    {
        NSMutableArray *fist_arr = [NSMutableArray array];
        for (CategoryModuleDTO *category in self.categoryService.categoryarr)
        {
            if (category.parent_id ==0)
            {
                [fist_arr addObject:category];
            }
        }
        //添加全部分类
        CategoryModuleDTO *allCategory = [[CategoryModuleDTO alloc] init];
        [allCategory parseFromDict:@{@"category_count":@"0",@"category_id":@"-1",@"category_name":@"全部",@"parent_id":@"0"}];
        allCategory.is_select = YES;
        [fist_arr insertObject:allCategory atIndex:0];
        [self.first_vi showCategory:fist_arr];
    }
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
            [self.second_vi setIs_child:NO ChildViewWidht:0.0f];
            [self.second_vi showCategory:second_arr];
            WS(weakSelf);
            [UIView animateWithDuration:.3 animations:^{
                [weakSelf.second_vi setLeft:weakSelf.view.width-weakSelf.second_vi.width];
                [weakSelf.third_vi setLeft:weakSelf.view.width];
            }];
        }
        else [self ENDCategoryPush:category];
    }
    else if (view == self.second_vi)
    {
        //第二层分类点击
        NSMutableArray *third_arr = [self.categoryService getNextCategory:category];
        if ([third_arr count]>0)
        {
            [self.third_vi showCategory:third_arr];
            WS(weakSelf);
            [self.second_vi setIs_child:YES ChildViewWidht:self.third_vi.width];
            [UIView animateWithDuration:.3 animations:^{
                [weakSelf.third_vi setLeft:weakSelf.view.width-weakSelf.third_vi.width];
            }];
        }
        else [self ENDCategoryPush:category];
    }
    else if (view == self.third_vi)
    {
        //第三层分类点击
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
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
