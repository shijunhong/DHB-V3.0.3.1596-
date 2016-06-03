//
//  DHBMessageListCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMessageListCell.h"

@implementation DHBMessageListCell

-(UIImageView *)img_vi{
    if (!_img_vi)
    {
        _img_vi =[[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 50.0f, 50.0f)];
        [self.contentView addSubview:_img_vi];
    }
    return _img_vi;
}

-(JSBadgeView *)tipView{
    if(!_tipView)
    {
//        //1.0版，以点表示未读的消息
//        _tipView = [[UIView alloc] initWithFrame:CGRectMake(self.img_vi.right - 8.0f / 2, self.img_vi.top - 8.0f / 3.0f, 8.0f, 8.0f)];
//        [_tipView.layer setCornerRadius: 8.0f / 2.0f];
//        [_tipView setBackgroundColor: [UIColor redColor]];
//        [_tipView setHidden:YES];
//        [self.contentView addSubview:_tipView];
        _tipView = [[JSBadgeView alloc] initWithParentView: self.img_vi alignment:JSBadgeViewAlignmentTopRight];
        [_tipView setBadgeBackgroundColor:[UIColor whiteColor]];
        [_tipView setBadgeMinWidth: 1.0f];
        [_tipView setBadgeTextFont:[UIFont systemFontOfSize: 12.0f]];
        [_tipView setBadgeStrokeWidth: 0.5f];
        [_tipView setBadgeTextColor:[UIColor TextRed_Color]];
    }
    return _tipView;
}

-(UILabel *)name_lb{
    if (!_name_lb)
    {
        _name_lb = [UILabel new];
        _name_lb.font = [UIFont systemFontOfSize:15.0f];
        _name_lb.textColor = [UIColor TextBlack_Color];
        [self.contentView addSubview:_name_lb];
    }
    return _name_lb;
}

-(UILabel *)content_lb{
    if (!_content_lb)
    {
        _content_lb = [UILabel new];
        _content_lb.font = [UIFont systemFontOfSize:14.0f];
        _content_lb.textColor = [UIColor TextGray_Color];
        [self.contentView addSubview:_content_lb];
    }
    return _content_lb;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if(self){
        self.arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];//22,22
        [self.contentView addSubview: self.arrow_img];
        [self.contentView initSectionView];
    }
    return self;
}

-(void)updateWithMsgData:(NSDictionary *)msg{
    UIImage *img = [UIImage imageNamed:[msg EncodeStringFromDicWithKey:@"img"]];
    self.img_vi.sd_layout.topSpaceToView(self.contentView,20.0f).leftSpaceToView(self.contentView,15.0f).widthIs(img.size.width).heightIs(img.size.height);
    self.img_vi.image = [UIImage imageNamed:[msg EncodeStringFromDicWithKey:@"img"]];
    
    if ([[msg EncodeNumberFromDicWithKey:@"count"] integerValue] > 0)
    {
        [self.tipView setHidden:NO];
        [self.tipView setBadgeText: [[msg EncodeNumberFromDicWithKey:@"count"] stringValue]];
    }
    
    self.arrow_img.sd_layout.centerYEqualToView(self.img_vi).rightSpaceToView(self.contentView,15.0f).widthIs(22.0f).heightIs(22.0f);
    
    NSString *name= [msg EncodeStringFromDicWithKey:@"title_value"];
    if ([name isEqualToString:@"order"] || [name isEqualToString:@"system"] || [name isEqualToString:@"message"])
    {
        self.name_lb.text = [msg EncodeStringFromDicWithKey:@"title"];
        self.name_lb.sd_layout.topSpaceToView(self.contentView,15.0f).leftSpaceToView(self.img_vi,15.0f).rightSpaceToView(self.arrow_img,8.0f).heightIs(20.0f);
        
        self.content_lb.text = [msg EncodeStringFromDicWithKey:@"content"];
        self.content_lb.sd_layout.topSpaceToView(self.name_lb,10.0f).leftEqualToView(self.name_lb).rightEqualToView(self.name_lb).heightIs(15.0f);
    }
    else
    {
        self.name_lb.text = [msg EncodeStringFromDicWithKey:@"title"];
        self.name_lb.textColor = [UIColor TextGray_Color];
        self.name_lb.sd_layout.centerYEqualToView(self.img_vi).leftSpaceToView(self.img_vi,15.0f).rightSpaceToView(self.arrow_img,8.0f).heightIs(20.0f);
    }
    
    [self setupAutoHeightWithBottomView:self.img_vi bottomMargin:20.0f+DEFAULT_SECTION_HEIGHT];
}

@end
