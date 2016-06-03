//
//  DHBReturnedSubmitRequest.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBReturnedSubmitRequest.h"
#import "OrderModuleDTO.h"

@implementation DHBReturnedSubmitRequest

-(NSString *)controller{
    return @"DingHuo";
}

-(NSString *)action{
    return @"returnsGoodsSubmit";
}

-(id)value{
    NSMutableArray *arr =[NSMutableArray array];
    for (OrdersgoodsModuleDTO *goods in self.returnslist)
    {
        NSDictionary *dic = @{@"orders_list_id":[NSString stringWithFormat:@"%ld",(long)goods.orders_list_id],
                              @"orders_num":self.orders_num,
                              @"goods_id":[NSString stringWithFormat:@"%ld",(long)goods.goods_id],
                              @"options_id":goods.options_id,
                              @"returns_number":[NSString stringWithFormat:@"%@",goods.goods.number],
                              @"returns_price":goods.orders_price,
                              @"conversion_number":goods.goods.conversion_number};
        [arr addObject:dic];
    }
    NSString *returnslist  = [self toJSONData:arr];
//    NSLog_Red(@"cart = %@",returnslist);
    return @{@"returnslist":returnslist,
             @"returns_reason":self.returns_reason?self.returns_reason:@""};
}

-(BOOL)submitValidate{
    if ([self.returns_reason length] <= 0)
    {
        [self showMessage: L(@"请填写留言内容")];
        return NO;
    }
    if([self.returns_reason length] >0 && [self.returns_reason length] <= 4){
        [self showMessage: L(@"请输入4-300字符")];
        return NO;
    }
    return YES;
}

@end
