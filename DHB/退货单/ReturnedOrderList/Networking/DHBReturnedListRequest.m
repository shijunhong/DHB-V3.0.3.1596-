//
//  DHBReturnedListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/4/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedListRequest.h"

@implementation DHBReturnedListRequest
- (NSInteger)step{
    return 20;
}

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"returnsList";
}

-(id)value{
    return @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"step":[NSString stringWithFormat:@"%ld",(long)self.step]};
}
@end
