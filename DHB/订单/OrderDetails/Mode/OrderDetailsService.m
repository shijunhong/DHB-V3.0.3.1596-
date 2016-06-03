//
//  OrderDetailsService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "OrderDetailsService.h"
#import "DHBOrderDetailsRequest.h"
#import "OrderModuleDTO.h"
#import "InvoiceModuleDTO.h"
#import "HomeFloorDTO.h"
#import "DHBCancelOrderRequest.h"
#import "DHBLeaveMsgOnOrderRequest.h"
#import "DHBFollowOrderRequest.h"
@implementation OrderDetailsService
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)queryOrderDetailData{
    NSMutableArray *temparr= [NSMutableArray array];
    [self.dataArray removeAllObjects];
    self.dataArray = temparr;
    
    DHBOrderDetailsRequest *request = [[DHBOrderDetailsRequest alloc] init];
    request.orders_id = self.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
//            NSLog_Blue(@"data = %@",[dic objectForKey:@"data"]);
            self.order = [[OrderModuleDTO alloc] init];
            [self.order parseFromDict:[dic objectForKey:@"data"]];
            [self insertFirstFloor];//添加第一层
            [self insertSecondFloor];//添加第二层
            [self insertThirdFloor];//添加第三层
            [self insertFourthFloor];//添加第四层
            [self insertFifthFloor];//第五层
            [self insertSixthFloor];//第六层
            [self insertSeventhFloor];//第七层
            [self insertEighthFloor];//第八层
            [self insertNinethFloor];//第九层
            [self insertTenthFloor];//第十层
            [self insertEleventhFloor];//第十一
            [self insertTwelfthFloor];//第十二
            [self insertthirteenthFloor];//第十三
//            [self insertfourteenFloor];//第十四
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
                    [_delegate orderDetailsServiceComplete:self isSuccess:YES];
                }
            });
//            if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
//                [_delegate orderDetailsServiceComplete:self isSuccess:YES];
//            }
        }
        else
        {
            NSLog_Red(@"error code=%d ",[[dic objectForKey:@"code"] intValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
                    [_delegate orderDetailsServiceComplete:self isSuccess:YES];
                }
            });
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate && [_delegate respondsToSelector:@selector(orderDetailsServiceComplete:isSuccess:)]) {
                [_delegate orderDetailsServiceComplete:self isSuccess:YES];
            }
        });
    }];
    
}


-(void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"订单状态";
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[self.order]];
    floorDTO.hight = 98;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"商品清单";
    NSString *type = [NSString stringWithFormat:@"%ld种",(long)self.order.goods_count];
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"spqd",@"type":type}]];
    floorDTO.hight = 51;
    floorDTO.templateID = @"9";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}



-(void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"订单金额";
    NSMutableArray *arr = [NSMutableArray array];
    //商品金额
    if (self.order.orders_total && [self.order.orders_total doubleValue] >0)
    {
        floorDTO.hight +=  30;
        [arr addObject:@{@"name":@"商品金额",@"value":self.order.orders_total}];
    }
    //税费
    if (self.order.invoice_price && [self.order.invoice_price doubleValue] >0)
    {
        floorDTO.hight +=  30;
        [arr addObject:@{@"name":@"税费",@"value":self.order.invoice_price}];
    }
    //运费freight
    if (self.order.freight && [self.order.freight doubleValue] >0)
    {
        floorDTO.hight +=  30;
        [arr addObject:@{@"name":@"运费",@"value":self.order.freight}];
    }
    //特价apply_total
    if (self.order.apply_total && [self.order.apply_total doubleValue] >0)
    {
        //特价
        floorDTO.hight +=  30;
        [arr addObject:@{@"name":@"特批价",@"value":self.order.apply_total}];
        
        //优惠
        floorDTO.hight +=  30;
        NSString *youhui = [NSString stringWithFormat:@"-%@",[NSString formatDecimal:[self.order.orders_total doubleValue]-[self.order.apply_total doubleValue] cnt:[[ParameterPublic sharedManagered] quantitative_accuracy]]];
        [arr addObject:@{@"name":@"优惠",@"value":youhui}];
    }
    if(!IsNilOrNull(self.order.discount_total)){
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"discount_total":self.order.discount_total,@"arr":arr}]];
    }
    floorDTO.hight += 43;
    floorDTO.templateID = @"4";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}


-(void)insertFourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"付款记录";
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[self.order]];
    if ([self.order.pay_status isEqualToString:@"已付款"])
    {
        floorDTO.hight = 53;
    }
    else
    {
        if ([self.order.status isEqualToString:@"已取消"])
        {
            floorDTO.hight = 53;
        }
        else
        {
            floorDTO.hight = 115;
        }
    }
    floorDTO.templateID = @"5";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertFifthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"出库/发货记录";
    NSString *type;
    if (self.order.shipscount>0)
    {
        type = [NSString stringWithFormat:@"%ld条",(long)self.order.shipscount];
        floorDTO.templateID = @"2";
    }
    else
    {
        type = @"无";
        floorDTO.templateID = @"7";
    }
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"ckfh",@"type":type}]];
    floorDTO.hight = 43;
    floorDTO.floors = 1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertSixthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"配送方式";
    NSString *type = [self.order.distrib_mode length] <= 0 ? @"无":self.order.distrib_mode;
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"psfs",@"type":type}]];
    floorDTO.hight = 43;
    floorDTO.templateID = @"7";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertSeventhFloor{
    if ([[ParameterPublic sharedManagered] delivery_date])//系统配置交货时间
    {
        HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
        floorDTO.floorName = @"交货日期";
        NSString *type = [NSString stringWithFormat:@"%@",self.order.delivery_date];
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"jhsj",@"type":type}]];
        floorDTO.hight = 43;
        floorDTO.templateID = @"7";
        floorDTO.floors =1;
        [self.dataArray addObject:floorDTO];
    }
}

