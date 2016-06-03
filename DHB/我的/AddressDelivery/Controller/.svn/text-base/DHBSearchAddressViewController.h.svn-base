//
//  DHBSearchAddressViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/6.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@class DHBSearchAddressViewController;
@protocol DHBSearchAddressViewControllerDelegate <NSObject>
-(void)searchAddressViewController:(DHBSearchAddressViewController*)controller AMapPOI:(AMapPOI*)poi;
@end

@interface DHBSearchAddressViewController : DHBTableViewController
@property(nonatomic,weak)id<DHBSearchAddressViewControllerDelegate>delegate;
@end
