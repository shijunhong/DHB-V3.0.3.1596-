//
//  DHBSupplierListTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define LABEL_HEIGHT 20.0F
#define MARGIN 15.0f
#define ARROW_IMAGE_HEIGHT 22.0F
#import "DHBSupplierListTableViewCell.h"

@implementation DHBSupplierListTableViewCell
#pragma mark - getters and setters
- (UIView *)topLineView{
    if(!_topLineView){
        _topLineView = [[UIView alloc] init];
        [_topLineView setBackgroundColor: [UIColor CellLine_Color]];
    }
    return _topLineView;
}

- (UILabel *)supplierLabel{
    if(!_supplierLabel){
        _supplierLabel = [[UILabel alloc] init];
        [_supplierLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_supplierLabel setTextColor: [UIColor TextBlack_Color]];
    }
    return _supplierLabel;
}

- (UILabel *)statusLabel{
    if(!_statusLabel){
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setTextColor: [UIColor TextGray_Color]];
        [_statusLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_statusLabel setBackgroundColor: [UIColor UIViewBackGroundColor]];
    }
    return _statusLabel;
}

- (UIView *)bottomLineView{
    if(!_bottomLineView){
        _bottomLineView = [[UIView alloc] init];
        [_bottomLineView setBackgroundColor: [UIColor CellLine_Color]];
    }
    return _bottomLineView;
}

- (UIView *)supplierNameBgView{
    if(!_supplierNameBgView){
        _supplierNameBgView = [[UIView alloc] init];
    }
    return _supplierNameBgView;
}


- (UIView *)statusBgView{
    if(!_statusBgView){
        _statusBgView = [[UIView alloc] init];
        [_statusBgView setBackgroundColor: [UIColor UIViewBackGroundColor]];
    }
    return _statusBgView;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow"]];
        [_arrowImageView setContentMode: UIViewContentModeScaleAspectFit];
    }
    return _arrowImageView;
}

-(UIButton *)prompt_btn{
    if (!_prompt_btn)
    {
        _prompt_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16.0f, 16.0f)];
        _prompt_btn.layer.masksToBounds = YES;
        _prompt_btn.layer.cornerRadius = 16.0f/2.0f;
        _prompt_btn.backgroundColor = [UIColor redColor];
        [_prompt_btn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_prompt_btn setTitle:@"..." forState:UIControlStateNormal];
        [_prompt_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 7.0f, 0)];
    }
    return _prompt_btn;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview: self.supplierNameBgView];
        [self.contentView addSubview: self.supplierLabel];
        [self.contentView addSubview: self.arrowImageView];
        [self.contentView addSubview: self.prompt_btn];
        [self.contentView addSubview: self.bottomLineView];
        [self.contentView addSubview: self.statusBgView];
        [self.contentView addSubview: self.statusLabel];
        [self.contentView initLineisBottom:NO];
    }
    return self;
}


#pragma mark - 更新视图
/**
 *  根据数据模型更新视图
 *
 *  @param dto 供应商的数据模型
 */
- (void)updateViewWithDTO:(DHBSupplierModuleDTO *) dto CompanyID:(NSInteger)company_id{
    //供货商名称
    self.supplierLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN).rightSpaceToView(self.contentView, ARROW_IMAGE_HEIGHT + 2 * MARGIN).topSpaceToView(self.topLineView, LABEL_HEIGHT).autoHeightRatio(0);
    
    ///箭头
    self.arrowImageView.sd_layout.widthIs(ARROW_IMAGE_HEIGHT).heightIs(ARROW_IMAGE_HEIGHT).centerXIs(SCREEN_WIDTH - MARGIN - ARROW_IMAGE_HEIGHT / 2).topEqualToView(self.supplierLabel);
    
    if (company_id == [dto.company_id integerValue])
    {
        //消息
        [self.prompt_btn setHidden:NO];
        self.prompt_btn.sd_layout.centerYEqualToView(self.arrowImageView).rightSpaceToView(self.arrowImageView,5.0f).widthIs(16.0f).heightIs(16.0f);
    }
    else
    {
        [self.prompt_btn setHidden:YES];
    }
    
    ////底部分割线
    self.bottomLineView.sd_layout.leftSpaceToView(self.contentView, 0.0f).rightSpaceToView(self.contentView, 0.0f).topSpaceToView(self.supplierLabel, LABEL_HEIGHT).heightIs(DEFAULT_LINE_HEIGHT);
    
    self.supplierNameBgView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.topLineView, 0.0f).rightSpaceToView(self.contentView,0.0f).bottomSpaceToView(self.bottomLineView, 0.0f).widthIs(SCREEN_WIDTH);
    
    ///状态的背景
    self.statusBgView.sd_layout.leftSpaceToView(self.contentView, 0.0f).topSpaceToView(self.bottomLineView, 0.0f).rightSpaceToView(self.contentView,0.0f).widthIs(SCREEN_WIDTH).bottomSpaceToView(self.contentView, 0.0f);
    
    ///状态
    self.statusLabel.sd_layout.leftSpaceToView(self.contentView, MARGIN).topSpaceToView(self.bottomLineView, MARGIN / 2.0f).rightSpaceToView(self.contentView, MARGIN). autoHeightRatio(0);
    
    ////
    [self setupAutoHeightWithBottomView: self.statusLabel bottomMargin: MARGIN / 2.0F];
    
    ////绑定数据
    [self.statusLabel setText: [dto message]];
    [self.supplierLabel setText: [dto name]];
    if(![dto is_login]){
        [self.supplierNameBgView setBackgroundColor: HEX_RGB(0xe1e1e1)];
        [self.supplierLabel setTextColor: [UIColor TextGray_Color]];
    }
    else{
        [self.supplierNameBgView setBackgroundColor: [UIColor clearColor]];
        [self.supplierLabel setTextColor: [UIColor TextBlack_Color]];
    }
}
@end
