//
//  DHBGoodsListRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBGoodsListRequest.h"

@implementation DHBGoodsListRequest


-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"goodsList";
}

-(id)value{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:
                                @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                                  @"step":[NSString stringWithFormat:@"%ld",(long)self.step],
                                  @"category_id":[NSString stringWithFormat:@"%ld",(long)self.category_id],
                                  @"goods_type": self.goods_type ? self.goods_type :@"",
                                  @"brand_id":[NSString stringWithFormat:@"%ld",(long)self.brand_id],
                                  @"min_price": self.min_price ? self.min_price : @"",
                                  @"max_price": self.max_price ? self.max_price : @"",
                                  @"ishome": self.ishome ? @"T" : @"F"
                                  }];
    if (self.search_content)
    {
        [dic setObject:self.search_content forKey:@"search_content"];
    }
    
    return dic;
}

@end
