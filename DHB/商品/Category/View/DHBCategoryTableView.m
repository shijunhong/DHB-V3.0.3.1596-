//
//  DHBCategoryTableView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/27.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCategoryTableView.h"
#import "DHBCategoryTableViewCell.h"


@interface DHBCategoryTableView (){
    
}
@property(assign,nonatomic)BOOL is_child;
@property(assign,nonatomic)CGFloat child_widht;
@end

@implementation DHBCategoryTableView 


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, DEFAULT_LINE_HEIGHT, frame.size.height)];
        [line setBackgroundColor:[UIColor CellLine_Color]];
        [self addSubview:line];
        [self addSubview:self.tableview];
    }
    return self;
}

-(UITableView *)tableview{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview setBackgroundColor: [UIColor clearColor]];
    }
    return _tableview;
}


-(void)showCategory:(NSMutableArray*)category_arr{
    self.category_arr = category_arr;
    [self.tableview reloadData];
}

-(void)setIs_child:(BOOL)is_child ChildViewWidht:(CGFloat)widht{
    self.child_widht = widht;
    self.is_child = is_child;
    if (is_child)
    {
        [self.tableview reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.category_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModuleDTO *category = self.category_arr[indexPath.row];
    DHBCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[DHBCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateViewWithDTO:category];
    [cell moveArrow:self.is_child childWidht:self.child_widht];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self cleanSelect];
    CategoryModuleDTO *category = self.category_arr[indexPath.row];
    category.is_select = YES;
    [self.tableview reloadData];
    
    [self.delegate DHBCategoryTableView:self didSelectCategory:category];
}

-(void)cleanSelect{
    [self.category_arr enumerateObjectsUsingBlock:^(CategoryModuleDTO *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.is_select = NO;
    }];
}

@end
