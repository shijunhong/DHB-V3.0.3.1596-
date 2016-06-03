//
//  MultiModuleDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/26.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "MultiModuleDTO.h"


@implementation MultiModuleDTO


- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.multiId = [dict EncodeStringFromDicWithKey:@"multi_id"];
    self.name = [dict EncodeStringFromDicWithKey:@"name"];
    
    NSString *first;
    NSString *second;
    if (self.defaultMultiId)
    {
        NSArray *arr = [self.defaultMultiId componentsSeparatedByString:@","];
        first = [arr safeObjectAtIndex:0];
        second = [arr safeObjectAtIndex:1];
    }
    
    self.options = [NSMutableArray array];
    NSArray *options = [dict EncodeArrayFromDicWithKey:@"options"];
    for (NSDictionary *dic in options)
    {
        MultiChildModuleDTO *multiChild = [[MultiChildModuleDTO alloc] init];
        [multiChild parseFromDict:dic];
        if ([multiChild.multiId isEqualToString:first]||[multiChild.multiId isEqualToString:second])
        {
            multiChild.is_seleted = YES;
            self.defaultMultiId = multiChild.multiId;
        }
        [self.options addObject:multiChild];
    }
}

/*
 #define S_0_w 43
 #define M_0_w 101
 #define X_0_w 220
 #define S_1_w 55
 #define X_1_w 194
 */

-(CGFloat)MultiHightfWithType:(NSInteger)type{
    CGFloat hight = 0.0;
    int y_row = 1;
    int x_row = 0;
    for (int i = 0;i<[self.options count];i++)
    {
        MultiChildModuleDTO *multiChild = [self.options safeObjectAtIndex:i];
        CGSize childSize = [multiChild MultiChildSizefWithType:type];

        if (type == 0)
        {
            if (x_row >= 4)
            {
                x_row = 0;
                y_row = y_row+1;
            }
            if (childSize.width == S_0_w)
            {
                x_row += 1;
            }
            else if (childSize.width == M_0_w)
            {
                if (x_row >2)
                {
                    x_row = 0;
                    y_row += 1;
                }
                x_row = x_row +2;
            }
            else if (childSize.width ==X_0_w)
            {
//                y_row = y_row+1;
                x_row = 4;
            }
            
        }
        else if (type == 1)
        {
            if (childSize.width == S_1_w)
            {
                x_row += 1;
                if (x_row > 3)
                {
                    x_row = 0;
                    y_row = y_row+1;
                }
            }
            else if (childSize.width == X_1_w)
            {
                if(x_row > 0)
                {
                    y_row = y_row+1;
                }
                x_row = 3;
            }
            
        }
    }
    hight = hight + 25*y_row+(y_row-1)*15;
    return hight;
}


-(void)MultiChildSelect:(MultiChildModuleDTO*)multi{
    [self MultiChildSelectWithMultiId:multi.multiId];
}

-(void)MultiChildSelectWithMultiId:(NSString *)multi_id{
    for (MultiChildModuleDTO *multiChild in self.options)
    {
        if ([multiChild.multiId isEqualToString:multi_id])
        {
            multiChild.is_seleted = YES;
            self.defaultMultiId = multiChild.multiId;
        }
        else
        {
            multiChild.is_seleted = NO;
        }
    }
}




@end


@implementation MultiChildModuleDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    self.multiId =[dict EncodeStringFromDicWithKey:@"options_id"];
    self.name = [dict EncodeStringFromDicWithKey:@"options_name"];
    
}

-(CGSize)MultiChildSizefWithType:(NSInteger)type{
    
    CGSize titleSize = [self.name sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    CGFloat width = titleSize.width;
    if (type == 0)
    {
        if (width < S_0_w)
        {
            return CGSizeMake(S_0_w, 25);
        }
        else if (S_0_w <= width && width < M_0_w)
        {
            return CGSizeMake(M_0_w, 25);
        }
        else
        {
            if ([self.name length] >16)
            {
                return CGSizeMake(X_0_w, 45);
            }
            else
            {
                return CGSizeMake(X_0_w, 25);
            }
        }
    }
    else if (type ==1)
    {
        if (width < S_1_w)
        {
            return CGSizeMake(S_1_w, 25);
        }
        else
        {
            return CGSizeMake(X_1_w, 25);
        }
    }
    return CGSizeMake(0, 0);
}



@end
