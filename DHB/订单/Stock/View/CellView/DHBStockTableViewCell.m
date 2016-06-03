//
//  DHBStockTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBStockTableViewCell.h"
#import "DHBConfirmReceiptRequest.h"

@implementation DHBStockTableViewCell

//-(UILabel *)num_lb{
//    if (!_num_lb)
//    {
//        _num_lb = [UILabel new];
//        _num_lb.font = [UIFont systemFontOfSize:15.0f];
//        _num_lb.textColor = [UIColor TextBlack_Color];
//        [self.contentView addSubview:_num_lb];
//    }
//    return _num_lb;
//}

//-(UILabel *)type_lb{
//    if (!_type_lb)
//    {
//        _type_lb = [UILabel new];
//        _type_lb.font = [UIFont systemFontOfSize:15.0f];
//        _type_lb.textColor = [UIColor TextGray_Color];
//        [self.contentView addSubview:_type_lb];
//    }
//    return _type_lb;
//}


//-(DHBButton *)details_btn{
//    if (!_details_btn)
//    {
//        _details_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
//        [_details_btn setTitle:@"物流信息" forState:UIControlStateNormal];
//        [_details_btn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_details_btn];
//    }
//    return _details_btn;
//}

//-(DHBButton *)sure_btn{
//    if (!_sure_btn)
//    {
//        _sure_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue3];
//        [_sure_btn setTitle:@"确认收货" forState:UIControlStateNormal];
//        [_sure_btn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_sure_btn];
//    }
//    return _sure_btn;
//}

