//
//  DHBReturnedGoodsListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHBReturnedGoodsListRequest.h"
#import "DHBReturnsGoodsModuleDTO.h"

@protocol DHBReturnedGoodsListService_Delegate <NSObject>
@optional
- (void)returnedGoodsListService_Compelete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBReturnedGoodsListService : NSObject
@property(nonatomic, assign) id<DHBReturnedGoodsListService_Delegate> delegate;
@property(nonatomic, retain) NSString *returns_id;
@property(nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) NSMutableDictionary *dataDictionary;
@property(nonatomic, retain) NSError *error;
- (void)queryData;
@end
