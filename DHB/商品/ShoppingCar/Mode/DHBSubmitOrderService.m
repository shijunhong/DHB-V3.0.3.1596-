//
//  DHBSubmitOrderService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/30/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BASECELL_HEIGHT 45.0f
#define ADDRESS_HEIGHT 100.0F
#define REMARKS_HEIGHT 80.0f
#define DATEPICKER_HEIGHT 150.0f
#import "DHBSubmitOrderService.h"

@implementation DHBSubmitOrderService
#pragma mark - getters and setters
- (NSMutableArray *)floorArray{
    if(!_floorArray){
        _floorArray = [NSMutableArray array];
    }
    return _floorArray;
}

#pragma mark - service
/**
 *  构建提交订单填写的数据层
 */
- (void)createFloor{
    [self.floorArray removeAllObjects];
    NSArray *dataArray = @[@"商品金额", @"发票类型",@"配送方式", @"交货日期",@"收货信息",@"备注",@"时间筛选器"];
    for(NSInteger i = 0; i < [dataArray count]; i++){
        [self addFloor: [dataArray objectAtIndex: i] index: i + 1];
    }
    if([_delegate respondsToSelector: @selector(DHBSubmitOrderService_Complete:isSuceess:)]){
        [_delegate DHBSubmitOrderService_Complete: self isSuceess: YES];
    }
}

/**
 *  提交订单
 */
- (void)submitOrder{
    //提交订单
    DHBOrderSubmitRequest *request =[[DHBOrderSubmitRequest alloc] init];
    request.userInformation = self.userInfoDTO;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        if ([[data objectForKey:@"code"] intValue] ==100)
        {
            NSDictionary *dic = [data objectForKey:@"data"];
            if([_delegate respondsToSelector: @selector(DHBSubmitOrderService_SubmitOrder:isSuceess:)]){
                [_delegate DHBSubmitOrderService_SubmitOrder: dic isSuceess: YES];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
    }];
}

#pragma mark - privete method
/**
 *  创建数据层
 *
 *  @param name  数据层的名称
 *  @param index 数据层的编号
 */
- (void)addFloor:(NSString *) name index:(NSInteger) index{
    BOOL isAdd = YES;
    HomeFloorDTO *floor = [[HomeFloorDTO alloc] init];
    floor.templateID = [NSString stringWithFormat: @"%ld", (long)index];
    floor.floorName = name;
    floor.hight = BASECELL_HEIGHT;
    floor.sectionHeight = DEFAULT_SECTION_HEIGHT;
    if([name isEqualToString: @"发票类型"]){
        if (![[ParameterPublic sharedManagered] plain_invoice] && ![[ParameterPublic sharedManagered] added_tax_invoice])//系统配置是否可开发票
        {
            isAdd = NO;
        }
    }
    else if([name isEqualToString: @"交货日期"]){
        if (![[ParameterPublic sharedManagered] delivery_date])//系统配置是否启用交货时间
        {
            isAdd = NO;
        }
    }
    else if([name isEqualToString: @"备注"]){
        floor.hight = REMARKS_HEIGHT;
    }
    else if([name isEqualToString: @"时间筛选器"]){
        floor.hight = 0.0f;
    }
    if(self.userInfoDTO){
        floor.moduleList = [NSMutableArray arrayWithObject: self.userInfoDTO];
    }
    if(isAdd){
        [self.floorArray addObject: floor];
    }
}
@end