-(void)insertEighthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"收货人信息";
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[self.order]];
    floorDTO.hight = 105;
    floorDTO.templateID = @"6";
    floorDTO.floors = 1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertNinethFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"备注";
    if ([self.order.remark isEqualToString:@""] || !self.order.remark)
    {
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"bz",@"type":@"无"}]];
        floorDTO.hight = 43;
        floorDTO.templateID = @"7";
    }
    else
    {
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"bz",@"remark":self.order.remark}]];
        floorDTO.hight = 96;
        floorDTO.templateID = @"3";
    }
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertTenthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"发票信息";
    InvoiceModuleDTO *invoice = self.order.invoice;
    NSString *type;
    if ([invoice.invoice_type isEqualToString:@"F"])
    {
        type = [NSString stringWithFormat:@"不需要发票"];
        floorDTO.templateID = @"7";
    }
    else if ([invoice.invoice_type isEqualToString:@"P"])
    {
        type = [NSString stringWithFormat:@"普通发票（%@%%税点）",self.order.invoice_tax];
        floorDTO.templateID = @"2";
    }
    else if ([invoice.invoice_type isEqualToString:@"Z"])
    {
        type = [NSString stringWithFormat:@"增值税发票（%@%%税点）",self.order.invoice_tax];
        floorDTO.templateID = @"2";
    }
    else
    {
        type = [NSString stringWithFormat:@"不需要发票"];
        floorDTO.templateID = @"7";
    }
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"fpxx",@"type":type}]];
    floorDTO.hight = 43;
    floorDTO.floors = 1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertEleventhFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"订单附件";
    NSString *type;
    if (self.order.attcount>0)
    {
        type = [NSString stringWithFormat:@"%ld个",(long)self.order.attcount];
        floorDTO.templateID = @"2";
    }
    else
    {
        type = @"无";
        floorDTO.templateID = @"7";
    }
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"ddfj",@"type":type}]];
    floorDTO.hight = 43;
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertTwelfthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"操作日志";
    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"image":@"ccrz",@"type":@""}]];
    floorDTO.hight = 43;
    floorDTO.templateID = @"2";
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

-(void)insertthirteenthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"按钮";
    if ([self.order.status isEqualToString:@"待审核"])
    {
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"order":self.order,@"butTitel":L(@"取消订单"),@"btnColor":@(kDHBButton_StyleValue2)}]];
    }
    else if ([self.order.status isEqualToString:@"已收货"] && self.order.can_return)
    {
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"order":self.order,@"butTitel":L(@"申请退货"),@"btnColor":@(kDHBButton_StyleValue2)}]];
    }
    else if (self.order.is_ship)
    {
        floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"order":self.order,@"butTitel":L(@"确认收货"),@"btnColor":@(kDHBButton_StyleValue2)}]];
    }
    floorDTO.templateID = @"8";
    floorDTO.hight = 74.0f+15.0f;
    floorDTO.floors =1;
    [self.dataArray addObject:floorDTO];
}

//-(void)insertfourteenFloor{
//    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
//    floorDTO.floorName = @"订单留言";
//    floorDTO.moduleList =[NSMutableArray arrayWithArray:@[@{@"order":self.order,@"butTitel":L(@"订单留言"),@"btnColor":@(kDHBButton_StyleValue4)}]];
//    floorDTO.templateID = @"8";
//    floorDTO.hight = 95;
//    floorDTO.floors = 1;
//    [self.dataArray addObject:floorDTO];
//}


/**
 *  取消订单
 *
 *  @param orders_id
 *  @param block
 */
-(void)cancelOrderRemark:(NSString *)msg callback:(void (^)(BOOL))block{
    DHBCancelOrderRequest *request = [[DHBCancelOrderRequest alloc] init];
    request.remark = msg;
    request.orders_id = self.order.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil userInfo:@{@"order":self.order}];
            block(YES);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        block(NO);
    }];
}

/**
 *  订单留言
 *
 *  @param orders_id
 *  @param msg
 *  @param block     
 */
-(void)LeaveMsgRemark:(NSString *)msg callback:(void (^)(BOOL))block{
    DHBLeaveMsgOnOrderRequest *request = [[DHBLeaveMsgOnOrderRequest alloc] init];
    request.remark = msg;
    request.orders_id = self.order.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        if ([[dic objectForKey:@"code"] intValue] ==100) block(YES);
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        block(NO);
    }];
}

/**
 *  收藏订单
 *
 *  @param block 
 */
-(void)FollowOrderCallback:(void (^)(BOOL, NSString *))block{
    DHBFollowOrderRequest *request = [[DHBFollowOrderRequest alloc] init];
    request.orders_id = self.order.orders_id;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        if ([[data objectForKey:@"code"] intValue] ==100)
        {
            BOOL is_success = [[[data objectForKey:@"data"] EncodeNumberFromDicWithKey:@"is_success"] integerValue]== 1 ?YES:NO;
            if (is_success)
                block(is_success,nil);
            else
                block(is_success,L(@"温馨提示/n/n收藏失败"));
        }
        else
        {
            block(NO,nil);
            NSLog_Red(@"error code=%d ",[[data objectForKey:@"code"] intValue]);
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        block(NO,nil);
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

@end
