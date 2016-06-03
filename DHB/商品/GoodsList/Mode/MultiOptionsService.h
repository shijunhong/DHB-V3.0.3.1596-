//
//  MultiOptionsService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModuleDTO.h"
@class MultiOptionsService;
@protocol MultiOptionsServiceDelegate <NSObject>
@optional
- (void)multiOptionsServiceComplete:(MultiOptionsService *)service isSuccess:(BOOL)isSuccess;
@end

@interface MultiOptionsService : NSObject

//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, assign)id<MultiOptionsServiceDelegate> delegate;
@property(nonatomic, strong)NSMutableArray *optionslist;
@property(nonatomic, strong)GoodsModuleDTO *goods;
- (void)queryOptionsDataWhitGoodsModuleDTO:(GoodsModuleDTO*)goods;
@end
