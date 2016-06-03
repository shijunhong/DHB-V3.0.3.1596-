//
//  DHBQuicklyTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 3/10/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MARGIN 15.0f
#import "DHBQuicklyTableViewCell.h"

@implementation DHBQuicklyTableViewCell
#pragma mark - init
- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextColor: [UIColor TextBlack_Color]];
        [_nameLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _nameLabel;
}

- (UILabel *)descritionLabel{
    if(!_descritionLabel){
        _descritionLabel = [[UILabel alloc] init];
        [_descritionLabel setTextAlignment: NSTextAlignmentCenter];
        [_descritionLabel setFont: [UIFont systemFontOfSize: 12.0f]];
        [_descritionLabel setTextColor: [UIColor TextGray_Color]];
    }
    return _descritionLabel;
}

- (DHBButton *)operationButton{
    if(!_operationButton){
        _operationButton = [[DHBButton alloc] initStyle: kDHBButton_StyleValue3];
        [_operationButton addTarget: self action: @selector(opertaionButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_operationButton.titleLabel setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _operationButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
    }
    return self;
}

- (void)updateView:(BOOL) is_quckly_pay{
//    NSDictionary *tmpDictionary = [[dto moduleList] firstObject];
    [self.contentView addSubview: self.nameLabel];
    self.nameLabel.sd_layout.topSpaceToView(self.contentView, MARGIN).leftSpaceToView(self.contentView, MARGIN).heightIs(40.0f);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth: SCREEN_WIDTH - 100.0f];
    [self.nameLabel setText: @"快捷支付"];
    
    [self.contentView addSubview: self.operationButton];
    self.operationButton.sd_layout.topSpaceToView(self.contentView, MARGIN).widthIs(80.0f).heightIs(40.0f).rightSpaceToView(self.contentView, MARGIN);
    [self.operationButton setTitle: (is_quckly_pay ? @"登录" : @"未开通") forState: UIControlStateNormal];
    
    [self.contentView addSubview: self.descritionLabel];
    self.descritionLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN).topSpaceToView(self.nameLabel, MARGIN).rightSpaceToView(self.contentView, MARGIN).autoHeightRatio(0);
    [self.descritionLabel setText: (is_quckly_pay ? @"登录查看历史对账纪录、修改支付密码、绑卡、提升额度等服务" : @"您的供货商已开通快捷支付，立即开通体验快捷支付")];
    
    [self setupAutoHeightWithBottomView: self.descritionLabel bottomMargin: MARGIN];
}

- (void)opertaionButtonClick:(UIButton *)sender{
    if(self.onOperationButtonClick){
        self.onOperationButtonClick(sender);
    }
}
@end
