//
//  SolrSearchHistoryDAO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "SolrSearchHistoryDAO.h"

@implementation SolrSearchHistoryDAO

- (BOOL)deleteAllSearchKeywordsFromDB
{
    __block BOOL isSuccess;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", self.table_name];
        
        isSuccess = [db executeUpdate:sql]; 
    }];
    return isSuccess;
}

- (NSMutableArray *)getAllKeywords
{
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select keywords from %@ order by keyword_id desc",self.table_name];
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:1000];	
        while ([rs next]) {			
            
            NSString *keyword = [rs stringForColumn:@"keywords"];
            
            if (NotNilAndNull(keyword)) {
                [array addObject:keyword];
            }
            
            if ([array count] >= 1000)
            {
                break;
            }
        }	
        [rs close];	
    }];
    return array;
    
}

- (NSMutableArray *)getLastestTwentyKeywords
{
    __block NSMutableArray *array = nil;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select keywords from %@ order by keyword_id desc",self.table_name];
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] initWithCapacity:20];	
        while ([rs next]) {			
            
            NSString *keyword = [rs stringForColumn:@"keywords"];
            
            if (NotNilAndNull(keyword)) {
                [array addObject:keyword];
            }
            
            //搜索要求为10条
            if ([array count] >= 10)
            {
                break;
            }
        }	
        [rs close];	
        
    }];
    return array; 
}

- (BOOL)deleteKeywordFromDB:(NSString *)keyword
{
    if (IsNilOrNull(keyword)) {
        return NO;
    }    
    
    __block BOOL isSuccess;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where keywords = ?",self.table_name];
        
        isSuccess = [db executeUpdate:sql,keyword]; 
    }];
    
    return isSuccess;
}

- (BOOL)isContainKeyword:(NSString *)keyword
{
    __block BOOL isContain = NO;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where keywords = ?",self.table_name];
        
        FMResultSet *rs = [db executeQuery:sql, keyword];	
        
        if (!rs) {
            [rs close];
            return;
        }
        while ([rs next]) {
            [rs close];
            isContain = YES;
        }
        [rs close];
    }];
    return isContain;
}

- (BOOL)addKeywordToDB:(NSString *)keyword
{
    if (IsNilOrNull(keyword)) {
        return NO;
    }
    
    if ([self isContainKeyword:keyword]) {
        [self deleteKeywordFromDB:keyword];
    }
    
    __block BOOL isSuccess;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (keywords)values(?)",self.table_name];
        
        isSuccess = [db executeUpdate:sql, keyword]; 
    }];
    return isSuccess;
}


@end
