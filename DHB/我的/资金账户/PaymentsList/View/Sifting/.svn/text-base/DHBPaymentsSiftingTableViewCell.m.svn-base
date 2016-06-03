//
//  DHBPaymentsSiftingTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/14/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 10.0f
#define MARGIN_TOP 12.0f
#define TITLE_WIDTH 60.0f
#import "DHBPaymentsSiftingTableViewCell.h"

@implementation DHBPaymentsSiftingTableViewCell
#pragma mark - init
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(MARGIN_LEFT, 0.0f, TITLE_WIDTH, self.size.height)];
        [_titleLabel setTextColor: [UIColor TextBlack_Color]];
        [_titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _titleLabel;
}

- (UILabel *)depositTypeLabel{
    if(!_depositTypeLabel){
        _depositTypeLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.size.width / 2 + MARGIN_LEFT, 0.0f, self.size.width / 2.0f - 4 * MARGIN_LEFT, self.size.height)];
        [_depositTypeLabel setTextColor: [UIColor TextGray_Color]];
        [_depositTypeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_depositTypeLabel setTextAlignment: NSTextAlignmentRight];
        [_depositTypeLabel setText: @"全部"];
    }
    return _depositTypeLabel;
}

- (UILabel *)payTypeLabel{
    if(!_payTypeLabel){
        _payTypeLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.size.width / 2 + MARGIN_LEFT, 0.0f, self.size.width / 2.0f - 4 * MARGIN_LEFT, self.size.height)];
        [_payTypeLabel setTextColor: [UIColor TextGray_Color]];
        [_payTypeLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_payTypeLabel setTextAlignment: NSTextAlignmentRight];
        [_payTypeLabel setText: @"全部"];
    }
    return _payTypeLabel;
}

- (DHBTextField *)startTimeTextFiled{
    if(!_startTimeTextFiled){
        CGFloat origin_x = self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x + MARGIN_LEFT;
        textFiledWidth = (self.size.width - origin_x - 2.5 * MARGIN_LEFT) / 2.0f;
        _startTimeTextFiled = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, textFiledWidth, self.size.height - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_startTimeTextFiled showCancelButton: NO];
        [_startTimeTextFiled setLeftViewMode: UITextFieldViewModeNever];
        [_startTimeTextFiled setBackgroundColor: HEX_RGB(0xefefef)];
        [_startTimeTextFiled setDHB_Delegate: self];
        [_startTimeTextFiled setTag: 0];
        [_startTimeTextFiled setTextAlignment: NSTextAlignmentCenter];
        [_startTimeTextFiled setFont: [UIFont systemFontOfSize: 12.0f]];
    }
    return _startTimeTextFiled;
}

- (UIView *)lineView{
    if(!_lineView){
        CGFloat origin_x = self.startTimeTextFiled.frame.size.width + self.startTimeTextFiled.frame.origin.x + MARGIN_LEFT / 2.0f;
        _lineView = [[UIView alloc] initWithFrame: CGRectMake(origin_x, (self.size.height - 2.0f) / 2.0f, MARGIN_LEFT / 2.0f, 2.0f)];
        [_lineView setBackgroundColor: [UIColor CellLine_Color]];
    }
    return _lineView;
}

- (UIView *)separatorView{
    if(!_separatorView){
        _separatorView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, CELLHEIGHT - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [_separatorView setBackgroundColor: [UIColor CellLine_Color]];
    }
    return _separatorView;
}

- (DHBTextField *)endTimeTextField{
    if(!_endTimeTextField){
        CGFloat origin_x = self.lineView.frame.size.width + self.lineView.frame.origin.x + MARGIN_LEFT / 2.0f;
        _endTimeTextField = [[DHBTextField alloc] initWithFrame: CGRectMake(origin_x, MARGIN_TOP, textFiledWidth, self.size.height - 2 * MARGIN_TOP) style: kDHBTextField_MaxInputStyle];
        [_endTimeTextField showCancelButton: NO];
        [_endTimeTextField setLeftViewMode: UITextFieldViewModeNever];
        [_endTimeTextField setBackgroundColor: HEX_RGB(0xefefef)];
        [_endTimeTextField setDHB_Delegate: self];
        [_endTimeTextField setTag: 1];
        [_endTimeTextField setTextAlignment: NSTextAlignmentCenter];
        [_endTimeTextField setFont: [UIFont systemFontOfSize: 12.0f]];
    }
    return _endTimeTextField;
}

- (RBCustomDatePickerView *)datepicker{
    if(!_datepicker){
        _datepicker = [[RBCustomDatePickerView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.width, DATEPICKER_HEIGHT)];
//        [_datepicker setIslimitDate: NO];
//        [_datepicker setDatePickerStyle: kRBCustomDatePicker_ButtonBottom];
//        [_datepicker.OkBtn setLeft: 2 * MARGIN_LEFT];
//        [_datepicker.NOBtn setLeft: _datepicker.OkBtn.right + MARGIN_LEFT];
        [_datepicker setDelegate: self];
    }
    return _datepicker;
}

#pragma mark - 更新视图
- (void)updateViewWithIndexpath: (NSIndexPath *) indexPath size:(CGSize) size{
    [self setSize: size];
    [self.layer setMasksToBounds: YES];
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [self.separatorView setHidden: NO];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview: self.separatorView];
    //更新视图
    switch ([indexPath row]) {
        case 0:{
            [self addFloor_1];
            break;
        }
        case 1:{
            [self addFloor_2];
            break;
        }
        case 2:{
            [self addFloor_3];
            break;
        }
        case 3:{
            [self addFloor_4];
            [self.separatorView setHidden: YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark 付款类型
- (void)addFloor_1{
    [self.titleLabel setText: @"类型"];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.depositTypeLabel];
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
}

#pragma mark 付款方式
- (void)addFloor_2{
    [self.titleLabel setText: @"付款方式"];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.payTypeLabel];
    [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
}

#pragma mark 发货时间
- (void)addFloor_3{
    [self.titleLabel setText: @"时间"];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.startTimeTextFiled];
    [self.contentView addSubview: self.lineView];
    [self.contentView addSubview: self.endTimeTextField];
    [self setAccessoryType: UITableViewCellAccessoryNone];
}

#pragma mark 时间筛选
- (void)addFloor_4{
    [self.contentView addSubview: self.datepicker];
    [self setBackgroundColor: HEX_RGB(0xf0f0f0)];
    [self setAccessoryType: UITableViewCellAccessoryNone];
}

#pragma mark - DHBTextField_Delegate
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    self.curOperateIndex = [textField tag];
    if([_delegate respondsToSelector: @selector(paymentsSiftingTableViewCell_TextFieldDidBeginEditing:)]){
        [_delegate paymentsSiftingTableViewCell_TextFieldDidBeginEditing: textField];
    }
}

#pragma mark - RBCustomDatePickerView delegate
-(void)selectNOAction{
    if([_delegate respondsToSelector: @selector(paymentsSiftingTableViewCell_DidCancelButtonClick)]){
        [_delegate paymentsSiftingTableViewCell_DidCancelButtonClick];
    }
}

- (void)RBCustomDatePickerView:(RBCustomDatePickerView *)pickerView selectOkAction:(NSString *)selectTime
{
    if([_delegate respondsToSelector: @selector(paymentsSiftingTableViewCell_DidOkButtonClick:selectTime:)]){
        [_delegate paymentsSiftingTableViewCell_DidOkButtonClick: pickerView selectTime: selectTime];
    }
}
@end
