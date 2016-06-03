//
//  DHBBarcodeSearchRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/27.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBBarcodeSearchRequest.h"

@implementation DHBBarcodeSearchRequest
-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"barcodeSearch";
}

-(id)value{
    return @{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],
             @"step":[NSString stringWithFormat:@"%ld",(long)self.step],
             @"barcode":self.barcode
             };
}

@end
