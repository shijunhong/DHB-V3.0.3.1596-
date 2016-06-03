//
//  ProductModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/27.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#import "GoodsModuleDTO.h"
#import "OptionModuleDTO.h"
#import "GoodsFieldModuleDTO.h"
@implementation GoodsModuleDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
//    NSLog_Red(@"%@",dict);
    self.goods_id =[[dict EncodeNumberFromDicWithKey:@"goods_id"] integerValue];
    self.multi_id =[dict EncodeStringFromDicWithKey:@"multi_id"];
    self.goods_type =[dict EncodeStringFromDicWithKey:@"goods_type"];
    self.goods_num =[dict EncodeStringFromDicWithKey:@"goods_num"];
    self.goods_name =[dict EncodeStringFromDicWithKey:@"goods_name"];
    self.goods_model =[dict EncodeStringFromDicWithKey:@"goods_model"];
    self.goods_picture =[dict EncodeStringFromDicWithKey:@"goods_picture"];
    self.whole_price =[dict EncodeStringFromDicWithKey:@"whole_price"];
    self.base_units =[dict EncodeStringFromDicWithKey:@"base_units"];
    self.container_units = [dict EncodeStringFromDicWithKey:@"container_units"];
    self.conversion_number =[dict EncodeStringFromDicWithKey:@"conversion_number"];
    self.order_units = [dict EncodeStringFromDicWithKey:@"order_units"];
    self.min_order = [dict EncodeStringFromDicWithKey:@"min_order"];
    self.options = [dict EncodeStringFromDicWithKey:@"options"];
    self.price_count =[[dict EncodeNumberFromDicWithKey:@"price_count"] integerValue];
    self.content = [dict EncodeStringFromDicWithKey:@"content"];
    self.is_follow = [[dict EncodeStringFromDicWithKey:@"is_follow"] isEqualToString:@"T"]?YES:NO;
    self.resource =[dict EncodeArrayFromDicWithKey:@"resource"];
//    self.price_id = [[dict EncodeNumberFromDicWithKey:@"price_id"] integerValue];
    self.in_cart = [[dict EncodeStringFromDicWithKey:@"in_cart"] isEqualToString:@"T"]?YES:NO;
    self.is_out_of_stock = [[dict EncodeNumberFromDicWithKey:@"is_out_of_stock"] boolValue];
    
    self.options_data = [NSMutableArray array];
    NSArray *arr = [dict EncodeArrayFromDicWithKey:@"options_data"];
    for (NSDictionary *innerDic in arr)
    {
        OptionModuleDTO *option = [[OptionModuleDTO alloc] init];
        [option parseFromDict:innerDic];
        [self.options_data addObject:option];
    }
    
    NSArray *multis= [dict EncodeArrayFromDicWithKey:@"multi_data"];
    [self checkDefaultOption];
    self.multi_data = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in multis)
    {
        MultiModuleDTO *multi = [[MultiModuleDTO alloc] init];
        multi.defaultMultiId = self.defaultOption.options_id;
        [multi parseFromDict:dic];
        [self.multi_data addObject:multi];
    }
    
    self.field_data = [NSMutableArray array];
    NSArray *fields = [dict EncodeArrayFromDicWithKey:@"field_data"];
    for (NSDictionary *innerDic in fields)
    {
        GoodsFieldModuleDTO *field = [[GoodsFieldModuleDTO alloc] init];
        [field parseFromDict:innerDic];
        [self.field_data addObject:field];
    }
    
    self.relation_data = [NSMutableArray array];
    NSArray *relation = [dict EncodeArrayFromDicWithKey:@"relation_data"];
    for (NSDictionary *innerDic in relation)
    {
        GoodsModuleDTO *goods = [[GoodsModuleDTO alloc] init];
        [goods parseFromDict:innerDic];
        [self.relation_data addObject:goods];
    }
    
    //设置默认置灰
    OptionModuleDTO *option = [self getSelectOptions];
    NSString *multiId = [[option.options_id componentsSeparatedByString:@","] safeObjectAtIndex:0];
    [self updateMultiDisEnableWithMultiId:multiId];
}


