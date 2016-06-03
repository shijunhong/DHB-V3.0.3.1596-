//
//  DHBMiaoShaView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/26.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "HomeFloorDTO.h"
#import "ActivityModuleDTO.h"


@interface DHBMiaoShaView : UIView

/**
 *  依据数据源，更新界面
 *
 *  @param array dto数组
 */
- (void)updateViewWithDTO:(ActivityModuleDTO *)dto;

@end
