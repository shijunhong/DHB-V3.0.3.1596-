//
//  DHBHomeFunctionView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#define TOP_HEIGHT 10.0F
#define PADDING 15.0F
#define LABEL_HEIGHT 30.0F

#import "DHBHomeFunctionView.h"

@implementation DHBHomeFunctionView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)updateViewWithDTO:(HomeFloorDTO *)dto {
    self.homeFunction_arr= dto.moduleList;
    
    if (self.padding == 0)
    {
        self.padding =(self.frame.size.width-30-45*4)/3;
    }
    for (int i  =0; i<[self.homeFunction_arr count]; i++)
    {
        if ([[self.homeFunction_arr objectAtIndex:i] isKindOfClass:[FunctionDTO class]])
        {
            FunctionDTO *function = [self.homeFunction_arr objectAtIndex:i];
            //添加按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+45*(i%4)+self.padding*(i%4),10+(i/4)*89, 45, 45)];
            [btn setImage:[UIImage imageNamed:function.image] forState:UIControlStateNormal];
            [btn setTag:function.functionId];
            [btn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            //添加label
            UILabel *label = [[UILabel alloc] init];
            [label setTop:btn.frame.origin.y+53];
            [label setCenterX:btn.frame.origin.x];
            [label setSize:CGSizeMake(45, 21)];
            [label setFont:[UIFont systemFontOfSize:12]];
            [label setTextColor:HEX_RGB(0x333333)];
            [label setText:function.name];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:label];
        }
    }

}

#pragma mark - 2.0版本
- (void)updateViewWithDTO_Version2:(HomeFloorDTO *)dto {
    [self.layer setMasksToBounds: NO];
    self.homeFunction_arr= dto.moduleList;
//    CGFloat btn_h = (dto.hight - 2 * (LABEL_HEIGHT + LABEL_MARGIN_TOP + FUNCTION_MARGIN_TOP) - LABEL_FUNCTION_MARGIN) / 2.0f;
//    CGFloat SIZE_W = (SCREEN_WIDTH - 2 * (FUNCTION_MARGIN_LEFT + FUNCTION_INNER_MARGIN)) / 3.0f;
    CGFloat size_w = (SCREEN_WIDTH) / 3.0f;
    CGFloat size_h = (dto.hight - TOP_HEIGHT) / 2.0f;
    CGFloat flag = ([self.homeFunction_arr count] > 6 ? 6 : [self.homeFunction_arr count]);
    ///
    UIView *topView = [[UIView alloc] initWithFrame: CGRectMake(0.0F, 0.0F, SCREEN_WIDTH, TOP_HEIGHT)];
    [topView setBackgroundColor: [UIColor clearColor]];
    [self addSubview: topView];
    ///
    for (int i  =0; i < flag; i++)
    {
        if ([[self.homeFunction_arr objectAtIndex:i] isKindOfClass:[FunctionDTO class]])
        {
            FunctionDTO *function = [self.homeFunction_arr objectAtIndex:i];
            /////添加按钮
            UIButton *backgroundBtton = [[UIButton alloc] initWithFrame:CGRectMake((i % 3) * size_w, (i / 3) * size_h + TOP_HEIGHT, size_w, size_h)];
//            [btn setImage:[UIImage imageNamed:function.image] forState:UIControlStateNormal];
            [backgroundBtton setTag:function.functionId];
            [backgroundBtton setBackgroundImage: [UIImage imageWithColor: HEX_RGB(0xe8e8e8)] forState: UIControlStateHighlighted];
            [backgroundBtton setBackgroundImage: [UIImage imageWithColor: [UIColor whiteColor]] forState: UIControlStateNormal];
            [backgroundBtton addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview: backgroundBtton];
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((size_w - (size_h - 2 * PADDING - LABEL_HEIGHT)) / 2.0f, PADDING, size_h - 2 * PADDING - LABEL_HEIGHT, size_h - 2 * PADDING - LABEL_HEIGHT)];
            [iconImageView setImage:[UIImage imageNamed:function.image]];
            [iconImageView setTag:function.functionId];
            [iconImageView setContentMode: UIViewContentModeScaleAspectFit];
            [iconImageView.layer setMasksToBounds: NO];
            [backgroundBtton addSubview: iconImageView];
            //添加label
            CGFloat ORIGIN_Y = iconImageView.frame.size.height + iconImageView.frame.origin.y;
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, ORIGIN_Y, size_w, LABEL_HEIGHT)];
            [label setFont:[UIFont systemFontOfSize: 14.0f]];
            [label setAdjustsFontSizeToFitWidth: YES];
            [label setTextColor:HEX_RGB(0x555555)];
            [label setText:function.name];
            [label setTextAlignment:NSTextAlignmentCenter];
            [backgroundBtton addSubview:label];
            