//购物车接口解析
- (void)parseFromDict_shoppingCar:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.goods_id =[[dict EncodeNumberFromDicWithKey:@"goods_id"] integerValue];
    self.multi_id =[dict EncodeStringFromDicWithKey:@"multi_id"];
    self.goods_type =[dict EncodeStringFromDicWithKey:@"goods_type"];
    self.goods_num =[dict EncodeStringFromDicWithKey:@"goods_num"] ;
    self.goods_name =[dict EncodeStringFromDicWithKey:@"goods_name"];
    self.goods_model =[dict EncodeStringFromDicWithKey:@"goods_model"];
    self.goods_picture =[dict EncodeStringFromDicWithKey:@"goods_picture"];
    self.whole_price =[dict EncodeStringFromDicWithKey:@"whole_price"];
    self.base_units =[dict EncodeStringFromDicWithKey:@"base_units"];
    self.container_units = [dict EncodeStringFromDicWithKey:@"container_units"];
    self.conversion_number =[dict EncodeStringFromDicWithKey:@"conversion_number"];
    self.min_order =[dict EncodeStringFromDicWithKey:@"min_order"];
    self.options = [dict EncodeStringFromDicWithKey:@"options"];
    self.number = [dict EncodeStringFromDicWithKey:@"number"];
    self.price_id = [[dict EncodeNumberFromDicWithKey:@"price_id"] integerValue];
    self.available_number = [dict EncodeStringFromDicWithKey:@"available_number"];
    self.inventory_number = [dict EncodeStringFromDicWithKey:@"inventory_number"];
    self.min_number = [dict EncodeStringFromDicWithKey:@"min_number"];
    self.units = [dict EncodeStringFromDicWithKey:@"units"];
    self.is_out_of_stock = [[dict EncodeNumberFromDicWithKey:@"is_out_of_stock"] boolValue];
    
    OptionModuleDTO *option = [[OptionModuleDTO alloc] init];
    option.price_id = self.price_id;
    option.whole_price = self.whole_price;
    option.selling_price = [dict EncodeStringFromDicWithKey:@"selling_price"];
    option.number_price = [dict EncodeArrayFromDicWithKey:@"number_price"];
    option.units = [dict EncodeStringFromDicWithKey:@"units"];
    option.number = [dict EncodeStringFromDicWithKey:@"number"];
    option.options_id = [dict EncodeStringFromDicWithKey:@"options_id"];
    self.options_data = [NSMutableArray arrayWithObjects:option, nil];
    
//    NSArray *multis= [dict EncodeArrayFromDicWithKey:@"multi_data"];
//    self.multi_data = [[NSMutableArray alloc] init];
//    for (NSDictionary *dic in multis)
//    {
//        MultiModuleDTO *multi = [[MultiModuleDTO alloc] init];
//        multi.defaultMultiId = [dict EncodeStringFromDicWithKey:@"options_id"];
//        [multi parseFromDict_shoppingCar:dic];
//        [self.multi_data addObject:multi];
//    }

    self.multi_data = [NSMutableArray arrayWithArray:[dict EncodeArrayFromDicWithKey:@"multi_data"]];
//    self.multi_data = [NSMutableArray array];
}

