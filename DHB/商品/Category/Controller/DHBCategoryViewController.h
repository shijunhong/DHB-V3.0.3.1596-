//
//  DHBCategoryViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/12.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "CategoryService.h"
#import "CategoryModuleDTO.h"
#import "DHBChildCategoryViewController.h"

@interface DHBCategoryViewController : DHBTableViewController <CategoryServiceDelegate>
@property(nonatomic,strong)CategoryService *categoryService;
@property(nonatomic, assign) CateGory_Mode_Type presentMode;
@end
