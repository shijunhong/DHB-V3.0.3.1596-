//
//  MultiModuleDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/26.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


#define S_0_w ((SCREEN_WIDTH<375?(SCREEN_WIDTH/375):1.0)*50)
#define M_0_w ((SCREEN_WIDTH<375?(SCREEN_WIDTH/375):1.0)*115)
#define X_0_w ((SCREEN_WIDTH<375?(SCREEN_WIDTH/375):1.0)*245)
#define S_1_w ((SCREEN_WIDTH<375?0.8:1.0)*60)
#define X_1_w ((SCREEN_WIDTH<375?0.8:1.0)*210)


@class MultiChildModuleDTO;
@interface MultiModuleDTO : NSObject
@property(nonatomic,strong)NSString *multiId;
@property(nonatomic,strong)NSString *defaultMultiId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *options;
- (void)parseFromDict:(NSDictionary *)dict;
-(CGFloat)MultiHightfWithType:(NSInteger)type; //0为商品详情页 1为列表页
-(void)MultiChildSelect:(MultiChildModuleDTO*)multi; //设置子multi中为选中
-(void)MultiChildSelectWithMultiId:(NSString *)multi_id;
@end


@interface MultiChildModuleDTO : NSObject
@property(nonatomic,strong)NSString *multiId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)BOOL is_seleted;
@property(nonatomic,assign)BOOL is_disEnable;
- (void)parseFromDict:(NSDictionary *)dict;
-(CGSize)MultiChildSizefWithType:(NSInteger)type; //0为商品详情页 1为列表页
@end