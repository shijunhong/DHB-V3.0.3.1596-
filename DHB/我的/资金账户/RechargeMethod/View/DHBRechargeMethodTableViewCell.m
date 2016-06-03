//
//  DHBRechargeMethodTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0F
#define LABEL_WIDTH 75.0f
#define ICON_HEIGHT 20.0f

#import "DHBRechargeMethodTableViewCell.h"
#import "PayType.h"
#import "OrderModuleDTO.h"

@implementation DHBRechargeMethodTableViewCell
#pragma mark - init
//- (UIView *)maskView{
//    if(!_maskView){
//        _maskView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 0.0f)];
//        [_maskView setBackgroundColor: [[UIColor alloc] initWithWhite: 0.8f alpha: 0.7f]];
//        [_maskView setHidden: YES];
//    }
//    return _maskView;
//}
#pragma mark - 更新视图
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    _floorDTO = dto;
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    [self setBackgroundColor: [UIColor whiteColor]];
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
}

#pragma mark -
#pragma mark 样式1（类型）
- (void)addFloor_1{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, SCREEN_WIDTH/ 2.0f, _floorDTO.hight)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: [_floorDTO floorName]];
    [self.contentView addSubview: titleLabel];
    //充值类型
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    UILabel *typeLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - 2 * MARGIN_LEFT, _floorDTO.hight)];
    [typeLabel setTextColor: [UIColor TextRed_Color]];
    [typeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
    [typeLabel setTextAlignment: NSTextAlignmentRight];
    [typeLabel setText: @"预存款充值"];
    [self.contentView addSubview: typeLabel];
    //下划线
    [self initLineisBottom: YES];
    [self setAccessoryType: UITableViewCellAccessoryNone];
}

#pragma mark -
#pragma mark 样式2（充值金额）
- (void)addFloor_2{
    OrderModuleDTO *order = [[[_floorDTO moduleList] firstObject] objectForKey:@"order"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, SCREEN_WIDTH/ 2.0f, _floorDTO.hight)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: [_floorDTO floorName]];
    [self.contentView addSubview: titleLabel];
    ///充值金额
    CGFloat origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    if(!self.priceTextFiled)
    {
        self.priceTextFiled = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_LEFT,(SCREEN_WIDTH - origin_x - 20.0f - 2 * MARGIN_LEFT), _floorDTO.hight - 2 * MARGIN_LEFT) style:kDHBTextField_MaxInputStyle];
        [self.priceTextFiled setTextAlignment: NSTextAlignmentCenter];
        [self.priceTextFiled setFontSize: 13.0f];
        [self.priceTextFiled showCancelButton: NO];
        [self.priceTextFiled setDHB_Delegate: self];
        [self.priceTextFiled setKeyboardType: UIKeyboardTypeDecimalPad];
    }
    if(order){
        self.priceTextFiled.text = order.account_notpaid;
    }
    [self.contentView addSubview: self.priceTextFiled];
    //元
    origin_x = self.priceTextFiled.frame.size.width + self.priceTextFiled.frame.origin.x + MARGIN_LEFT;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, (_floorDTO.hight - 20.0f) / 2.0f, 20.0f, 20.0f)];
    [tipLabel setText: @"元"];
    [tipLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [tipLabel setTextColor: [UIColor TextGray_Color]];
    [self.contentView addSubview: tipLabel];
    //下划线
    [self initLineisBottom: YES];
    [self setAccessoryType: UITableViewCellAccessoryNone];
}

