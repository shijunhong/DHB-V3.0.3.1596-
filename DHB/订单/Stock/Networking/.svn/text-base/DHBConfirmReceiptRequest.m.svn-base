//
//  DHBConfirmReceiptRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/26.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBConfirmReceiptRequest.h"

@implementation DHBConfirmReceiptRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"confirmReceipt";
}

-(id)value{
    return @{@"ships_id":[NSString stringWithFormat:@"%ld",(long)self.ships_id],
             @"orders_id":[NSString stringWithFormat:@"%ld",(long)self.orders_id]};
}

@end
