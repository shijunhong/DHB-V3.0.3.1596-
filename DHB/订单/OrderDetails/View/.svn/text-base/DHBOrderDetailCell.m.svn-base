//
//  DHBOrderDetailCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/15.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderDetailCell.h"
#import "OrderModuleDTO.h"
@implementation DHBOrderDetailCell

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    if (_floorDTO != dto)
    {
        _floorDTO = dto;
    }
    
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        objc_msgSend(self, selectorMethod);
    }
}

- (void)addFloor_1 {
    OrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view1" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    [self.image_cell1_img setImage:[UIImage imageNamed:@"ddzt"]];
    [self.name_cell1_lb setText:_floorDTO.floorName];
    [self.type_cell1_lb setText:order.status];
    [self.label1_cell1_lb setText:[NSString stringWithFormat:@"订单号：%@",order.orders_num]];
    [self.label2_cell1_lb setText:[NSString stringWithFormat:@"下单时间：%@",order.create_date]];
    [self.contentView addSubview:view];
    
    [self.contentView initLineisBottom:YES];
}
- (void)addFloor_2 {
    NSDictionary *data = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view2" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    [self.image_cell2_img setImage:[UIImage imageNamed:[data objectForKey:@"image"]]];
    [self.name_cell2_lb setText:_floorDTO.floorName];
    [self.type_cell2_lb setText:[data objectForKey:@"type"]];
    [self.contentView addSubview:view];
    //底部还需要划线
    [self.contentView initLineisBottom:YES];
    
}
- (void)addFloor_3 {
    NSDictionary *data = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view3" owner:self options:nil] objectAtIndex:0];
//    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    [self.contentView addSubview:view];
    [self.image_cell3_img setImage:[UIImage imageNamed:[data objectForKey:@"image"]]];
    [self.name_cell3_lb setText:_floorDTO.floorName];
    [self.remark_cell3_lb setText:[data objectForKey:@"remark"]];
    view.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).bottomSpaceToView(self.contentView,0.0f);
    //顶部还需要划线
    [self.contentView initLineisBottom:NO];
    //底部还需要划线
    [self.contentView initLineisBottom:YES];
}
- (void)addFloor_4 {
    NSDictionary *dic = [_floorDTO.moduleList safeObjectAtIndex:0];
    NSArray *arr = [dic EncodeArrayFromDicWithKey:@"arr"];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view4" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.size.width, 43.0f)];
    [self.price_cell4_lb setText:[NSString stringWithFormat:@"%@%@",L(@"￥"),[dic EncodeStringFromDicWithKey:@"discount_total"]]];
    [self.price_cell4_lb setRight: SCREEN_WIDTH - 15.0f];
    [self.image_cell4_img setImage:[UIImage imageNamed:@"ddje"]];
    [self.contentView addSubview:view];
    view.sd_layout.heightIs(43.0f);
    
    for (int i = 0; i<[arr count]; i++)
    {
        NSDictionary *dict = [arr safeObjectAtIndex:i];
        UILabel * name_lb = [[UILabel alloc] initWithFrame:CGRectMake(48, 30*i+view.height, 150, 20)];
        [name_lb setFont:[UIFont systemFontOfSize:13]];
        [name_lb setTextColor:[UIColor TextGray_Color]];
        [name_lb setText:[dict objectForKey:@"name"]];
        [self.contentView addSubview:name_lb];
        
        UILabel *value_lb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-self.price_cell4_lb.width-15, name_lb.top, self.price_cell4_lb.width, 20)];
        [value_lb setFont:[UIFont systemFontOfSize:13]];
        [value_lb setTextColor:[UIColor TextGray_Color]];
        [value_lb setTextAlignment:NSTextAlignmentRight];
        [value_lb setText:[NSString stringWithFormat:@"%@%@",L(@"￥"),[dict objectForKey:@"value"]]];
        [self.contentView addSubview:value_lb];
    }
    
    //底部还需要划线
    [self.contentView initLineisBottom:YES];
    
}
- (void)addFloor_5 {
    OrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view ;
    if ([order.pay_status isEqualToString:@"已付款"])
    {
        view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view8" owner:self options:nil] objectAtIndex:0];
        [self.name_cell8_lb setText:@"付款记录"];
        [self.type_cell8_lb setText:order.pay_status];
        [self.image_cell8_img setImage:[UIImage imageNamed:@"fkjl"]];
    }
    else
    {
        if ([order.status isEqualToString:@"已取消"])
        {
            view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view8" owner:self options:nil] objectAtIndex:0];
            [self.name_cell8_lb setText:@"付款记录"];
            [self.type_cell8_lb setText:order.status];
            [self.image_cell8_img setImage:[UIImage imageNamed:@"fkjl"]];
        }
        else
        {
            view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view5" owner:self options:nil] objectAtIndex:0];
            [self.image_cell5_img setImage:[UIImage imageNamed:@"fkjl"]];
            [self.image_cell5_img setContentMode: UIViewContentModeScaleAspectFit];
            [self.type_cell5_lb setText:order.pay_status ];
            [self.label1_cell5_lb setText:[NSString stringWithFormat:@"待付：%@",order.account_notpaid]];
            if([order.account_paid doubleValue] > 0)
                [self.label2_cell5_lb setText:[NSString stringWithFormat:@"已付：%@",order.account_paid]];
            else
                [self.label2_cell5_lb setText: @""];
        }
    }
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - DEFAULT_SECTION_HEIGHT)];
    [self.contentView addSubview:view];
    //创建底部
    [self.contentView initSectionView];
}
- (void)addFloor_6 {
    OrderModuleDTO *order = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view6" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height-DEFAULT_SECTION_HEIGHT)];
    [self.image_cell6_img setImage:[UIImage imageNamed:@"shr"]];
    [self.label1_cell6_lb setText:[NSString stringWithFormat:@"%@       %@",order.consignee_contact,order.consignee_phone]];
    [self.label2_cell6_lb setText:order.consignee_address];
    [self.contentView addSubview:view];
    [self.contentView initSectionView];
}

