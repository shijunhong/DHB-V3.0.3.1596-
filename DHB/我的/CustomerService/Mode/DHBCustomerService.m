//
//  DHBCustomerService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/5/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#import "DHBCustomerService.h"

@implementation DHBCustomerService

- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [[NSMutableArray alloc] init];
    }
    return _floorsArray;
}

#pragma mark - 查询数据
- (void)queryData{
    DHBCustomerRequest *request = [[DHBCustomerRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        [self.floorsArray removeAllObjects];
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            NSArray *dataArray = [[dic objectForKey: @"data"] objectForKey: @"serviceList"];
            for(NSDictionary *dic in dataArray){
                DHBCustomerModuleDTO *dto = [[DHBCustomerModuleDTO alloc] init];
                [dto parseFromDict: dic];
                [self insertSecondFloor: [NSMutableArray arrayWithObject: dto]];
            }
            
//            NSMutableArray *firstArray = [NSMutableArray array];
//            NSMutableArray *secondArray = [NSMutableArray array];
//            for(NSDictionary *dic in dataArray){
//                DHBCustomerModuleDTO *dto = [[DHBCustomerModuleDTO alloc] init];
//                [dto parseFromDict: dic];
//                if([[dto type] isEqualToString: @"电话"]){
//                    [secondArray addObject: dto];
//                }
//                else{
//                    [firstArray addObject: dto];
//                }
//            }
//            [self insertFirstFloor:firstArray];
//            [self insertSecondFloor:secondArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(customerService_Compelete:isSuccess:)]){
                [_delegate customerService_Compelete: self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(customerService_Compelete:isSuccess:)]){
                [_delegate customerService_Compelete: self isSuccess: NO];
            }
        });
    }];
//    NSArray *tmpArray = [NSArray arrayWithObjects: [NSDictionary dictionaryWithObjectsAndKeys: @"业务咨询",@"name",@"592514848",@"contactMethod", @"QQ",@"type", nil],[NSDictionary dictionaryWithObjectsAndKeys: @"售后服务",@"name",@"331290776",@"contactMethod", @"QQ",@"type", nil],[NSDictionary dictionaryWithObjectsAndKeys: @"业务咨询",@"name",@"354554",@"contactMethod", @"Ali",@"type", nil],[NSDictionary dictionaryWithObjectsAndKeys: @"售后服务",@"name",@"猫－客服",@"contactMethod", @"weixin",@"type", nil],[NSDictionary dictionaryWithObjectsAndKeys: @"售后电话",@"name",@"400-6332-453",@"contactMethod", @"phone",@"type", nil],[NSDictionary dictionaryWithObjectsAndKeys: @"售后电话",@"name",@"400-6332-453",@"contactMethod", @"phone",@"type", nil], nil];
}

- (void)insertFirstFloor:(NSMutableArray *) data{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"在线客服";
    ///模拟数据
//    NSMutableArray *tmpArray = [NSMutableArray array];
//    for(NSInteger i = 0; i < 4; i++){
//        DHBCustomerModuleDTO *dto = [[DHBCustomerModuleDTO alloc] init];
//        [dto setName: [NSString stringWithFormat: @"QQ%ld", (long)i]];
//        [dto setContactMethod: [NSString stringWithFormat: @"1878299059%ld", (long)i]];
//        [tmpArray addObject: dto];
//    }
    ///
    floorDTO.moduleList = data;
    floorDTO.hight = SERVICE_CELL_HEIGHT;
    floorDTO.templateID = @"1";
    floorDTO.floors =3;
    floorDTO.sectionHeight = 0.0f;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor:(NSMutableArray *) data{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"";
//    ///模拟数据
//    NSMutableArray *tmpArray = [NSMutableArray array];
//    for(NSInteger i = 0; i < 4; i++){
//        DHBCustomerModuleDTO *dto = [[DHBCustomerModuleDTO alloc] init];
//        [dto setName: [NSString stringWithFormat: @"公司信息%ld", (long)i]];
//        [dto setContactMethod: [NSString stringWithFormat: @"400-6311-682%ld", (long)i]];
//        [tmpArray addObject: dto];
//    }
    ///
    floorDTO.moduleList = data;
    floorDTO.hight = SERVICE_CELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.floors =5;
    [self.floorsArray addObject:floorDTO];
}
@end
