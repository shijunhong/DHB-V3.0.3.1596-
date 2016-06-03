//
//  DHBMemberInfoTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0f
#define MARGIN_TOP 10.0f
#define TITLE_WIDTH 70.0f
#import "DHBMemberInfoTableViewCell.h"
#import "ParameterPublic.h"

@implementation DHBMemberInfoTableViewCell
- (UIImageView *)arrowimageView{
    if(!_arrowimageView){
        _arrowimageView = [[UIImageView alloc] init];
        [_arrowimageView setContentMode: UIViewContentModeScaleAspectFit];
        [_arrowimageView setImage: [UIImage imageNamed: @"arrow"]];
    }
    return _arrowimageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
    }
    return _titleLabel;
}

- (DHBTextField *)contentTextFiled{
    if(!_contentTextFiled){
        CGFloat origin_x = SCREEN_WIDTH / 3.0f;
        _contentTextFiled = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, SCREEN_WIDTH - origin_x - MARGIN_LEFT, _floorDTO.hight - 2 * MARGIN_TOP)];
        [_contentTextFiled setStyle: kDHBTextField_MaxInputStyle];
        [_contentTextFiled setDHB_Delegate:self];
    }
    return _contentTextFiled;
}

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
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        void (*action)(id, SEL) = (void (*)(id, SEL))objc_msgSend;
        action(self, selectorMethod);
    }
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    [self initLineisBottom: YES];
}

#pragma mark -
#pragma mark 样式1（账号）
- (void)addFloor_1{
//    DHBMemberInfoModuleDTO *member = [_floorDTO.moduleList safeObjectAtIndex:0];
    //标题
    [self.titleLabel setFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, _floorDTO.hight)];
    [self addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //子内容
    CGFloat origin_x = SCREEN_WIDTH / 2.0f;
    UILabel *subLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, SCREEN_WIDTH - origin_x - MARGIN_LEFT, _floorDTO.hight)];
    [subLabel setTextColor: [UIColor TextGray_Color]];
    [subLabel setFont: [UIFont systemFontOfSize: 13.0f]];
    [subLabel setText: [[ParameterPublic sharedManagered] accounts_name]];
    [subLabel setTextAlignment: NSTextAlignmentRight];
    [self addSubview: subLabel];
    [self setAccessoryView: nil];
}

#pragma mark -
#pragma mark 样式2（输入框）
- (void)addFloor_2{
    DHBMemberInfoModuleDTO *member = [_floorDTO.moduleList safeObjectAtIndex:0];
    //标题
    [self.titleLabel setFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, _floorDTO.hight)];
    [self addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    //子内容
    switch ([_floorDTO.orderNO integerValue]) {
        case 1:
            [self.contentTextFiled setText: [member memberName]];
            [self.contentTextFiled setPlaceholder: @"请输入您的姓名"];
            break;
        case 2:
            [self.contentTextFiled setText: [member memberPhone]];
            [self.contentTextFiled setKeyboardType: UIKeyboardTypeNumberPad];
            [self.contentTextFiled setPlaceholder: @"请填写其它联系方式"];
            break;
        case 3:
            [self.contentTextFiled setText: [member memberMail]];
            [self.contentTextFiled setKeyboardType: UIKeyboardTypeEmailAddress];
            [self.contentTextFiled setPlaceholder: @"请输入您的邮箱"];
            break;
        default:
            break;
    }
    [self addSubview: self.contentTextFiled];
    [self setAccessoryView: nil];
}

#pragma mark -
#pragma mark 样式3（修改密码）
- (void)addFloor_3{
    //标题
    [self.titleLabel setFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, _floorDTO.hight)];
    [self addSubview: self.titleLabel];
    [self.titleLabel setText: [_floorDTO floorName]];
    
    [self addSubview: self.arrowimageView];
    [self.arrowimageView sd_layout].rightSpaceToView(self, MARGIN_LEFT - 5.0f).topSpaceToView(self, (_floorDTO.hight - 22.0f) / 2.0f).bottomSpaceToView(self, (_floorDTO.hight - 22.0f) / 2.0f).widthIs(22.0f);
//    [self setAccessoryView: self.arrowimageView];
}

#pragma mark - textFiel delegate

-(BOOL)DHBTextFieldShouldBeginEditing:(UITextField *)textField{
    if([_delegate respondsToSelector: @selector(DHBTableViewCellBeginEditing:)]){
        [_delegate DHBTableViewCellBeginEditing:self];
    }
    return YES;
}


- (BOOL)DHBTextFieldShouldReturn:(UITextField *)textField{
    if([_delegate respondsToSelector: @selector(memberInfoTableViewCell_TextFieldShouldReturn:)]){
        [_delegate memberInfoTableViewCell_TextFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""] && textField == self.contentTextFiled)
    {
        switch ([_floorDTO.orderNO integerValue]) {
            case 1://姓名
                if (range.location >= 30 || [textField.text length] >=30) return NO;//小于30位数
                break;
            case 2://电话号码
                if (range.location >= 11) return NO;//小于11位数
                return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"] evaluateWithObject:string];//只能输入0-9数字
                break;
            case 3://邮箱
                if (range.location >= 30) return NO;//小于30位数
                //@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
                return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[A-Z0-9a-z._%+-@]"] evaluateWithObject:string];//只能输入email数字
                break;
            default:
                break;
        }
    }
    return YES;
}
@end
