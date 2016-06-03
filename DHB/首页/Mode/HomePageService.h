//
//  HomePageService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/16.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "HomeFloorDTO.h"
#import "ActivityModuleDTO.h"
#import "FunctionDTO.h"
#import "GoodsModuleDTO.h"
#import "DHBGoodsListRequest.h"

@class HomePageService;
@protocol HomePageServiceDelegate <NSObject>
@optional
- (void)homePageServiceComplete:(HomePageService *)service isSuccess:(BOOL )isSuccess;
@end

@interface HomePageService : NSObject

//错误信息
@property(nonatomic, strong)NSError *error;

//页面名称
@property (nonatomic, copy)NSString *pageName;

//楼层列表数据
@property (nonatomic, strong)NSMutableArray *floorArray;

@property (nonatomic, assign) id<HomePageServiceDelegate> delegate;
/**
 *  获取首页楼层数据
 *  接口只需要terminalID、channnelID、versionNumber
 *  方法内部自动获取这些参数
 */
- (void)queryHomePageData;


@end
