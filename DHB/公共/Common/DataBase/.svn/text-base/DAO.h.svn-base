//
//  DAO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

@interface DAO : NSObject {
@protected
    FMDatabaseQueue	*_databaseQueue;
}
       
@end

@interface DAO()

@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;

@end

