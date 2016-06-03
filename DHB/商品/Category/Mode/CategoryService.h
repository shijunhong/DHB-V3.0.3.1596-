//
//  CategoryService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/13.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryService;
@protocol CategoryServiceDelegate <NSObject>
@optional
- (void)categoryServiceComplete:(CategoryService *)service isSuccess:(BOOL )isSuccess;
@end

@interface CategoryService : NSObject
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong)NSMutableArray *categoryarr;
@property (nonatomic, assign) id<CategoryServiceDelegate> delegate;
- (void)queryData;

/**
 *  获取该分类子分类数组
 *
 *  @param category
 *
 *  @return categorys
 */
-(NSMutableArray *)getNextCategory:(CategoryModuleDTO *)category;
@end
