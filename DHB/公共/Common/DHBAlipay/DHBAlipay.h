//
//  DHBAlipay.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/10.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DHBAlipay : NSObject

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller_id;
@property(nonatomic, copy) NSString * out_trade_no;
@property(nonatomic, copy) NSString * subject;
@property(nonatomic, copy) NSString * body;
@property(nonatomic, copy) NSString * total_fee;
@property(nonatomic, copy) NSString * notify_url;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * payment_type;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

- (void)parseFromDict:(NSDictionary *)dict;
@end
