//
//  DAO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DAO.h"
#import "DatabaseManager.h"

@implementation DAO

@synthesize databaseQueue = _databaseQueue;



- (id)init{
    self = [super init];
    
	if(self)
    {
        
		self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
	}
    
	return self;
}


- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened])
    {
        [[DatabaseManager currentManager] openDataBase];
    }
    if (!_databaseQueue) {
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
    }
    [DAO createTablesNeeded];
    return _databaseQueue;
}

+ (void)createTablesNeeded
{
    @autoreleasepool {
        FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
        
        
        [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
            
            /*搜索历史记录词*/
            NSString *sql1 = @"CREATE TABLE IF NOT EXISTS search_history (keyword_id integer PRIMARY KEY NOT NULL, keywords text UNIQUE)";
            
            NSString *sql2 = @"CREATE TABLE IF NOT EXISTS order_history (keyword_id integer PRIMARY KEY NOT NULL, keywords text UNIQUE)";
            
            [database executeUpdate:sql1];
            [database executeUpdate:sql2];
             
        }];
        
    } 
}


@end