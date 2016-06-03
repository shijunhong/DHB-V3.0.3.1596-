//
//  LoginRecordDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "LoginRecordMouleDTO.h"

@implementation LoginRecordMouleDTO
- (void)parseFromSet:(FMResultSet *) dataSet{
    if(IsNilOrNull(dataSet)){
        return;
    }
    self.phone = [dataSet stringForColumn: @"phone"];
    self.loginDate = (NSDate *)[dataSet stringForColumn: @"addTime"];
}
@end
