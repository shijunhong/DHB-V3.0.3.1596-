//
//  DatabaseManager.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//


@class FMDatabaseQueue;
@interface DatabaseManager : NSObject
{
    BOOL _isInitializeSuccess;
    
    BOOL _isDataBaseOpened;
    
    NSString *_writablePath;
    
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, copy) NSString *writablePath;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

+ (DatabaseManager*)currentManager;

- (BOOL)isDatabaseOpened;

- (void)openDataBase;

- (void)closeDataBase;


+ (void)releaseManager;

@end