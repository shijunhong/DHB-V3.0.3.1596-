//
//  DHBSelectAddressViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/5.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
@class DHBSelectAddressViewController;
@protocol DHBSelectAddressViewControllerDelegate <NSObject>

-(void)selectAddressViewController:(DHBSelectAddressViewController*)controller AMapPOI:(AMapPOI*)poi;
@end

@interface DHBSelectAddressViewController : DHBCommonViewController
@property(weak,nonatomic)id<DHBSelectAddressViewControllerDelegate>delegate;
@end
