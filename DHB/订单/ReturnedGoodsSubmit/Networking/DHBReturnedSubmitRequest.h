//
//  DHBReturnedSubmitRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBReturnedSubmitRequest : DHBBaseNetworkRequest

@property(nonatomic,strong)NSMutableArray *returnslist;
@property(nonatomic,strong)NSString *returns_reason;
@property(nonatomic,strong)NSString *orders_num;
@end
