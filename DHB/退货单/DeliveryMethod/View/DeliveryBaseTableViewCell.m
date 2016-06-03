//
//  DeliveryBaseTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN_LEFT 15.0F
#define TITLE_WIDTH 70.0F
#import "DeliveryBaseTableViewCell.h"

@interface DeliveryBaseTableViewCell ()
/**
 *  标题
 */
@property(nonatomic, strong) UILabel *titleLabel;
/**
 *  时间选择器
 */
@property(nonatomic, retain) RBCustomDatePickerView * datepicker;
@end

@implementation DeliveryBaseTableViewCell
#pragma mark - gettres and setters
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_titleLabel setAdjustsFontSizeToFitWidth: YES];
    }
    return _titleLabel;
}

- (DHBTextField *)contentTextFiled{
    if(!_contentTextFiled){
        _contentTextFiled = [[DHBTextField alloc] init];
        [_contentTextFiled setStyle: kDHBTextField_MaxInputStyle];
        [_contentTextFiled setDHB_Delegate: self];
    }
    return _contentTextFiled;
}

- (RBCustomDatePickerView *)datepicker{
    if(!_datepicker){
        _datepicker = [[RBCustomDatePickerView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 160.0f)];
        [_datepicker setDelegate: self];
    }
    return _datepicker;
}

#pragma mark - 更新视图
- (void)updateViewWithDTO:(HomeFloorDTO *)dto pickerHeight: (CGFloat) pickerHeight{
    self.floorDTO = dto;
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    //重新布局
    [self.titleLabel setFrame: CGRectZero];
    [self.contentTextFiled setFrame: CGRectZero];
    
    if(![[dto floorName] isEqualToString: @"时间筛选器"]){
        [self loadCommonCell];
    }
    else{
        if(pickerHeight > 0){
            [self loadDatePicker: pickerHeight];
            [self.datepicker setHidden: NO];
        }
        else if(!IsNilOrNull(_datepicker)){
            [_datepicker setHidden: YES];
        }
    }
}

#pragma mark - 加载通用cell
- (void)loadCommonCell{
    [self.contentView addSubview: self.titleLabel];
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, MARGIN_LEFT)
    .topSpaceToView(self.contentView, 0.0f)
    .widthIs(TITLE_WIDTH)
    .heightIs(50.0f);
    
    [self.contentView addSubview: self.contentTextFiled];
    self.contentTextFiled.sd_layout
    .leftSpaceToView(self.titleLabel, MARGIN_LEFT)
    .topSpaceToView(self.contentView, 5.0f)
    .rightSpaceToView(self.contentView, MARGIN_LEFT)
    .bottomSpaceToView(self.contentView, 5.0f);
    [self initLineisBottom: NO];
    [self initLineisBottom: YES];
    
    [self.titleLabel setText: [self.floorDTO floorName]];
    DHBDeliveryMethodMoudleDTO *model = [[self.floorDTO moduleList] firstObject];
    if([[self.floorDTO floorName] isEqualToString: @"发货日期"]){
        [self.contentTextFiled setPlaceholder: @"yyyy-mm-dd"];
        if(!IsNilOrNull([model send_date])){
            [self.contentTextFiled setText: [model send_date]];
        }
    }
    else if([[self.floorDTO floorName] isEqualToString: @"物流公司"]){
       [self.contentTextFiled setPlaceholder: @"请输入物流公司"];
        if(!IsNilOrNull([model send_company])){
            [self.contentTextFiled setText: [model send_company]];
        }
    }
    else if([[self.floorDTO floorName] isEqualToString: @"物流单号"]){
        [self.contentTextFiled setPlaceholder: @"请输入物流单号"];
        if(!IsNilOrNull([model send_no])){
            [self.contentTextFiled setText: [model send_no]];
        }
    }
    [self setupAutoHeightWithBottomView: self.titleLabel bottomMargin: 0.0f];
}

#pragma mark 加载时间选择器
- (void)loadDatePicker:(CGFloat) pickerHeight{
    [self.contentView addSubview: self.datepicker];
}

#pragma mark - textField delegate
- (void)DHBTextFieldDidBeginEditing:(UITextField *)textField{
    ////由DHBTableViewController执行键盘的控制逻辑
    if([_delegate respondsToSelector: @selector(DHBTableViewCellBeginEditing:)]){
        [_delegate DHBTableViewCellBeginEditing:self];
    }
}

- (BOOL)DHBTextFieldShouldBeginEditing:(UITextField *)textField{
    if([[self.floorDTO floorName] isEqualToString: @"发货日期"]){
        if([_delegate respondsToSelector: @selector(baseTableViewCell_openDatePicker:)]){
            [_delegate baseTableViewCell_openDatePicker: self];
        }
        return NO;
    }
    return YES;
}

- (BOOL)DHBTextFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)DHBTextFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if([_delegate respondsToSelector: @selector(baseTableViewCell_textEndEidt:textFiled:)]){
        [_delegate baseTableViewCell_textEndEidt: self textFiled: textField];
    }
}

#pragma mark - datapicker delegate
- (void)selectNOAction{
    if([_delegate respondsToSelector: @selector(baseTableViewCell_closeDatePicker)]){
        [_delegate baseTableViewCell_closeDatePicker];
    }
}

- (void)RBCustomDatePickerView:(RBCustomDatePickerView *)pickerView selectOkAction:(NSString *)selectTime{
    if([_delegate respondsToSelector: @selector(baseTableViewCell_DidOkButtonClick:selectTime:)]){
        [_delegate baseTableViewCell_DidOkButtonClick: pickerView selectTime: selectTime];
    }
}
@end
