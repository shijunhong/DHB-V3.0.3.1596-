//
//  DHBProductView_2.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/27.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define IMAGEVIEW_WIDTH 125.0F
#define MARGIN_TOP 6.0F
#define NAMELABEL_HEIGHT 32.0F
#define WHOLELABEL_HEIGHT 15.0F
#import "DHBProductView_2.h"

@implementation DHBProductView_2{
    NSMutableArray *_products;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //中间画线
        UIView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.centerX, 0, 0.5, self.height)];
        [centerImageView setBackgroundColor:[UIColor CellLine_Color]];
        [self addSubview:centerImageView];
        TT_RELEASE_SAFELY(centerImageView);
    }
    return self;
}

- (void)updateViewWithDTO:(NSMutableArray *)products{
    _products = products;
    UIView *left_v = [self initProductView:[products safeObjectAtIndex:0] withFrame:CGRectMake(0, 0, self.width/2, self.height)];
    UITapGestureRecognizer *tap_l = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap_l:)];
    [left_v addGestureRecognizer:tap_l];
    [self addSubview:left_v];
    TT_RELEASE_SAFELY(left_v);
    
    if ([products safeObjectAtIndex:1])
    {
        UIView *right_v = [self initProductView:[products safeObjectAtIndex:1] withFrame:CGRectMake(self.centerX, 0, self.width/2, self.height)];
        UITapGestureRecognizer *tap_r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap_r:)];
        [right_v addGestureRecognizer:tap_r];
        [self addSubview:right_v];
        TT_RELEASE_SAFELY(right_v);
    }
}

-(UIView *)initProductView:(GoodsModuleDTO*)product withFrame:(CGRect)frame{
    UIView *productView = [[UIView alloc] initWithFrame:frame];
    productView.userInteractionEnabled = YES;
    EGOImageViewEx *imageView= [[EGOImageViewEx alloc] init];
    imageView.left = (SCREEN_WIDTH - 2 * IMAGEVIEW_WIDTH - 1.0F) / 4.0F;
    imageView.top = (frame.size.height - 2 * MARGIN_TOP - IMAGEVIEW_WIDTH - NAMELABEL_HEIGHT - WHOLELABEL_HEIGHT) / 2.0f;
    imageView.size = CGSizeMake(IMAGEVIEW_WIDTH, IMAGEVIEW_WIDTH);
    imageView.userInteractionEnabled = YES;
    imageView.placeholderImage = [UIImage imageNamed: @"invalid2"];
    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", product.goods_picture]];
    imageView.userInteractionEnabled = YES;
    [productView addSubview:imageView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom + MARGIN_TOP, imageView.width, NAMELABEL_HEIGHT)];
    [name setFont:[UIFont systemFontOfSize:13]];
    [name setTextColor:[UIColor TextBlack_Color]];
    [name setAdjustsFontSizeToFitWidth:NO];
    [name setNumberOfLines:2];
    name.lineBreakMode = NSLineBreakByWordWrapping;
    [name setText:product.goods_name];
    [productView addSubview:name];
    
    TTTAttributedLabel *whole_lb =[[TTTAttributedLabel alloc] initWithFrame:CGRectMake(name.left, name.bottom + MARGIN_TOP, imageView.width, WHOLELABEL_HEIGHT)];
    whole_lb.font = [UIFont systemFontOfSize:15];
    whole_lb.lineBreakMode = NSLineBreakByWordWrapping;
    [whole_lb setTextColor:[UIColor TextRed_Color]];
    [whole_lb setText:[NSString stringWithFormat:@"%@%.2lf/%@",L(@"￥"),[product.whole_price doubleValue],product.base_units] afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange grayRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"/%@",product.base_units] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:11];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:RMBRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    [productView addSubview:whole_lb];
    
    TT_RELEASE_SAFELY(imageView);
    TT_RELEASE_SAFELY(name);
    TT_RELEASE_SAFELY(whole_lb);
    return productView;
}

-(void)btnAction:(UIButton*)sender{
    NSLog(@"加入购物车");
}

- (void)handleTap_l:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(productSelected_2DTO:)])
    {
        [self.delegate productSelected_2DTO:_products[0]];
    }
}

- (void)handleTap_r:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(productSelected_2DTO:)])
    {
        [self.delegate productSelected_2DTO:_products[1]];
    }
}
@end
