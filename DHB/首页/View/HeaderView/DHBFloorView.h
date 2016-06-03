//
//  DHBFloorView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"

typedef void(^BtnBlock)();
@interface DHBFloorView : UIView
@property(strong ,nonatomic)UILabel *title_lb;
@property(strong ,nonatomic)UIButton *right_btn;
@property(copy ,nonatomic) BtnBlock myblock;
-(void)updateViewWithDTO:(HomeFloorDTO*)floorDTO callback:(void(^)())block;
@end