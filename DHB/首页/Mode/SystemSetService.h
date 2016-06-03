//
//  SystemSetService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/21.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SystemSetService_Delegate <NSObject>
@optional
- (void)SystemSetService_Compelete: service isSuccess:(BOOL) isSuccess;
@end

@interface SystemSetService : NSObject
@property(nonatomic, assign) id <SystemSetService_Delegate> delegate;
- (void)querySystemData;
- (void)setDivceToken;
@end
