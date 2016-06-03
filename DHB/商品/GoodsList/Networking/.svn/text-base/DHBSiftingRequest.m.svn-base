//
//  DHBSiftingRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSiftingRequest.h"

@implementation DHBSiftingRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"goodsScreening";
}

-(id)value{
    NSDictionary *dic;
    if (self.category_id ==0)
    {
        dic =@{@"search_content":[NSString stringWithFormat:@"%@",self.search_content?self.search_content:@""]};
    }
    else
    {
        dic =@{@"category_id":[NSString stringWithFormat:@"%ld",(long)self.category_id],
               @"search_content":[NSString stringWithFormat:@"%@",self.search_content?self.search_content:@""]};
    }
    
    return dic;
}


@end