- (void)updateViewWithDTO:(ShipsChildModuleDTO *)ships{
    self.ships = ships;
    [self.contentView removeAllSubviews];
    
    
    self.icon_vi = [[UIImageView alloc] init];
    [self.icon_vi setImage:[UIImage imageNamed:@"ddzt"]];
    [self.contentView addSubview:self.icon_vi];
    self.icon_vi.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.contentView,15.0f).widthIs(19.0f).heightIs(19.0f);
    
    self.num_lb = [UILabel new];
    self.num_lb.font = [UIFont systemFontOfSize:15.0f];
    self.num_lb.textColor = [UIColor TextBlack_Color];
    [self.contentView addSubview:self.num_lb];
    self.num_lb.text = ships.ships_num;
    self.num_lb.sd_layout.centerYEqualToView(self.icon_vi).leftSpaceToView(self.icon_vi,15.0f).autoHeightRatio(0);
    [self.num_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:arrow_img];
    arrow_img.sd_layout.centerYEqualToView(self.num_lb).rightSpaceToView(self.contentView,10.0f).widthIs(22.0f).heightIs(22.0f);
    
    
    self.type_lb = [UILabel new];
    self.type_lb.font = [UIFont systemFontOfSize:15.0f];
    self.type_lb.textColor = [UIColor TextGray_Color];
    [self.contentView addSubview:self.type_lb];
    self.type_lb.text = ships.status;
    self.type_lb.sd_layout.centerYEqualToView(self.num_lb).rightSpaceToView(arrow_img,5.0f).autoHeightRatio(0);
    [self.type_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    UIView *bottom_v = [UIView new];
    bottom_v.backgroundColor = [UIColor UIViewBackGroundColor];
    [self.contentView addSubview:bottom_v];
    if ([ships.status isEqualToString:@"待发货"])
    {
        UIView *goodsCount_v = [self viewTemplate_1Type:@"商品数量" Value:ships.goods_count];
        [self.contentView addSubview:goodsCount_v];
        goodsCount_v.sd_layout.topSpaceToView(self.num_lb,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *shipsDate_v = [self viewTemplate_1Type:@"出库时间" Value:ships.ships_date];
        [self.contentView addSubview:shipsDate_v];
        shipsDate_v.sd_layout.topSpaceToView(goodsCount_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);

        bottom_v.sd_layout.topSpaceToView(shipsDate_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    }
    else if ([ships.status isEqualToString:@"待收货"])
    {
        UIView *goodsCount_v = [self viewTemplate_1Type:@"商品数量" Value:ships.goods_count];
        [self.contentView addSubview:goodsCount_v];
        goodsCount_v.sd_layout.topSpaceToView(self.num_lb,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *shipsDate_v = [self viewTemplate_1Type:@"发货时间" Value:ships.ships_date];
        [self.contentView addSubview:shipsDate_v];
        shipsDate_v.sd_layout.topSpaceToView(goodsCount_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *shipsCompy_v = [self viewTemplate_1Type:@"物流公司" Value:ships.logistics_name];
        [self.contentView addSubview:shipsCompy_v];
        shipsCompy_v.sd_layout.topSpaceToView(shipsDate_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *expressNum_v = [self viewTemplate_1Type:@"物流单号" Value:ships.express_num];
        [self.contentView addSubview:expressNum_v];
        expressNum_v.sd_layout.topSpaceToView(shipsCompy_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *cutline = [UIView new];
        cutline.backgroundColor = [UIColor CellLine_Color];
        [self.contentView addSubview:cutline];
        cutline.sd_layout.topSpaceToView(expressNum_v,15.0f).leftSpaceToView(self.contentView,0.0).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
        
        
        self.sure_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue3];
        self.sure_btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.sure_btn setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.sure_btn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.sure_btn];
        self.sure_btn.sd_layout.topSpaceToView(cutline,8.0f).rightSpaceToView(self.contentView,15.0f).widthIs(75.0f).heightIs(30.0f);
        
        self.details_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
        self.details_btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.details_btn setTitle:@"物流信息" forState:UIControlStateNormal];
        [self.details_btn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.details_btn];
        if (!ships.express_num || [ships.express_num isEqualToString:@""])
        {
            [self.details_btn setEnabled:NO];
        }
        self.details_btn.sd_layout.topSpaceToView(cutline,8.0f).rightSpaceToView(self.sure_btn,8.0f).widthIs(75.0f).heightIs(30.0f);
        
        bottom_v.sd_layout.topSpaceToView(self.details_btn,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    }
    else if ([ships.status isEqualToString:@"已收货"])
    {
        UIView *goodsCount_v = [self viewTemplate_1Type:@"商品数量" Value:ships.goods_count];
        [self.contentView addSubview:goodsCount_v];
        goodsCount_v.sd_layout.topSpaceToView(self.num_lb,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *shipsDate_v = [self viewTemplate_1Type:@"发货时间" Value:ships.ships_date];
        [self.contentView addSubview:shipsDate_v];
        shipsDate_v.sd_layout.topSpaceToView(goodsCount_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *shipsCompy_v = [self viewTemplate_1Type:@"物流公司" Value:ships.logistics_name];
        [self.contentView addSubview:shipsCompy_v];
        shipsCompy_v.sd_layout.topSpaceToView(shipsDate_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *expressNum_v = [self viewTemplate_1Type:@"物流单号" Value:ships.express_num];
        [self.contentView addSubview:expressNum_v];
        expressNum_v.sd_layout.topSpaceToView(shipsCompy_v,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(15.0f);
        
        UIView *cutline = [UIView new];
        cutline.backgroundColor = [UIColor CellLine_Color];
        [self.contentView addSubview:cutline];
        cutline.sd_layout.topSpaceToView(expressNum_v,15.0f).leftSpaceToView(self.contentView,0.0).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
        
        self.details_btn = [[DHBButton alloc] initStyle:kDHBButton_StyleValue4];
        self.details_btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.details_btn setTitle:@"物流信息" forState:UIControlStateNormal];
        [self.details_btn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.details_btn];
        if (!ships.express_num || [ships.express_num isEqualToString:@""])
        {
//            [self.details_btn setEnabled:NO];
        }
        self.details_btn.sd_layout.topSpaceToView(cutline,8.0f).rightSpaceToView(self.contentView,8.0f).widthIs(75.0f).heightIs(30.0f);
        
        bottom_v.sd_layout.topSpaceToView(self.details_btn,8.0f).leftSpaceToView(self.contentView,0.0f).rightSpaceToView(self.contentView,0.0f).heightIs(DEFAULT_LINE_HEIGHT);
    }
    
    [self setupAutoHeightWithBottomView:bottom_v bottomMargin:0.0f];
}


-(UIView*)viewTemplate_1Type:(NSString*)type Value:(NSString*)value{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    float typeWidth = [type sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 15.0f)].width;
    UILabel *type_lb = [[UILabel alloc] initWithFrame:CGRectMake(15.0f+19.0f+15.0f, 0.0f, typeWidth, 15.0f)];
    type_lb.font = [UIFont systemFontOfSize:15.0f];
    type_lb.textColor = [UIColor TextGray_Color];
    type_lb.text = type;
    [view addSubview:type_lb];
    
    UILabel *value_lb = [UILabel new];
    value_lb.font = [UIFont systemFontOfSize:15.0f];
    value_lb.textColor = [UIColor TextGray_Color];
    [view addSubview:value_lb];
    value_lb.text = value;
    value_lb.sd_layout.centerYEqualToView(type_lb).rightSpaceToView(view,15.0f).autoHeightRatio(0);
    [value_lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    [view setupAutoHeightWithBottomView:type_lb bottomMargin:0.0f];
    return view;
}

//物流信息
- (void)logisticsAction:(UIButton *)sender {
    [self.delegate DHBStockTableViewCell:self clickLogisticsAction:self.ships];
}
//确认收货
- (void)sureAction:(UIButton *)sender {
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"确认收货？" delegate: self cancelButtonTitle: @"取消" otherButtonTitles: @"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        DHBConfirmReceiptRequest *confirmReceipt = [[DHBConfirmReceiptRequest alloc] init];
        confirmReceipt.ships_id = self.ships.ships_id;
        confirmReceipt.orders_id = self.ships.orders_id;
        [confirmReceipt postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
            if(isSuccess){
                isSuccess = [[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 0 ? NO : YES;
                if(isSuccess){
                    [self.delegate DHBStockTableViewCell:self clickSureAction:self.ships];
                }
                else{
                    [[DHBAlertView sharedManagered] showMessage: @"收货失败请稍候再试"];
                }
            }
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            
        }];
    }
}

@end
