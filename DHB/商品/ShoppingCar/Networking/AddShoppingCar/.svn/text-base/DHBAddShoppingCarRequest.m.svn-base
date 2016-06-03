//
//  DHBAddShoppingCarRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/8.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddShoppingCarRequest.h"

@implementation DHBAddShoppingCarRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"cartSubmit";
}

-(id)value{
    
    NSString *cart  = [self toJSONData:@[@{@"price_id":[NSString stringWithFormat:@"%ld",(long)self.price_id],
                                         @"goods_id":[NSString stringWithFormat:@"%ld",(long)self.goods_id],
                                         @"options_id":self.options_id,
                                         @"number":self.number,
                                         @"units":self.units
                                         }]];
    return @{@"cart":cart};
}


-(BOOL)submitValidate{
    BOOL isValidate = YES;
    NSString *message = @"";
    if (!self.is_delete)
    {
        OptionModuleDTO *option = [self.goods getSelectOptions];
        if([self.goods.order_units isEqualToString:option.units])
        {
            if ([self.goods.min_order doubleValue]>[option.number doubleValue])
            {
                message = @"起订量不够";
                isValidate = NO;
            }
        }
        else
        {
            if ([option.units isEqualToString:@"base_units"]?
                [self.goods.min_order doubleValue]*[self.goods.conversion_number doubleValue]>[option.number doubleValue]:
                [self.goods.min_order doubleValue]>[option.number doubleValue]*[self.goods.conversion_number doubleValue])
            {
                message = @"起订量不够";
                isValidate = NO;
            }
        }
    }
    if(!isValidate){
        [self showMessage: message];
    }
    return isValidate;

}

@end
