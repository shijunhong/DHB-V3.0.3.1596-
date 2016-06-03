//
//  DHBHomeFunctionView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionDTO.h"
#import "HomeFloorDTO.h"
#import <JSBadgeView.h>

@protocol DHBHomeFunctionViewDelegate <NSObject>
@optional
- (void)functionSelectedDTO:(FunctionDTO*)function;
@end

@interface DHBHomeFunctionView : UIView

@property(strong, nonatomic)NSMutableArray *homeFunction_arr;
@property(assign, nonatomic)NSInteger padding;
@property (nonatomic, assign) id<DHBHomeFunctionViewDelegate> delegate;

- (void)updateViewWithDTO:(HomeFloorDTO *)dto;
- (void)updateViewWithDTO_Version2:(HomeFloorDTO *)dto;
- (void)updateViewWithDTO_Version3:(HomeFloorDTO *)dto;
@end
