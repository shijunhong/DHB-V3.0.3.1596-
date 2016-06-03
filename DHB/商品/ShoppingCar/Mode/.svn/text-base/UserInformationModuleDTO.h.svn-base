//
//  UserInformationModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    BK,//不开
    PT,//普通
    ZZ//增值
}InvoiceType;
@class VendersModuleDTO;
@class PurchasersModuleDTO;

@interface UserInformationModuleDTO : NSObject
@property(nonatomic,strong)PurchasersModuleDTO *purchasers;//订货商信息
@property(nonatomic,strong)VendersModuleDTO *venders;//供货商信息
@property(nonatomic,strong)NSString *total_price;//应付金额
@property(nonatomic,strong)NSString *delivery_date;//交货日期
@property(nonatomic,strong)NSString *distrib_mode;//配送方式
@property(nonatomic,strong)NSString *remark;//备注
- (void)parseFromDict:(NSDictionary *)dict;
@end


//地址
@interface AddressModuleDTO : NSObject
@property(nonatomic,assign)NSInteger address_id;//收货ID
@property(nonatomic,strong)NSString *consignee;//收货单位
@property(nonatomic,strong)NSString *contact;//联系人
@property(nonatomic,strong)NSString *phone;//电话
@property(nonatomic,strong)NSString *address;//地址
@property(nonatomic,strong)NSString *address_detail;//详细地址
@property(nonatomic,strong)NSString *city_id;//城市ID
@property(nonatomic,strong)NSString *district_id;//区ID
@property(nonatomic,assign)NSInteger longitude;//经度
@property(nonatomic,assign)NSInteger latitude;//纬度
@property(nonatomic,strong)NSString *is_default;//是否默认
@property(nonatomic,assign)BOOL is_select;//是否选中
- (void)parseFromDict:(NSDictionary *)dict;
@end

//供货商
@interface VendersModuleDTO : NSObject
@property(nonatomic,strong)NSString *pt_invoice;//是否可开普通发票
@property(nonatomic,strong)NSString *pt_taxing_point;//普通发票税点
@property(nonatomic,strong)NSString *zz_invoice;//是否可开增值税发票
@property(nonatomic,strong)NSString *zz_taxing_point;//增值税发票税点
@property(nonatomic,assign)InvoiceType invoice_type;//发票类型
- (void)parseFromDict:(NSDictionary *)dict;
@end

//订货商
@interface PurchasersModuleDTO : NSObject
@property(nonatomic,strong)NSString *invoice_title;//发票抬头
@property(nonatomic,strong)NSString *invoice_content;//发票内容
@property(nonatomic,strong)NSString *bank_account;//银行账号
@property(nonatomic,strong)NSString *bank;//开户银行
@property(nonatomic,strong)NSString *account_name;//开户名称
@property(nonatomic,strong)NSString *taxpayer_number;//纳税人识别号
@property(nonatomic,strong)AddressModuleDTO *address;//地址
- (void)parseFromDict:(NSDictionary *)dict;
@end