//            ///添加消息数据提醒［已取消数字的显示］
//            if([function number] > 0){
////                UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(btn.left + btn.width - TIP_LABEL_HEIGHT / 2.0f, btn.top - TIP_LABEL_HEIGHT / 2.0f, TIP_LABEL_HEIGHT, TIP_LABEL_HEIGHT)];
////                [tipLabel setFont: [UIFont systemFontOfSize: 8.0f]];
////                [tipLabel setTextAlignment: NSTextAlignmentCenter];
////                [tipLabel setTextColor: [UIColor TextRed_Color]];
////                [tipLabel setBackgroundColor: [UIColor clearColor]];
////                [tipLabel.layer setCornerRadius: TIP_LABEL_HEIGHT / 2.0f];
////                [tipLabel.layer setBorderWidth: 1.0f];
////                [tipLabel.layer setBorderColor: [UIColor TextRed_Color].CGColor];
////                [tipLabel setText: [[NSNumber numberWithInteger: [function number]] stringValue]];
////                [self addSubview: tipLabel];
//                
//                JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView: iconImageView alignment:JSBadgeViewAlignmentTopRight];
//                [badgeView setBadgeBackgroundColor:[UIColor whiteColor]];
//                [badgeView setBadgeMinWidth: 1.0f];
//                [badgeView setBadgeTextFont:[UIFont systemFontOfSize: 12.0f]];
//                [badgeView setBadgeStrokeWidth: 0.5f];
//                [badgeView setBadgeTextColor:[UIColor TextRed_Color]];
//                [badgeView setBadgeText: [[NSNumber numberWithInteger: [function number]] stringValue]];
//            }
        }
    }
}


