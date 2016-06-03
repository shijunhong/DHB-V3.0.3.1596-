//
//  DHBAddressSubmitRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/30.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddressSubmitRequest.h"

@implementation DHBAddressSubmitRequest


-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"addressSubmit";
}

-(id)value{
    return @{@"delete_flag":self.delete_flag,
             @"address_id":@(self.address.address_id),
             @"consignee":self.address.consignee?self.address.consignee:@"",
             @"contact":self.address.contact?self.address.contact:@"",
             @"phone":self.address.phone?self.address.phone:@"",
             @"address":self.address.address?self.address.address:@"",
             @"address_detail":self.address.address_detail?self.address.address_detail:@"",
             @"city_id":self.address.city_id?self.address.city_id:@"",
             @"district_id":self.address.district_id?self.address.district_id:@"",
             @"longitude":@(self.address.longitude),
             @"latitude":@(self.address.latitude),
             @"is_default":self.address.is_default?self.address.is_default:@"F"};
}

@end
