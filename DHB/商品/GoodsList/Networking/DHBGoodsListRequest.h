//
//  DHBGoodsListRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/19.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBGoodsListRequest : DHBBaseNetworkRequest
@property(nonatomic ,assign)NSInteger page;
@property(nonatomic ,assign)NSInteger step;
@property(nonatomic, assign)NSInteger category_id;
@property(nonatomic, strong)NSString *search_content;
@property(nonatomic, strong)NSString *goods_type;
@property(nonatomic, assign)NSInteger brand_id;
@property(nonatomic, assign)NSString *min_price;
@property(nonatomic, assign)NSString *max_price;
@property(nonatomic, assign)BOOL ishome;
@end
