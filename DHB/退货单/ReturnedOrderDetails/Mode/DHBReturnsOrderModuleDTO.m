//
//  DHBReturnsOrderModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnsOrderModuleDTO.h"

@implementation DHBReturnsOrderModuleDTO
#pragma mark - init
- (DHBDeliveryMethodMoudleDTO *)deliveryMethodDTO{
    if(!_deliveryMethodDTO){
        _deliveryMethodDTO = [[DHBDeliveryMethodMoudleDTO alloc] init];
    }
    return _deliveryMethodDTO;
}

#pragma mark - 解析数据
- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    ///基本信息
    self.returns_id = [dict EncodeStringFromDicWithKey:@"returns_id"];
    self.returns_num =[dict EncodeStringFromDicWithKey:@"returns_num"];
    self.status =[dict EncodeStringFromDicWithKey:@"status"];
    self.discount_total =[dict EncodeStringFromDicWithKey:@"discount_total"];
    self.returns_total =[dict EncodeStringFromDicWithKey:@"returns_total"];
    self.returns_details_count = [dict EncodeStringFromDicWithKey:@"returns_details_count"];
    self.create_date = [dict EncodeStringFromDicWithKey:@"create_date"];
    self.returns_reason = [dict EncodeStringFromDicWithKey:@"returns_reason"];
    self.attachmentNumber = [dict EncodeStringFromDicWithKey:@"attcount"];
    
    ///收货人信息
    self.returns_consignee = [dict EncodeStringFromDicWithKey:@"returns_consignee"];
    self.returns_phone =[dict EncodeStringFromDicWithKey:@"returns_phone"];
    self.returns_address =[dict EncodeStringFromDicWithKey:@"returns_address"];
    ///配送方式
    [self.deliveryMethodDTO setSend_mode: [dict EncodeStringFromDicWithKey:@"returns_send_mode"]];
    [self.deliveryMethodDTO setSend_date: [dict EncodeStringFromDicWithKey:@"returns_send_date"]];
    [self.deliveryMethodDTO setSend_company: [dict EncodeStringFromDicWithKey:@"returns_send_company"]];
    [self.deliveryMethodDTO setSend_no: [dict EncodeStringFromDicWithKey:@"returns_send_no"]];
    //操作日志
    self.log_returns = [NSMutableArray array];
    NSMutableArray *logorders_arr = [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"log_returns"]];
    for (NSDictionary *dic in logorders_arr)
    {
        LogordersModuleDTO *logorder = [[LogordersModuleDTO alloc] init];
        [logorder parseFromReturnedOrderDict:dic];
        [self.log_returns addObject: logorder];
    }
}
@end