//商品列表获取数据
- (void)parseFromDict_goodsList:(NSDictionary *)dict{
    if (IsNilOrNull(dict)) {
        return;
    }
    self.goods_id =[[dict EncodeNumberFromDicWithKey:@"goods_id"] integerValue];
    self.multi_id =[dict EncodeStringFromDicWithKey:@"multi_id"];
    self.goods_type =[dict EncodeStringFromDicWithKey:@"goods_type"];
    self.goods_num =[dict EncodeStringFromDicWithKey:@"goods_num"];
    self.goods_name =[dict EncodeStringFromDicWithKey:@"goods_name"];
    self.goods_model =[dict EncodeStringFromDicWithKey:@"goods_model"];
    self.goods_picture =[dict EncodeStringFromDicWithKey:@"goods_picture"];
    self.whole_price =[dict EncodeStringFromDicWithKey:@"whole_price"];
    self.selling_price = [dict EncodeStringFromDicWithKey:@"selling_price"];
    self.base_units =[dict EncodeStringFromDicWithKey:@"base_units"];
    self.container_units = [dict EncodeStringFromDicWithKey:@"container_units"];
    self.conversion_number =[dict EncodeStringFromDicWithKey:@"conversion_number"];
    self.order_units = [dict EncodeStringFromDicWithKey:@"order_units"];
    self.min_order = [dict EncodeStringFromDicWithKey:@"min_order"];
    self.options = [dict EncodeStringFromDicWithKey:@"options"];
    self.price_count =[[dict EncodeNumberFromDicWithKey:@"price_count"] integerValue];
    self.in_cart = [[dict EncodeStringFromDicWithKey:@"in_cart"] isEqualToString:@"T"]?YES:NO;
    self.is_out_of_stock = [[dict EncodeNumberFromDicWithKey:@"is_out_of_stock"] boolValue];
    
    if (![[ParameterPublic sharedManagered] goods_multi])
    {
        //不启用多规格
        OptionModuleDTO *option = [[OptionModuleDTO alloc] init];
        option.price_id = [[dict EncodeNumberFromDicWithKey:@"price_id"] integerValue];
        option.selling_price = [dict EncodeStringFromDicWithKey:@"selling_price"];
        option.whole_price = [dict EncodeStringFromDicWithKey:@"whole_price"];
        option.number = [dict EncodeStringFromDicWithKey:@"number"];
        option.units = [dict EncodeStringFromDicWithKey:@"units"];
        self.options_data = [NSMutableArray arrayWithObjects:option, nil];
        self.multi_data  = [NSMutableArray array];
    }
    
}


/**
 *  检查默认Option规格
 */
-(void)checkDefaultOption{
    if (!self.defaultOption)
    {
        //没有设置默认值取 第一个为默认Option
        self.defaultOption =[self.options_data safeObjectAtIndex:0];
    }
    else
    {
        //检查默认option 是否存在正确
        BOOL falg = NO;
        for (OptionModuleDTO * option in self.options_data)
        {
            if(option.price_id == self.defaultOption.price_id)
            {
                falg = YES;
                self.defaultOption = option;
            }
        }
        if (!falg)
        {
            //默认option不正确 取第一个为默认Option
            self.defaultOption =[self.options_data safeObjectAtIndex:0];
        }
    }
}


