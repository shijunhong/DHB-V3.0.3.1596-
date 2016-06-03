//
//  SolrSearchHistoryDAO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DAO.h"

@interface SolrSearchHistoryDAO : DAO

@property(nonatomic,strong)NSString *table_name;
- (BOOL)deleteAllSearchKeywordsFromDB;

- (BOOL)deleteKeywordFromDB:(NSString *)keyword;

- (BOOL)addKeywordToDB:(NSString *)keyword;

- (NSMutableArray *)getAllKeywords;

/*获取最后的二十条记录*/
- (NSMutableArray *)getLastestTwentyKeywords;

@end
