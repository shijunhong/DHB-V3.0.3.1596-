//
//  DHBMiaoShaView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/26.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBMiaoShaView.h"
@implementation DHBMiaoShaView{
    NSDate *_time;
    UILabel *_hour_lb;
    UILabel *_minute_lb;
    UILabel *_second_lb;
    ActivityModuleDTO *_activity;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_hour_lb);
    TT_RELEASE_SAFELY(_minute_lb);
    TT_RELEASE_SAFELY(_second_lb);
}

- (void)updateViewWithDTO:(ActivityModuleDTO *)dto{
    _activity = dto;
    //图片
    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(self.width/2-15-SCREEN_WIDTH/3.2, self.height-15-119, SCREEN_WIDTH/3.2, 119)];
    imageView.userInteractionEnabled = YES;
    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dto.image]];
    [self addSubview:imageView];
    //名称
    UILabel *name_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+15, 15, 150, 15)];
    [name_lb setFont:[UIFont systemFontOfSize:14]];
    [name_lb setTextColor:HEX_RGB(0x333333)];
//    [name_lb setText:dto.name];
    [self addSubview:name_lb];
    //时间
//    _time = dto.overTime;
    _hour_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+15, 45, 15, 15)];
    [_hour_lb setFont:[UIFont systemFontOfSize:9]];
    [_hour_lb setTextAlignment:NSTextAlignmentCenter];
    [_hour_lb setTextColor:HEX_RGB(0x757575)];
    [self addSubview:_hour_lb];
    _minute_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+15+30, 45, 15, 15)];
    [_minute_lb setTextAlignment:NSTextAlignmentCenter];
    [_minute_lb setFont:[UIFont systemFontOfSize:9]];
    [_minute_lb setTextColor:HEX_RGB(0x757575)];
    [self addSubview:_minute_lb];
    _second_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+15+60, 45, 15, 15)];
    [_second_lb setTextAlignment:NSTextAlignmentCenter];
    [_second_lb setFont:[UIFont systemFontOfSize:9]];
    [_second_lb setTextColor:HEX_RGB(0x757575)];
    [self addSubview:_second_lb];
    [self timerFireMethod:nil];
    for (int i=0; i<3 ; i++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2+15+30*i, 45, 16, 16)];
//        [image setImage:[UIImage imageNamed:@"pic_daojishibg"]];
        [self addSubview:image];
        if (i<=1)
        {
            UILabel *maohao = [[UILabel alloc] initWithFrame:CGRectMake(image.right, 45, 15, 15)];
            [maohao setFont:[UIFont systemFontOfSize:9]];
            [maohao setTextAlignment:NSTextAlignmentCenter];
            [maohao setTextColor:HEX_RGB(0x757575)];
            [maohao setText:@":"];
            [self addSubview:maohao];
            TT_RELEASE_SAFELY(maohao);
        }
        TT_RELEASE_SAFELY(image);
    }
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    //金额
    UILabel *fuhao_lb =[[UILabel alloc] initWithFrame:CGRectMake(self.width/2+15, 75, 11, 15)];
    [fuhao_lb setFont:[UIFont systemFontOfSize:11]];
    [fuhao_lb setTextColor:HEX_RGB(0xff0000)];
    [fuhao_lb setText:@"￥"];
    [self addSubview:fuhao_lb];
    
//    CGRect nowPricesize  = [dto.price boundingRectWithSize:CGSizeMake(9999.0f,15) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
//    UILabel *nowPrice_lb = [[UILabel alloc] initWithFrame:CGRectMake(fuhao_lb.right, 75, nowPricesize.size.width+25, 15)];
//    [nowPrice_lb setFont:[UIFont systemFontOfSize:15]];
//    [nowPrice_lb setTextColor:HEX_RGB(0xff0000)];
//    [nowPrice_lb setText:[NSString stringWithFormat:@"%.2lf",[dto.price doubleValue]]];
//    [self addSubview:nowPrice_lb];
//    
//    CGRect oldPricesize  = [dto.oldPrice boundingRectWithSize:CGSizeMake(9999.0f,11) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName, nil] context:nil];
//    UILabel *oldPrice_lb = [[UILabel alloc] initWithFrame:CGRectMake(nowPrice_lb.right+5, 75, oldPricesize.size.width+45, 15)];
//    [oldPrice_lb setFont:[UIFont systemFontOfSize:11]];
//    [oldPrice_lb setTextColor:HEX_RGB(0x757575)];
//    [oldPrice_lb setText:[NSString stringWithFormat:@"原价:%.2lf",[dto.oldPrice doubleValue]]];
//    [self addSubview:oldPrice_lb];
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(oldPrice_lb.left-1, oldPrice_lb.centerY, oldPrice_lb.width, 1)];
//    [view setBackgroundColor:HEX_RGB(0x757575)];
//    [self addSubview:view];
//    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(fuhao_lb.centerX, nowPrice_lb.bottom+15, 100, 30)];
//    [btn setBackgroundImage:[UIImage imageNamed:@"bt1_normal"] forState:UIControlStateNormal];
//    [btn setTitle:@"马上抢" forState:UIControlStateNormal];
//    [btn setTitleColor:HEX_RGB(0xff0000) forState:UIControlStateNormal];
//    [btn setTitleColor:HEX_RGB(0xdb3e00) forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
    
//    TT_RELEASE_SAFELY(imageView);
//    TT_RELEASE_SAFELY(name_lb);
//    TT_RELEASE_SAFELY(fuhao_lb);
//    TT_RELEASE_SAFELY(nowPrice_lb);
//    TT_RELEASE_SAFELY(oldPrice_lb);
//    TT_RELEASE_SAFELY(view);
//    TT_RELEASE_SAFELY(btn);
}


//倒计时调用方法
- (void)timerFireMethod:(NSTimer *)theTimer
{
    int h =[NSDate intervalSinceNow:_time]/3600;
    int m =([NSDate intervalSinceNow:_time]-h*3600)/60;
    int s =([NSDate intervalSinceNow:_time]-h*3600) % 60;
    
    [_hour_lb setText:[NSString stringWithFormat:@"%.2d",h]];
    [_minute_lb setText:[NSString stringWithFormat:@"%.2d",m]];
    [_second_lb setText:[NSString stringWithFormat:@"%.2d",s]];
}


-(void)btnAction:(UIButton*)sender{
//    NSLog(@"马上抢 %@",_activity.name);
}
@end
