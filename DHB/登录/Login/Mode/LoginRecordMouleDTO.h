//
//  LoginRecordDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface LoginRecordMouleDTO : NSObject
@property(nonatomic, strong) NSString *phone; //登录的手机号
@property(nonatomic, strong) NSDate *loginDate; //登录时间
- (void)parseFromSet:(FMResultSet *) dataSet;
@end
