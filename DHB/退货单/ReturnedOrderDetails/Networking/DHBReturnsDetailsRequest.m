//
//  DHBReturnsDetailsRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/5/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnsDetailsRequest.h"

@implementation DHBReturnsDetailsRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"returnsContent";
}

-(id)value{
    return @{@"returns_id": self.returns_id};
}
@end