#pragma mark -
#pragma mark 样式3（支付方式）
- (void)addFloor_3{
    PayType *pay = [[[_floorDTO moduleList] firstObject] objectForKey:@"pay"];
    ///图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(MARGIN_LEFT, (_floorDTO.hight - ICON_HEIGHT) / 2.0F, ICON_HEIGHT,ICON_HEIGHT)];
    [iconImageView setContentMode: UIViewContentModeScaleAspectFit];
    [self.contentView addSubview: iconImageView];
    
    //标题
    CGFloat origin_x = iconImageView.frame.size.width + iconImageView.frame.origin.x + 5.0F;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, LABEL_WIDTH, _floorDTO.hight)];
    [titleLabel setTextColor: [UIColor TextBlack_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: pay.paytype];
    [self.contentView addSubview: titleLabel];
    ///推荐
    origin_x = titleLabel.frame.size.width + titleLabel.frame.origin.x;
    UIImageView *recommonLabel = [[UIImageView alloc] initWithFrame: CGRectMake(origin_x, (_floorDTO.hight - 20.0f) / 2.0f, 40.0f, 20.0f)];
    [recommonLabel setImage: [UIImage imageNamed: @"recom"]];
    [recommonLabel setContentMode: UIViewContentModeScaleAspectFit];
    [recommonLabel setHidden: YES];
    [self.contentView addSubview: recommonLabel];
    [self.contentView setBackgroundColor: [UIColor clearColor]];
    //余额
    ///
    switch (pay.type)
    {
        case Quick:
            [iconImageView setImage: [UIImage imageNamed:@"quickpay"]];
            [recommonLabel setHidden: NO];
            break;
        case Alipay:
            [iconImageView setImage: [UIImage imageNamed:@"alipay"]];
            break;
        case Micro:
            [iconImageView setImage: [UIImage imageNamed:@"wechatpay"]];
            break;
        case Offline:
            [iconImageView setImage: [UIImage imageNamed:@"realpay"]];
            break;
        case BaiTiao:
        {
            [self setBackgroundColor: HEX_RGB(0xfcfcfc)];
            //
            [titleLabel setTextColor: [UIColor TextGray_Color]];
            [titleLabel sizeToFit];
            [titleLabel setTop: (_floorDTO.hight - titleLabel.height) / 2.0f];
            [iconImageView setImage: [UIImage imageNamed:@"baitiao"]];
            //
            UILabel *subLabel = [[UILabel alloc] initWithFrame: CGRectMake(titleLabel.right, 0.0f, SCREEN_WIDTH - titleLabel.right - 2 * MARGIN_LEFT, _floorDTO.hight)];
            [subLabel setTextColor: [UIColor TextGray_Color]];
            [subLabel setFont: [UIFont systemFontOfSize: 13.0f]];
            [subLabel setText: @"(即将推出)"];
            [self.contentView addSubview: subLabel];
            break;
        }
        case Deposit:
        {
            [iconImageView setImage: [UIImage imageNamed:@"yczf"]];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(recommonLabel.right, (_floorDTO.hight - 20.0f)  / 2.0f, SCREEN_WIDTH-recommonLabel.right-15.0f-20.0f, 20.0f)];
            lable.font = [UIFont systemFontOfSize:15];
            [lable setTextAlignment:NSTextAlignmentRight];
            [lable setTextColor:[UIColor TextBlack_Color]];
            [lable setText:[NSString stringWithFormat:@"余额：%@",pay.money]];
            [self.contentView addSubview:lable];
        }
            break;
        default:
            break;
    }
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];

    if([[pay is_client] isEqualToString: @"F"] || [[pay is_manager] isEqualToString: @"F"]){
        ///当未开通快捷支付时，不能点击快捷支付
//        [self.maskView setHidden: NO];
        [self setBackgroundColor: HEX_RGB(0xfcfcfc)];
        [iconImageView setImage: [UIImage imageNamed:@"quickpay_gray"]];
        [titleLabel setTextColor: [UIColor grayColor]];
    }
    
    //下划线
    [self initLineisBottom: YES];
}


#pragma mark -
#pragma mark 样式4（类型）
- (void)addFloor_4{
    OrderModuleDTO *order = [[[_floorDTO moduleList] firstObject] objectForKey:@"order"];
    
    TTTAttributedLabel *typeLabel = [[TTTAttributedLabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 15.0f, SCREEN_WIDTH-MARGIN_LEFT*2, 20.0f)];
    [typeLabel setTextColor: [UIColor TextGray_Color]];
    [typeLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [typeLabel setTextAlignment: NSTextAlignmentLeft];
    [typeLabel setText:@"类型：订单付款" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange redRange = [[mutableAttributedString string] rangeOfString:@"订单付款" options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor TextRed_Color] CGColor] range:redRange];
        return mutableAttributedString;
    }];
    
    [self.contentView addSubview: typeLabel];
    
    //订单号
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, typeLabel.bottom+15, SCREEN_WIDTH-MARGIN_LEFT*2, 20.0f)];
    [titleLabel setTextColor: [UIColor TextGray_Color]];
    [titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [titleLabel setText: [NSString stringWithFormat:@"订单号：%@",order.orders_num]];
    [self.contentView addSubview: titleLabel];
    //订单金额
    TTTAttributedLabel *orderPriceLabel = [[TTTAttributedLabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, titleLabel.bottom+15, SCREEN_WIDTH-MARGIN_LEFT*2, 20.0f)];
    [orderPriceLabel setTextColor: [UIColor TextGray_Color]];
    [orderPriceLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    [orderPriceLabel setText:[NSString stringWithFormat:@"待付金额：%@%@",L(@"￥"),order.account_notpaid]afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange redRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@%@",L(@"￥"),order.discount_total] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor Money_Color] CGColor] range:redRange];
        return mutableAttributedString;
    }];
    [self.contentView addSubview: orderPriceLabel];
    
    [self initLineisBottom: YES];
    [self initLineisBottom: NO];
}

#pragma mark - DHBTextField_Delegate
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    if([_delegate respondsToSelector: @selector(rechargeMethodTableViewCell_textFieldDidBeginEditing:)]){
        [_delegate rechargeMethodTableViewCell_textFieldDidBeginEditing: textField];
    }
}
- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString: @""])
    {
        if (textField == self.priceTextFiled)
        {
            NSString *strFormat = @"[0-9]";
            NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strFormat];
            if([string isEqualToString: @"."] && ![[textField text] containsString: @"."])return YES; ///只允许输入一个小数点
            if (![strPredicate evaluateWithObject:string]) return NO;//当不是数字的时候不允许输入
            //判断小数点前的位数不能超过8位,小数点后的位数不能超过2位(注：此时需要判断当前输入的值是在小数点之前还是在小数点之后)
            NSArray *tmpArray = [[textField text] componentsSeparatedByString: @"."];
            BOOL isValidata = YES;
            if ([tmpArray count] <= 1)
            {
                //没有有小数点
                isValidata = [[tmpArray objectAtIndex: 0] length] < 8 ? YES : NO;
            }
            else
            {
                //有小数
                isValidata = [[tmpArray objectAtIndex: 0] length] <= 8 ? YES : NO;
                if([tmpArray count] > 1 && isValidata)
                {
                    isValidata = [[tmpArray objectAtIndex: 1] length] < 2 ? YES : NO;
                }
            }
            return isValidata;
        }
    }
    return YES;
}
@end