- (OptionModuleDTO*)getSelectOptions{
    if ([self.multi_data count] > 0 && [[ParameterPublic sharedManagered] goods_multi] && [[self.multi_data firstObject] isKindOfClass: [MultiModuleDTO class]])
    {
            NSArray *multi_arr = [self.multi_data sortedArrayUsingComparator:^NSComparisonResult(MultiModuleDTO *obj1, MultiModuleDTO *obj2) {
                if ([obj1.multiId integerValue] > [obj2.multiId integerValue])
                {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1.multiId integerValue] < [obj2.multiId integerValue])
                {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            NSMutableString *options_id = [[NSMutableString alloc] init];
            for (int i = 0;i<[multi_arr count];i++)
            {
                MultiModuleDTO *multi = [multi_arr safeObjectAtIndex:i];
                if (i==0)
                {
                    [options_id appendString:[NSString stringWithFormat:@"%@",multi.defaultMultiId]];
                }
                else
                {
                    [options_id appendString:[NSString stringWithFormat:@",%@",multi.defaultMultiId]];
                }
            }
            for (OptionModuleDTO *option in self.options_data)
            {
                if ([option.options_id isEqualToString:options_id])
                {
                    self.price_id = option.price_id;
                    return option;
                }
            }
            return nil;
    }
    else
    {
        OptionModuleDTO *option =  [self.options_data safeObjectAtIndex:0];
        return option;
    }
}

-(NSString*)getSelectAvailable{
    __block NSString *available;
    OptionModuleDTO *select_option = [self getSelectOptions];
    [self.options_data enumerateObjectsUsingBlock:^(OptionModuleDTO *option, NSUInteger idx, BOOL * _Nonnull stop) {
        if (select_option.price_id == option.price_id)
        {
             available = option.available_number;
        }
    }];
    return available||(![available isEqualToString:@""])?available:@"无";
}

-(NSString *)getnumberPrice:(NSString *)number price_id:(NSUInteger)price_id{
    NSString *price;
    BOOL select = YES;
    for (int i = 0; i<[self.options_data count]&&select;i++)
    {
        OptionModuleDTO* option = [self.options_data safeObjectAtIndex:i];
        if (option.price_id == price_id)
        {
            if ([option.number_price count]>0)
            {
                for (int j = 0; j<[option.number_price count]&&select; j++)
                {
                    NSDictionary *dic = [option.number_price safeObjectAtIndex:j];
                    double start = [[dic EncodeNumberFromDicWithKey:@"start"] integerValue];
                    double end = [[dic EncodeStringFromDicWithKey:@"end"] integerValue] == 0?NSIntegerMax:[[dic EncodeStringFromDicWithKey:@"end"] integerValue];
                    if (start <= [number integerValue] &&[number integerValue] <= end)
                    {
                        price = [dic EncodeStringFromDicWithKey:@"price"];
                        select = NO;
                    }
                    TT_RELEASE_SAFELY(dic);
                }
            }
            else//没有阶梯价 取订货价
            {
                price = option.whole_price;
                select = NO;
            }
        }
        TT_RELEASE_SAFELY(option);
    }
    return price;
}

-(BOOL)CheckIsMoreUnit{
    //如果起订单位是大单位 :不能切换单位
    if ([self.order_units isEqualToString:@"container_units"])
    {
        return NO;
    }
    else
    {
        //如果起订单位是小单位 ,大单位为空:不能切换单位
        if (!self.container_units || [self.container_units isEqualToString:@""])
        {
            return NO;
        }
        else
        {
            //如果起订单位是小单位 ,大单有值:可以切换单位
            return YES;
        }
    }
}

/**
 *  根据MultiChild ID 获取 Multi
 *
 *  @param MultiChildModuleDTO.multi_id
 *
 *  @return MultiModuleDTO
 */
-(MultiModuleDTO *)getMultiWithChildMultiId:(NSString*)multi_id{
    for (MultiModuleDTO *multi in self.multi_data)
    {
        for (MultiChildModuleDTO *multiChild in multi.options)
        {
            if ([multiChild.multiId isEqualToString:multi_id])
            {
                return multi;
            }
        }
    }
    return nil;
}

/**
 *  根据MultiChild ID 获取 MultiChild
 *
 *  @param MultiChildModuleDTO.multi_id
 *
 *  @return MultiModuleDTO
 */
-(MultiChildModuleDTO *)getMultiChildWithChildMultiId:(NSString*)multi_id{
    for (MultiModuleDTO *multi in self.multi_data)
    {
        for (MultiChildModuleDTO *multiChild in multi.options)
        {
            if ([multiChild.multiId isEqualToString:multi_id])
            {
                return multiChild;
            }
        }
    }
    return nil;
}

/**
 *  判断是否选中 MultiChildModuleDTO
 *
 *  @param multi_id
 *
 *  @return
 */
-(BOOL)getReverMutiWithChildMultiId:(NSString*)multi_id{
    MultiChildModuleDTO *multiChild =  [self getMultiChildWithChildMultiId:multi_id];
    if (multiChild.is_seleted)
    {
        return YES;
    }
    return NO;
}

/**
 *  根据MultiChildModuleDTO.multi_id, 获取能选择得MultiChildModuleDTO ID
 *
 *  @param
 *
 *  @return
 */
-(NSMutableArray *)getMultiIdWithMultiId:(NSString*)multi_id{
    NSMutableArray *multiId_arr = [NSMutableArray array];
    for (OptionModuleDTO *option in self.options_data)
    {
        NSArray *arr= [option.options_id componentsSeparatedByString:@","];
        for (int i  = 0; i<[arr count]; i++)
        {
            NSString *str = [arr safeObjectAtIndex:i];
            if ([str isEqualToString:multi_id])
            {
                NSString *multiId;
                if (i==0)
                {
                    multiId = [arr safeObjectAtIndex:1];
                }
                else
                {
                    multiId = [arr safeObjectAtIndex:0];
                }
                if (multiId)
                {
                    [multiId_arr addObject:multiId];
                }
            }
        }
    }
    return multiId_arr;
}

/**
 *  根据MultiChildModuleDTO.multi_id 修改Multi 得置灰状态
 *
 *  @param multi_id 
 */
-(void)updateMultiDisEnableWithMultiId:(NSString*)multi_id{
    MultiModuleDTO *multi_1 ;
    for (MultiModuleDTO *multi in self.multi_data)
    {
        if (![multi.multiId isEqualToString:[self getMultiWithChildMultiId:multi_id].multiId])
        {
            multi_1 = multi;
            for (MultiChildModuleDTO *multi_c in multi.options)
            {
                multi_c.is_disEnable = YES;
            }
        }
    }
    
    for (NSString *str in [self getMultiIdWithMultiId:multi_id])
    {
        for (MultiChildModuleDTO *multi_c in multi_1.options)
        {
            if ([str isEqualToString:multi_c.multiId])
            {
                multi_c.is_disEnable = NO;
            }
        }
    }
}

/**
 *  根据MultiChildModuleDTO.multi_id 修改Multi 得选中状态
 *
 *  @param multi_id
 */
-(void)updateMultiSelectWithMultiId:(NSString*)multi_id{
    for (MultiModuleDTO *multi in self.multi_data)
    {
        for (MultiChildModuleDTO *childMulti in multi.options)
        {
            if ([childMulti.multiId isEqualToString:multi_id])
            {
                [multi MultiChildSelect:childMulti];
            }
        }
    }
}

#pragma mark - 在指定的父视图中显示goods_type的子视图, 不需要阴影视图shadowView为nil
- (void)showGoodsTypeViewInParentView:(UIView *)parentView shadowView:(UIImageView *)shadowView{
    NSArray *goodsTypeArray = [[self goods_type] componentsSeparatedByString: @","];
    
    ///移除之前父视图中所有的子视图
    [[parentView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    ///添加新的子视图到父视图中
    NSInteger flag = 0;
    for(NSInteger i = [goodsTypeArray count] - 1; i >= 0; i--){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(i * (GOODSTYPE_WIDTH - 3.0f), 0.0f, GOODSTYPE_WIDTH, GOODSTYPE_HEIGHT)];
        switch ([[goodsTypeArray objectAtIndex: i] integerValue]) {
            case 1:
                [imageView setImage: [UIImage imageNamed: @"goodsnew"]];
                if(flag == [goodsTypeArray count] - 1 && shadowView){
                    [shadowView setImage: [UIImage imageNamed: @"goodsnew2"]];
                }
                flag++;
                break;
            case 2:
                [imageView setImage: [UIImage imageNamed: @"recommend"]];
                if(flag == [goodsTypeArray count] - 1 && shadowView){
                    [shadowView setImage: [UIImage imageNamed: @"recommend2"]];
                }
                flag++;
                break;
            case 3:
                [imageView setImage: [UIImage imageNamed: @"selling"]];
                if(flag == [goodsTypeArray count] - 1 && shadowView){
                    [shadowView setImage: [UIImage imageNamed: @"selling2"]];
                }
                flag++;
                break;
            default:
                break;
        }
        [parentView addSubview: imageView];
    }
    [shadowView setHidden: NO];
    if(flag == 0 && shadowView){
        [shadowView setHidden: YES];
    }
    [parentView setFrame: CGRectMake(parentView.left, parentView.top, (flag * GOODSTYPE_WIDTH), GOODSTYPE_HEIGHT)];
}
@end
