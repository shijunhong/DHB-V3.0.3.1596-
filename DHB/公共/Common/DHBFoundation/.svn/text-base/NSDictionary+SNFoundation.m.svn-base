//
//  NSDictionary+SNFoundation.m
//  SNFoundation
//
//  Created by xj on 15/10/15.
//  Copyright (c) 2015年 xj. All rights reserved.
//

#import "NSDictionary+SNFoundation.h"

@implementation NSDictionary (SNFoundation)



-(NSString *)EncodeStringFromDicWithKey:(NSString*) key;
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

-(NSNumber *)EncodeNumberFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

-(NSDictionary *)EncodeDicFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

-(NSArray *)EncodeArrayFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

-(NSArray *)EncodeArrayFromDicUsingParseBlockWithKey:(NSString*)key completion:(id(^)(NSDictionary *innerDic))parseBlock
{
    NSArray *tempList = [self EncodeArrayFromDicWithKey:key];
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto)
            {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}


- (NSString *)toJSONData{
    
    NSString *jsonString = @"";
    if(![NSJSONSerialization isValidJSONObject:self])
    {
        NSLog(@"不是JSON类型数据");
        return jsonString = @"不是JSON类型数据";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil)
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return jsonString = @"JSON转义失败";
}

@end
