//
//  DHBTipView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/26/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define MAX_WIDTH 150.0f
#define MAX_HEIGHT 80.0f
#import "DHBTipView.h"
#import "DHBLabel.h"

@interface DHBTipView()
@property(nonatomic,strong)UIImageView *img_vi;
@property(nonatomic,strong)UILabel *msg_lb;
@end
@implementation DHBTipView

-(UIImageView *)img_vi{
    if (!_img_vi)
    {
        UIImage *img = [UIImage imageNamed:@"提示图标"];
        _img_vi = [[UIImageView alloc] initWithFrame:CGRectMake((MAX_WIDTH-img.size.width)/2.0f, 0.0f, img.size.width, img.size.height)];
        [_img_vi setImage:img];
    }
    return _img_vi;
}


-(UILabel *)msg_lb{
    if (!_msg_lb)
    {
        _msg_lb = [[UILabel alloc] init];
        [_msg_lb setTextColor:[UIColor whiteColor]];
        [_msg_lb setTextAlignment: NSTextAlignmentCenter];
        [_msg_lb setFont: [UIFont systemFontOfSize: 15.0f]];
    }
    return _msg_lb;
}

#pragma mark -
- (void)setup{
    [self setBackgroundColor: HEX_RGB(0x333333)];
    [self.layer setCornerRadius: 8.0f];
    [self.layer setMasksToBounds: YES];
    [self setAlpha: 0.1f];
    [self addSubview:self.img_vi];
    [self addSubview:self.msg_lb];
}

- (id)init{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

#pragma mark - public method
#pragma mark 显示提示信息
- (void)showInSuperView:(UIView *) parentView message:(NSString *) message{
    [parentView addSubview: self];
    [self setFrame: CGRectMake(0.0f, 0.0f, MAX_WIDTH, MAX_HEIGHT)];
    [self sizeToFit];
    [self setWidth: self.width + 30.0f];
    [self setHeight: self.height + 30.0f];
    [self setCenter: CGPointMake(SCREEN_WIDTH / 2.0f, SCREEN_HEIGHT / 2.0f)];
    
    
    self.img_vi.sd_layout.topSpaceToView(self,25.0f).centerXEqualToView(self).widthIs(self.img_vi.size.width).heightIs(self.img_vi.size.height);
    
    [self.msg_lb setText: message];
    self.msg_lb.sd_layout.topSpaceToView(self.img_vi,15.0f).leftSpaceToView(self,10.0f).rightSpaceToView(self,10.0f).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.msg_lb bottomMargin:25.0f];
    
    WS(weakSelf);
    [UIView animateWithDuration: 0.5f animations: ^{
        [weakSelf setAlpha: 0.8f];
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval: 2.0f target: self selector: @selector(dismiss) userInfo: nil repeats: NO];
    }];

}

#pragma mark 隐藏提示信息
- (void)dismiss{
    WS(weakSelf);
    [UIView animateWithDuration: 0.5f animations:^{
        [weakSelf setAlpha: 0.0f];
    }];
}
@end
