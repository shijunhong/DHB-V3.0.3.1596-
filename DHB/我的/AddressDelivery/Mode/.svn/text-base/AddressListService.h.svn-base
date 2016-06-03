//
//  AddressListService.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AddressListService;
@protocol AddressListServiceDelegate <NSObject>
@optional
- (void)addressListServiceComplete:(AddressListService *)service isSuccess:(BOOL )isSuccess;
@end

@interface AddressListService : NSObject

@property (nonatomic, assign) id<AddressListServiceDelegate> delegate;
//订单列表数据
@property (nonatomic, strong)NSMutableArray *dataArray;
//错误信息
@property(nonatomic, strong)NSError *error;
@property(nonatomic,strong)NSString *orders_id;

-(void)queryAddressListlData;

@end
