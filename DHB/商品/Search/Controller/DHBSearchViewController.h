//
//  DHBSearchViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBCommonViewController.h"
#import "DHBSearchBar.h"
#import <YAScrollSegmentControl/YAScrollSegmentControl.h>
#import "SearchService.h"
#import "DHBGoodsViewController.h"
#import "DHBScanningErWeiMaViewController.h"

typedef enum {
    kDefault_SearchPresentType = 0,
    kNew_SearchPresentType = 1
}SearchPresentType;

@protocol DHBSearchViewControllerDelegate <NSObject>

-(void)DHBSearchViewController:(UIViewController*)searchViewController searchText:(NSString*)search;
@end


@interface DHBSearchViewController :DHBCommonViewController<DHBSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *search_text;
@property(nonatomic,strong)NSString *table_name;
@property(nonatomic, assign) SearchPresentType presentType;
@property(nonatomic, weak)id<DHBSearchViewControllerDelegate> delegate;
@end
