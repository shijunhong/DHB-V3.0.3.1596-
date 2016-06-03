//
//  DHBReturnedGoodsRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedGoodsListRequest.h"

@implementation DHBReturnedGoodsListRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"returnsGoodsList";
}

-(id)value{
    return @{@"returns_id": self.returns_id};
}
@end