- (void)addFloor_7 {
    NSDictionary *data = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view7" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    [self.image_cell7_img setImage:[UIImage imageNamed:[data objectForKey:@"image"]]];
    [self.name_cell7_lb setText:_floorDTO.floorName];
    [self.type_cell7_lb setText:[data objectForKey:@"type"]];
    [self.contentView addSubview:view];
    //底部还需要划线
    [self.contentView initLineisBottom:YES];
}

- (void)addFloor_8 {
    //顶部视图
    CGFloat section_higth = 15.0f;
    [self initSectionViewTop_bottom:YES isHigth:section_higth];
    
    if (_floorDTO.moduleList && [_floorDTO.moduleList count]>0)
    {
        //两个按钮
        CGFloat btn_width = (SCREEN_WIDTH-(15.0f*2+15.0f))/2.0f;
        DHBButton *left_btn =[[DHBButton alloc] initStyle:[[[_floorDTO.moduleList safeObjectAtIndex:0] EncodeNumberFromDicWithKey:@"btnColor"] intValue]];
        [left_btn setTitle:[[_floorDTO.moduleList safeObjectAtIndex:0] objectForKey:@"butTitel"] forState:UIControlStateNormal];
        [left_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:left_btn];
        left_btn.sd_layout.topSpaceToView(self.contentView,section_higth+15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(btn_width).bottomSpaceToView(self.contentView,15.0f);
        
        DHBButton *right_btn =[[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
        [right_btn setTitle:L(@"订单留言") forState:UIControlStateNormal];
        [right_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:right_btn];
        right_btn.sd_layout.topSpaceToView(self.contentView,section_higth+15.0f).leftSpaceToView(left_btn,15.0f).rightSpaceToView(self.contentView,15.0f).bottomSpaceToView(self.contentView,15.0f);
    }
    else
    {
        DHBButton *btn =[[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
        [btn setTitle:L(@"订单留言") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn.sd_layout.topSpaceToView(self.contentView,section_higth+15.0f).leftSpaceToView(self.contentView,15.0f).rightSpaceToView(self.contentView,15.0f).bottomSpaceToView(self.contentView,15.0f);
    }
}

- (void)addFloor_9 {
    NSDictionary *data = [_floorDTO.moduleList safeObjectAtIndex:0];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"DHBOrderDeteilCell_view8" owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    [self.image_cell8_img setImage:[UIImage imageNamed:[data objectForKey:@"image"]]];
    [self.name_cell8_lb setText:_floorDTO.floorName];
    [self.type_cell8_lb setText:[data objectForKey:@"type"]];
    [self.contentView addSubview:view];
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _floorDTO.hight-DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.contentView addSubview:bottomImageView];
}


#pragma mark ButtonAction
-(void)btnAction:(UIButton*)sender{
    if ([sender.titleLabel.text isEqualToString:L(@"申请退货")])
        [self.delegate DHBOrderDetailCell:self tuihuoActionBtn:sender withHomeFloorDTO:self.floorDTO];
    else if ([sender.titleLabel.text isEqualToString:L(@"取消订单")])
        [self.delegate DHBOrderDetailCell:self cancelActionBtn:sender withHomeFloorDTO:self.floorDTO];
    else if ([sender.titleLabel.text isEqualToString:L(@"订单留言")])
        [self.delegate DHBOrderDetailCell:self msgActionBtn:sender withHomeFloorDTO:self.floorDTO];
    else if ([sender.titleLabel.text isEqualToString:L(@"确认收货")])
        [self.delegate DHBOrderDetailCell:self stockActionBtn:sender withHomeFloorDTO:self.floorDTO];
}

- (IBAction)payAction:(UIButton *)sender {
    [self.delegate DHBOrderDetailCell:self payActionBtn:sender withHomeFloorDTO:self.floorDTO];
}

@end


