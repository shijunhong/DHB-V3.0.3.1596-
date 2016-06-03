//
//  DHBSiftingRequest.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/3.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBaseNetworkRequest.h"

@interface DHBSiftingRequest : DHBBaseNetworkRequest
@property(nonatomic ,assign)NSInteger category_id;
@property(nonatomic ,strong)NSString *search_content;
@end
