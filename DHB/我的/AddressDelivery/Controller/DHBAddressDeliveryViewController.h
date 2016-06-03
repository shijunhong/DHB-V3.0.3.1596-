//
//  DHBAddressDeliveryViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "AddressListService.h"
#import "UserInformationModuleDTO.h"

typedef enum {
    SELECT,//选择
    LOOK //查看
}AddressType;

@class DHBAddressDeliveryViewController;
@protocol DHBAddressDeliveryViewControllerDelegate <NSObject>
@optional
- (void)addressDeliveryViewController:(DHBAddressDeliveryViewController *)controller address:(AddressModuleDTO*)address;
@end

@interface DHBAddressDeliveryViewController : DHBCommonViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)AddressListService *service;
@property(nonatomic,assign)AddressType type;
@property(nonatomic,weak)id<DHBAddressDeliveryViewControllerDelegate>delegate;
@end
