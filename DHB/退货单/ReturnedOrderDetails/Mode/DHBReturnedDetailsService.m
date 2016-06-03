//
//  DHBReturnedDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define BASE_CELL_HEIGHT 50.0f
#define CELL_HEIGHT_STYLE2 100.0f
#define ORDERSTATUS_CELL_HEIGHT 80.0f
#import "DHBReturnedDetailsService.h"

@implementation DHBReturnedDetailsService

#pragma mark - init
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

- (NSMutableArray *)statusFloorsArray{
    if(!_statusFloorsArray){
        _statusFloorsArray = [NSMutableArray array];
    }
    return _statusFloorsArray;
}

#pragma mark - 查询数据
-(void)queryOrderDetailsData{
    DHBReturnsDetailsRequest *request = [[DHBReturnsDetailsRequest alloc] init];
    request.returns_id = self.returns_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        [self.floorsArray removeAllObjects];
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            self.returnedOrderDTO = [[DHBReturnsOrderModuleDTO alloc] init];
            [self.returnedOrderDTO parseFromDict:[dic objectForKey:@"data"]];
            [self insertFirstFloor];//退单编号
            [self insertSecondFloor];//退单清单
            [self insertThirdFloor];//退单金额
            ///退货方式
            if([[self.returnedOrderDTO status] isEqualToString: @"待收货"]|| [[self.returnedOrderDTO status] isEqualToString: @"待退款"]|| [[self.returnedOrderDTO status] isEqualToString: @"已完成"]){
                ///这些状态下才显示收货人信息
                [self insertEighthFloor];
            }
            ///收货人信息
            if([[self.returnedOrderDTO status] isEqualToString: @"待发货"] || [[self.returnedOrderDTO status] isEqualToString: @"待收货"]|| [[self.returnedOrderDTO status] isEqualToString: @"待退款"]|| [[self.returnedOrderDTO status] isEqualToString: @"已完成"]){
                    ///这些状态下才显示收货人信息
                    [self insertSeventhFloor];
            }
            ///备注视图
            if([self.returnedOrderDTO.returns_reason length] > 0){
                [self insertFourthFloor:CELL_HEIGHT_STYLE2];
            }
            else{
                [self insertFourthFloor: BASE_CELL_HEIGHT];
            }
            [self insertFifthFloor];//附件
            [self insertSixthFloor];//操作日志
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(returnedDetailsService_Complete:isSuccess:)]) {
                [_delegate returnedDetailsService_Complete:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(returnedDetailsService_Complete:isSuccess:)]) {
                [_delegate returnedDetailsService_Complete:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark -
- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退单状态";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = CELL_HEIGHT_STYLE2;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退单清单";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASE_CELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退货金额";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASE_CELL_HEIGHT * 3.0f / 2.0f;
    floorDTO.templateID = @"3";
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFourthFloor:(CGFloat) height{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"备注";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = height;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFifthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退货附件";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASE_CELL_HEIGHT;
    floorDTO.templateID = @"5";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSixthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"操作日志";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = BASE_CELL_HEIGHT;
    floorDTO.templateID = @"6";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSeventhFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"收货人信息";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = CELL_HEIGHT_STYLE2;
    floorDTO.templateID = @"7";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertEighthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"退货方式";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.returnedOrderDTO];
    floorDTO.hight = CELL_HEIGHT_STYLE2;
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.templateID = @"8";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

#pragma mark -
#pragma mark 查询订单状态
- (void)queryOrderStateData{
    
    self.first = NO;
    DHBReturnedOrderStatusRequest *request = [[DHBReturnedOrderStatusRequest alloc] init];
    request.returns_id = self.returns_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            NSArray *returns_flow = [[dic EncodeDicFromDicWithKey:@"data"] EncodeArrayFromDicWithKey:@"returns_flow"];
            NSArray *arr = [[returns_flow reverseObjectEnumerator] allObjects];
            BOOL first = NO;
            for (int i = 0 ;i<[arr count];i++)
            {
                NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithDictionary:[arr safeObjectAtIndex:i]];
                if (![[dto EncodeStringFromDicWithKey:@"create_date"] isEqualToString:@""] && !first)
                {
                    [dto setObject:@"1" forKey:@"is_red"];
                    first = YES;
                }
                else
                {
                    [dto setObject:@"0" forKey:@"is_red"];
                }
                [self.statusFloorsArray addObject:dto];
            }
            NSLog_Red(@"%@",self.statusFloorsArray);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(returnedDetailsService_OrderStatusRequestFinish:isSuccess:)]) {
                [_delegate returnedDetailsService_OrderStatusRequestFinish:self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(returnedDetailsService_OrderStatusRequestFinish:isSuccess:)]) {
                [_delegate returnedDetailsService_OrderStatusRequestFinish:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 取消退货
- (void)cancelReturnsOrder{
    DHBCancelReturnsOrderRequest *request = [[DHBCancelReturnsOrderRequest alloc] init];
    request.returns_id = self.returns_id;
    request.reason = self.cancel_reason;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        self.message = [dic objectForKey: @"message"];
        if(isSuccess){
            isSuccess = ([[[dic objectForKey: @"data"] objectForKey: @"is_success"] integerValue] == 0 ? NO : YES);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"returnOrderUpdate" object:nil userInfo:@{@"returns_id":self.returnedOrderDTO.returns_id}];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(returnedDetailsService_CancelComplete:isSuccess:)]) {
                [_delegate returnedDetailsService_CancelComplete:self isSuccess:isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(returnedDetailsService_CancelComplete:isSuccess:)]) {
                [_delegate returnedDetailsService_CancelComplete:self isSuccess:NO];
            }
        });
    }];
}

#pragma mark - 提交留言接口
- (void)submitLeaveMessage{
    DHBReturnsOrderMessageRequest *request = [[DHBReturnsOrderMessageRequest alloc] init];
    request.returns_id = self.returns_id;
    request.remark = self.leaveMessage;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            isSuccess = ([[dic objectForKey:@"data"] objectForKey:@"track_id"] ? YES : NO);
        }
        if(!isSuccess){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *tipView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"提交失败" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
                [tipView show];
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *tipView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"提交失败" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [tipView show];
        });
    }];
}

//#pragma mark - 查询退货附件
//- (void)queryReturnsAttachmentData{
//    if(self.returns_id){
//        DHBReturnsAttachmentRequest *request = [[DHBReturnsAttachmentRequest alloc] init];
//        request.returns_id = self.returns_id;
//        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
//            [GiFHUD dismiss];
//            NSDictionary *dic = (NSDictionary*)data;
//            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
//            if(isSuccess)
//            {
//                [self.returnedOrderDTO setAttachmentNumber: [NSString stringWithFormat: @"%ld",(long)[[[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"list"] count]]];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if ([_delegate respondsToSelector:@selector(returnedDetailsService_ReturnsAttachmentComplete:isSuccess:)]) {
//                    [_delegate returnedDetailsService_ReturnsAttachmentComplete:self isSuccess:YES];
//                }
//            });
//        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
//            [GiFHUD dismiss];
//            NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
//            self.error = error;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if ([_delegate respondsToSelector:@selector(returnedDetailsService_ReturnsAttachmentComplete:isSuccess:)]) {
//                    [_delegate returnedDetailsService_ReturnsAttachmentComplete:self isSuccess:NO];
//                }
//            });
//        }];
//    }
//}
@end
