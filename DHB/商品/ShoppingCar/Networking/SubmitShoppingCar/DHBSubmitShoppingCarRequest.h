//
//  DHBSubmitShoppingCarRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"
#import "GoodsModuleDTO.h"
@interface DHBSubmitShoppingCarRequest : DHBBaseNetworkRequest
@property(nonatomic,strong)NSMutableArray *goods_arr;
@end
