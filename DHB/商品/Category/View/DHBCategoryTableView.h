//
//  DHBCategoryTableView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/4/27.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModuleDTO.h"
@class DHBCategoryTableView;
@protocol DHBCategoryTableViewDelegate <NSObject>
-(void)DHBCategoryTableView:(DHBCategoryTableView*)view didSelectCategory:(CategoryModuleDTO *)category;
@end

@interface DHBCategoryTableView : UIView <UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)NSMutableArray *category_arr;
@property(nonatomic,assign)id<DHBCategoryTableViewDelegate> delegate;

-(void)showCategory:(NSMutableArray*)category_arr;
/**
 *  设置点击后有子分类要改变当前视图布局
 *
 *  @param is_child 是否有子分类视图
 *  @param widht    子分类视图宽度
 */
-(void)setIs_child:(BOOL)is_child ChildViewWidht:(CGFloat)widht;
@end
