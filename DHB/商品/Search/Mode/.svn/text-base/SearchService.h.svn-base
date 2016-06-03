//
//  SearchService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DAO.h"
/*!
 @class     SearchService
 @abstract  搜索的service,  获取热门关键字， 增删查历史搜索关键字
 */
@interface SearchService : NSObject

@property(nonatomic,strong)NSString *table_name;//查询表 0:商品历史记录 1:订单历史记录

/*!
 @method        getLatestTwentyKeywordsWithCompletionBlock:
 @abstract      从本地db中获取最后20条搜索历史记录
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)getLatestTwentyKeywordsWithCompletionBlock:(void (^)(NSArray *list))completionBlock;


/*!
 @method        addKeywordToDB:completionBlock:
 @abstract      添加历史关键字到db
 @param         keyword 需要加入db的关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)addKeywordToDB:(NSString *)keyword
       completionBlock:(void (^)(NSArray *list))completionBlock;


/*!
 @method        deleteKeywordFromDB:completionBlock:
 @abstract      删除历史关键字
 @param         keyword 需要删除的关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)deleteKeywordFromDB:(NSString *)keyword 
            completionBlock:(void (^)(NSArray *list))completionBlock;

/*!
 @method        deleteAllKeywordsFromDBWithCompletionBlock:
 @abstract      删除所有历史关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)deleteAllKeywordsFromDBWithCompletionBlock:(void (^)(NSArray *list))completionBlock;

@end



