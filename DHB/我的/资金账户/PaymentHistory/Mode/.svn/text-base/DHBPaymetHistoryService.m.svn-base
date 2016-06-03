//
//  DHBPaymetHistoryService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/5/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT 50.0f
#import "DHBPaymetHistoryService.h"
#import "DHBPaymentHistoryRequest.h"
#import "DHBPayHistoryInfoModuleDTO.h"
#import "HomeFloorDTO.h"

@implementation DHBPaymetHistoryService

-(NSMutableArray *)floorsArray{
    if (!_floorsArray)
    {
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

- (void)queryListData{
    DHBPaymentHistoryRequest *request = [[DHBPaymentHistoryRequest alloc] init];
    request.status_id = self.status_id;
    request.type_id = self.type_id;
    request.begin_date = self.begin_date;
    request.end_date = self.end_date;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        [self.dataArray removeAllObjects];
        [self.floorsArray removeAllObjects];
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            NSArray *tmp_arr = [[dic objectForKey: @"data"] objectForKey: @"list"];
            NSArray *tmpArray = [self sortedArray:tmp_arr forDicKey:@"create_date"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat: @"yyyy年MM月"];
            NSDictionary *dataDictionary = [NSMutableDictionary dictionary];
            for(NSDictionary *tmpDic in tmpArray){
                DHBPayHistoryInfoModuleDTO *DTO = [[DHBPayHistoryInfoModuleDTO alloc] init];
                [DTO parseFromDict: tmpDic];
                [self.dataArray addObject: DTO];
                NSString *key = [formatter stringFromDate: [DTO create_date]];
                NSMutableArray *groupArray = [NSMutableArray arrayWithArray: [dataDictionary objectForKey: key]];
                [groupArray addObject: DTO];
                if(!groupArray){
                    groupArray = [NSMutableArray arrayWithObject: DTO];
                }
                ///dictionary
                [dataDictionary setValue: groupArray forKey: key];
            }
            ///
            NSArray *keys = [dataDictionary allKeys];
            NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                NSArray *arr1 = [obj1 componentsSeparatedByString:@"年"];
                NSArray *arr2 = [obj2 componentsSeparatedByString:@"年"];
                
                NSInteger year1 = [[arr1 firstObject] integerValue];
                NSInteger year2 = [[arr2 firstObject] integerValue];
                NSInteger month1 = [[[[arr1 lastObject] componentsSeparatedByString:@"月"] firstObject] integerValue];
                NSInteger month2 = [[[[arr2 lastObject] componentsSeparatedByString:@"月"] firstObject] integerValue];
                
                if (year1 > year2)
                {
                    return NSOrderedAscending;
                }
                else if (year1 <year2)
                {
                    return NSOrderedDescending;
                }
                else
                {
                    if (month1 > month2)
                    {
                        return NSOrderedAscending;
                    }
                    else if (month1 <month2)
                    {
                        return NSOrderedDescending;
                    }
                    else
                    {
                        return NSOrderedSame;
                    }
                }
                return NSOrderedSame;
            }];
            
            for(NSString *key in sortedArray){
                [self addFloor: key dataArray: [dataDictionary objectForKey: key]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(paymentHistoryService_omplete:isSuccess:)]) {
                [_delegate paymentHistoryService_omplete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(paymentHistoryService_omplete:isSuccess:)]) {
                [_delegate paymentHistoryService_omplete:self isSuccess:NO];
            }
        });
    }];
}


#pragma mark 添加一个section(楼层)
- (void)addFloor:(NSString *) floorName dataArray:(NSMutableArray *) dataArray{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = floorName;
    floorDTO.moduleList = dataArray;
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    floorDTO.sectionHeight = 40.0f;
    [self.floorsArray addObject:floorDTO];
}


-(NSArray *)sortedArray:(NSArray*)arr forDicKey:(NSString *)key{
    [arr sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSDate *date1 = [formatter dateFromString: [obj1 EncodeStringFromDicWithKey:key]];
        NSDate *date2 = [formatter dateFromString: [obj2 EncodeStringFromDicWithKey:key]];
        return [date1 compare:date2];;
    }];
    return arr;
}


@end
