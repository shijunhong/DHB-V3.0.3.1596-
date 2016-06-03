//
//  DHBCorporateFinancialService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/31/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#import "DHBCorporateFinancialService.h"
@implementation DHBCorporateFinancialService

#pragma mark - init
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [[NSMutableArray alloc] init];
    }
    return _floorsArray;
}

- (DHBCorporateFinancialModuleDTO *)corporateInfo{
    if(!_corporateInfo){
        _corporateInfo = [[DHBCorporateFinancialModuleDTO alloc] init];
    }
    return _corporateInfo;
}

#pragma mark - 获取公司财务信息数据
- (void)queryData{
    
    DHBCorporateFinancialRequest *request = [[DHBCorporateFinancialRequest alloc] init];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            [self.corporateInfo parseFromDic: [dic objectForKey:@"data"]];
        }
//        [self insertFirstFloor];
        [self insertSecondFloor];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(corporateFinancialService_Compelete:isSuccess:)]){
                [_delegate corporateFinancialService_Compelete: self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(corporateFinancialService_Compelete:isSuccess:)]){
                [_delegate corporateFinancialService_Compelete: self isSuccess: NO];
            }
        });
    }];
}

- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"";
//    floorDTO.moduleList =[NSMutableArray arrayWithObjects: [NSArray arrayWithObjects: @"公司名称",@"无执照请填写个人姓名", [self.corporateInfo client_name], nil], [NSArray arrayWithObjects: @"所在地区",@"请选择", @"", nil], [NSArray arrayWithObjects: @"详细地址", @"如街道、门牌号", @"", nil], [NSArray arrayWithObjects: @"公司传真", @"请输入公司传真", @"", nil], nil];
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"1";
    floorDTO.floors =4;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"开票信息";
    floorDTO.moduleList =[NSMutableArray arrayWithObjects: [NSMutableArray arrayWithObjects: @"开户名称",@"请输入开户名称", [self.corporateInfo account_name], nil],[NSMutableArray arrayWithObjects: @"开户银行",@"请输入开户银行", [self.corporateInfo bank], nil],[NSMutableArray arrayWithObjects: @"银行账号", @"请输入银行账号",[self.corporateInfo bank_account], nil],[NSMutableArray arrayWithObjects: @"纳税人识别号", @"请输入纳税人识别号",[self.corporateInfo taxpayer_number], nil],[NSMutableArray arrayWithObjects: @"发票抬头",@"请输入发票抬头", [self.corporateInfo invoice_title], nil], nil];
    floorDTO.hight = CELL_HEIGHT;
    floorDTO.templateID = @"2";
    floorDTO.orderNO = @"1";
    floorDTO.sectionHeight = 0.0f;
    floorDTO.floors =5;
    [self.floorsArray addObject:floorDTO];
}

#pragma mark -
#pragma mark 修改公司财务信息
- (void)submitCorporateFinancialData{
    
    WS(weakSelf);
    [[self floorsArray] enumerateObjectsUsingBlock:^(HomeFloorDTO *floor, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([floor.floorName isEqualToString:@"开票信息"])
        {
            for (NSMutableArray *data_arr in floor.moduleList)
            {
                if ([[data_arr firstObject] isEqualToString:@"开户名称"])
                    [weakSelf.corporateInfo setAccount_name:[data_arr lastObject]];
                else if ([[data_arr firstObject] isEqualToString:@"开户银行"])
                    [weakSelf.corporateInfo setBank:[data_arr lastObject]];
                else if ([[data_arr firstObject] isEqualToString:@"银行账号"])
                    [weakSelf.corporateInfo setBank_account:[data_arr lastObject]];
                else if ([[data_arr firstObject] isEqualToString:@"纳税人识别号"])
                    [weakSelf.corporateInfo setTaxpayer_number:[data_arr lastObject]];
                else if ([[data_arr firstObject] isEqualToString:@"发票抬头"])
                    [weakSelf.corporateInfo setInvoice_title:[data_arr lastObject]];
            }
        }
    }];
    
    
    DHBModifyCorporateFinRequest *request = [[DHBModifyCorporateFinRequest alloc] init];
    [request setCorporateInfo: self.corporateInfo];
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] == 100 ? YES :NO);
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(corporateFinancialService_DidSubitCompelete:isSuccess:)]){
                [_delegate corporateFinancialService_DidSubitCompelete: self isSuccess: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([_delegate respondsToSelector: @selector(corporateFinancialService_DidSubitCompelete:isSuccess:)]){
                [_delegate corporateFinancialService_DidSubitCompelete: self isSuccess: NO];
            }
        });
    }];
}
@end
