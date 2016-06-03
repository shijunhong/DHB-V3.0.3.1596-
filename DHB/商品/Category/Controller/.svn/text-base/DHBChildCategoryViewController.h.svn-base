//
//  DHBChildCategoryViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBTableViewController.h"
#import "CategoryService.h"
#import "CategoryModuleDTO.h"
#import "DHBGoodsViewController.h"

typedef enum {
    kDefault_Mode_Type, //默认的pop跳转
    kNewPush_Mode_Type //选择类别之后跳转到新页面
}CateGory_Mode_Type; ///选择类别之后，跳转的类型

@protocol DHBCategoryViewControllerDelegate <NSObject>

-(void)DHBCategoryViewController:(UIViewController*)controller selectCategory:(CategoryModuleDTO*)category;
@end

@interface DHBChildCategoryViewController : DHBTableViewController
@property(nonatomic, assign) CateGory_Mode_Type presentMode;
@property(nonatomic, strong) CategoryModuleDTO *category;
@property(nonatomic ,strong)CategoryService *categoryService;


@property(weak ,nonatomic)id <DHBCategoryViewControllerDelegate> delegate;

@end
