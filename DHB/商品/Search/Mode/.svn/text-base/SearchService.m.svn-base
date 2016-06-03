//
//  SearchService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "SearchService.h"
#import "SolrSearchHistoryDAO.h"

@interface SearchService()

@end


@implementation SearchService


- (void)dealloc {
}


#pragma mark -
#pragma mark history key db manager

- (void)getLatestTwentyKeywordsWithCompletionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    dao.table_name = self.table_name;
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);

}

- (void)addKeywordToDB:(NSString *)keyword
       completionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    dao.table_name = self.table_name;
    [dao addKeywordToDB:keyword];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

- (void)deleteKeywordFromDB:(NSString *)keyword
            completionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    dao.table_name = self.table_name;
    [dao deleteKeywordFromDB:keyword];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

- (void)deleteAllKeywordsFromDBWithCompletionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    dao.table_name = self.table_name;
    [dao deleteAllSearchKeywordsFromDB];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

@end