#pragma mark - 3.0版本
- (void)updateViewWithDTO_Version3:(HomeFloorDTO *)dto {
    [self.layer setMasksToBounds: NO];
    self.homeFunction_arr= dto.moduleList;
    //    CGFloat btn_h = (dto.hight - 2 * (LABEL_HEIGHT + LABEL_MARGIN_TOP + FUNCTION_MARGIN_TOP) - LABEL_FUNCTION_MARGIN) / 2.0f;
    //    CGFloat SIZE_W = (SCREEN_WIDTH - 2 * (FUNCTION_MARGIN_LEFT + FUNCTION_INNER_MARGIN)) / 3.0f;
    CGFloat size_w = (SCREEN_WIDTH) / 3.0f;
    CGFloat size_h = (dto.hight) / 2.0f;
    CGFloat flag = ([self.homeFunction_arr count] > 6 ? 6 : [self.homeFunction_arr count]);
    ///
    for (int i  =0; i < flag; i++)
    {
        if ([[self.homeFunction_arr objectAtIndex:i] isKindOfClass:[FunctionDTO class]])
        {
            FunctionDTO *function = [self.homeFunction_arr objectAtIndex:i];
            /////添加按钮
            UIButton *backgroundBtton = [[UIButton alloc] initWithFrame:CGRectMake((i % 3) * size_w, (i / 3) * size_h, size_w, size_h)];
            //            [btn setImage:[UIImage imageNamed:function.image] forState:UIControlStateNormal];
            [backgroundBtton setTag:function.functionId];
            [backgroundBtton setBackgroundImage: [UIImage imageWithColor: HEX_RGB(0xe8e8e8)] forState: UIControlStateHighlighted];
            [backgroundBtton setBackgroundImage: [UIImage imageWithColor: [UIColor whiteColor]] forState: UIControlStateNormal];
            backgroundBtton.layer.borderWidth = 0.25f;
            backgroundBtton.layer.borderColor = [UIColor CellLine_Color].CGColor;
//            [backgroundBtton setImage:[UIImage imageNamed:function.image] forState:UIControlStateNormal];
            [backgroundBtton addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview: backgroundBtton];
//            //图标
            UIImage *img = [UIImage imageNamed:function.image];
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(size_w/2.0f-img.size.width/2.0f,size_h/2.0f-img.size.height-0.5f,img.size.width,img.size.height)];
            [iconImageView setImage:img];
            [iconImageView setTag:function.functionId];
            [iconImageView.layer setMasksToBounds: NO];
            [backgroundBtton addSubview: iconImageView];
            //添加label
            CGFloat ORIGIN_Y = iconImageView.frame.origin.y+iconImageView.frame.size.height +15.0f;
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, ORIGIN_Y, size_w, 14.0f)];
            [label setFont:[UIFont systemFontOfSize: 14.0f]];
            [label setAdjustsFontSizeToFitWidth: YES];
            [label setTextColor:HEX_RGB(0x555555)];
            [label setText:function.name];
            [label setTextAlignment:NSTextAlignmentCenter];
            [backgroundBtton addSubview:label];
            
            //            ///添加消息数据提醒［已取消数字的显示］
            //            if([function number] > 0){
            ////                UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(btn.left + btn.width - TIP_LABEL_HEIGHT / 2.0f, btn.top - TIP_LABEL_HEIGHT / 2.0f, TIP_LABEL_HEIGHT, TIP_LABEL_HEIGHT)];
            ////                [tipLabel setFont: [UIFont systemFontOfSize: 8.0f]];
            ////                [tipLabel setTextAlignment: NSTextAlignmentCenter];
            ////                [tipLabel setTextColor: [UIColor TextRed_Color]];
            ////                [tipLabel setBackgroundColor: [UIColor clearColor]];
            ////                [tipLabel.layer setCornerRadius: TIP_LABEL_HEIGHT / 2.0f];
            ////                [tipLabel.layer setBorderWidth: 1.0f];
            ////                [tipLabel.layer setBorderColor: [UIColor TextRed_Color].CGColor];
            ////                [tipLabel setText: [[NSNumber numberWithInteger: [function number]] stringValue]];
            ////                [self addSubview: tipLabel];
            //
            //                JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView: iconImageView alignment:JSBadgeViewAlignmentTopRight];
            //                [badgeView setBadgeBackgroundColor:[UIColor whiteColor]];
            //                [badgeView setBadgeMinWidth: 1.0f];
            //                [badgeView setBadgeTextFont:[UIFont systemFontOfSize: 12.0f]];
            //                [badgeView setBadgeStrokeWidth: 0.5f];
            //                [badgeView setBadgeTextColor:[UIColor TextRed_Color]];
            //                [badgeView setBadgeText: [[NSNumber numberWithInteger: [function number]] stringValue]];
            //            }
        }
    }
}

#pragma mark - 按钮点击事件
//-(void)BtnAction:(UIButton*)sender{
//    if ([_delegate respondsToSelector:@selector(functionSelectedDTO:)])
//    {
//        for (FunctionDTO *function in self.homeFunction_arr)
//        {
//            if (function.functionId == sender.tag)
//            {
//                [self.delegate functionSelectedDTO:function];
//            }
//        }
//    }
//}

-(void)BtnAction:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(functionSelectedDTO:)])
    {
        for (FunctionDTO *function in self.homeFunction_arr)
        {
            if (function.functionId == sender.tag)
            {
                [self.delegate functionSelectedDTO:function];
            }
        }
    }
}

@end
