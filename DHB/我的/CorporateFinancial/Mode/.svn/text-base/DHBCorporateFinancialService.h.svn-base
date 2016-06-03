//
//  DHBCorporateFinancialService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/31/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 50.0F
#import <Foundation/Foundation.h>
#import "HomeFloorDTO.h"
#import "DHBCorporateFinancialRequest.h"
#import "DHBCorporateFinancialModuleDTO.h"
#import "DHBModifyCorporateFinRequest.h"

@protocol DHBCorporateFinancialService_Delegate <NSObject>
- (void)corporateFinancialService_Compelete: service isSuccess:(BOOL)isSuccess;
- (void)corporateFinancialService_DidSubitCompelete: service isSuccess:(BOOL)isSuccess;
@end

@interface DHBCorporateFinancialService : NSObject
@property(nonatomic, retain) NSError *error;
@property(nonatomic, assign) id<DHBCorporateFinancialService_Delegate> delegate;
@property(nonatomic, strong) NSMutableArray *floorsArray;
@property(nonatomic, strong) DHBCorporateFinancialModuleDTO *corporateInfo;

- (void)queryData;
- (void)submitCorporateFinancialData;
@end
