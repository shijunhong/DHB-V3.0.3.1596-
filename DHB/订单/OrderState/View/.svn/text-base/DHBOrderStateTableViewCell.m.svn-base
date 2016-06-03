//
//  DHBOrderStateTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBOrderStateTableViewCell.h"

@implementation DHBOrderStateTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)updateViewWithDTO:(NSDictionary *)dto{
    [self.contentView removeAllSubviews];
//    [self.contentView setBackgroundColor:[UIColor grayColor]];
    self.circle_vi = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 14, 14)];
    self.circle_vi.layer.cornerRadius =CGRectGetHeight([self.circle_vi bounds])/2;
    self.circle_vi.layer.borderWidth = 1;
    self.circle_vi.layer.borderColor = HEX_RGB(0xf8f8f8).CGColor;
    [self.circle_vi setBackgroundColor:HEX_RGB(0xd7d7d7)];
    if ([[dto EncodeStringFromDicWithKey:@"is_red"] boolValue])
    {
        self.circle_vi.layer.borderColor = HEX_RGB(0xffc197).CGColor;
        self.circle_vi.backgroundColor = HEX_RGB(0xfe4600);
    }
    [self.contentView addSubview:self.circle_vi];
    self.circle_vi.sd_layout.topSpaceToView(self.contentView,0.0f).leftSpaceToView(self.contentView,15.0f).widthIs(14.0f).heightIs(14.0f);
    
    self.name_lb = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 35)];
    [self.name_lb setTextColor:[UIColor TextBlack_Color]];
    [self.name_lb setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.name_lb];
    self.name_lb.text = [dto EncodeStringFromDicWithKey:@"operation"];
    self.name_lb.sd_layout.topEqualToView(self.circle_vi).leftSpaceToView(self.circle_vi,15.0f).rightSpaceToView(self.contentView,15.0f).autoHeightRatio(0);
    
    self.time_lb = [[UILabel alloc]initWithFrame:CGRectMake(50, 45, 200, 20)];
    [self.time_lb setTextColor:[UIColor TextGray_Color]];
    [self.time_lb setFont:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:self.time_lb];
    self.time_lb.text = [dto EncodeStringFromDicWithKey:@"create_date"];
    self.time_lb.sd_layout.topSpaceToView(self.name_lb,15.0f).leftEqualToView(self.name_lb).rightEqualToView(self.name_lb).autoHeightRatio(0);
    
    if ([[dto EncodeStringFromDicWithKey:@"operation"] isEqualToString:@"创建订单"] || [[dto EncodeStringFromDicWithKey:@"operation"] isEqualToString:@"创建退货单"])
    {
        [self setupAutoHeightWithBottomView:self.time_lb bottomMargin:15.0f];
    }
    else
    {
        self.line_vi = [[UIView alloc] initWithFrame:CGRectMake(21, 25, 1, 90)];
        [self.line_vi setBackgroundColor:HEX_RGB(0xd7d7d7)];
        [self.contentView addSubview:self.line_vi];
        self.line_vi.sd_layout.topSpaceToView(self.circle_vi,0.0f).centerXEqualToView(self.circle_vi).widthIs(1.0f).heightIs(90.0f);
        [self setupAutoHeightWithBottomView:self.line_vi bottomMargin:0.0f];
    }
}

//-(void)drawRect:(CGRect)rect{

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor (context, 254,70,0, 1.0);
//    CGContextSetRGBStrokeColor(context,1,0,0,1.0);//画笔线的颜色
//    CGContextSetLineWidth(context, 1.0);//线的宽度
//    CGContextAddArc(context, 15, 15, 5, 0, 2*M_PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//    
//    CGPoint aPoints[2];//坐标点
//    aPoints[0] =CGPointMake(15, 22);//坐标1
//    aPoints[1] =CGPointMake(15, 80);//坐标2
//    CGContextSetRGBStrokeColor(context,255/117,255/117,255/117,1.0);//画笔线的颜色
//    //points[]坐标数组，和count大小
//    CGContextAddLines(context, aPoints, 2);//添加线
//    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//}
@end
