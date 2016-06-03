//
//  SiftingService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SiftingModuleDTO.h"
@class SiftingService;
@protocol SiftingServiceDelegate <NSObject>
@optional
- (void)siftingServiceComplete:(SiftingService *)service isSuccess:(BOOL)isSuccess;
@end

@interface SiftingService : NSObject
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic, strong)NSMutableArray *siftinglist;
@property(nonatomic, assign)id<SiftingServiceDelegate> delegate;
@property(nonatomic, assign)NSInteger category_id;
@property(nonatomic, strong)NSString *search_content;
@property(nonatomic, strong)SiftingModuleDTO *sifting;
@property(nonatomic, assign)NSInteger tag_id; ///选中的tag编号

- (void)querySiftingData;
@end
