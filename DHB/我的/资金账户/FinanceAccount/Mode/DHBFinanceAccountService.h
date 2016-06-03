//
//  DHBFinanceAccountService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/24.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHBFinanceAccountServiceDelegate <NSObject>
- (void)financeAccountServiceComplete: service isSuccess:(BOOL) isSuccess;
@end

@interface DHBFinanceAccountService : NSObject
@property(nonatomic, assign) id<DHBFinanceAccountServiceDelegate> delegate;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, strong) NSMutableDictionary *myInfo;
- (void)queryFinanceAccountData;
@end
