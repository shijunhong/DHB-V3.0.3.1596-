//
//  CategoryService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "CategoryService.h"
#import "DHBCategoryRequest.h"
#import "CategoryModuleDTO.h"
@implementation CategoryService

- (NSMutableArray *)categoryarr
{
    if (!_categoryarr) {
        _categoryarr=[[NSMutableArray alloc]init];
    }
    return _categoryarr;
}


- (void)queryData {
    
    DHBCategoryRequest *request = [[DHBCategoryRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        //构建假数据
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            NSArray *arr= [dic objectForKey:@"data"];
//            NSLog_Red(@"%@",arr);
            for (NSDictionary *dto in arr) {
                CategoryModuleDTO *category = [[CategoryModuleDTO alloc] init];
                [category parseFromDict:dto];
                [self.categoryarr addObject:category];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(categoryServiceComplete:isSuccess:)]) {
                    [_delegate categoryServiceComplete:self isSuccess:YES];
                }
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(categoryServiceComplete:isSuccess:)]) {
                    [_delegate categoryServiceComplete:self isSuccess:NO];
                }
            });
        }
        
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(categoryServiceComplete:isSuccess:)]) {
                [_delegate categoryServiceComplete:self isSuccess:NO];
            }
        });
    }];
}


/**
 *  获取该分类子分类数组
 *
 *  @param category
 *
 *  @return categorys
 */
-(NSMutableArray *)getNextCategory:(CategoryModuleDTO *)category{
    NSMutableArray *arr = [NSMutableArray array];
    for (CategoryModuleDTO *c in self.categoryarr)
    {
        if (c.parent_id == category.category_id)
        {
            c.is_select = NO;
            [arr addObject:c];
        }
    }
    if ([arr count]>0)
    {
        //添加全部分类
        CategoryModuleDTO *allCategory = [[CategoryModuleDTO alloc] init];
        [allCategory parseFromDict:@{@"category_count":@"0",@"category_id":@"-1",@"category_name":category.category_name,@"parent_id": [NSString stringWithFormat: @"%ld",(long)category.category_id]}];
        allCategory.name = @"全部";
        allCategory.is_select = YES;
        [arr insertObject:allCategory atIndex:0];
    }
    return arr;
}


@end
