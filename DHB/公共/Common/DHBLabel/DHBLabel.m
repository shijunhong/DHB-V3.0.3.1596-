//
//  DHBLabel.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/29.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLabel.h"

@implementation DHBLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

-(void)setPriceText:(NSString*)text price:(NSString*)price $Fount:(UIFont*)font{
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange priceRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@%@",L(@"￥"),price] options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor Money_Color] range:priceRange];
        
        NSRange RMBRange = [[mutableAttributedString string] rangeOfString:L(@"￥") options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = font;
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:RMBRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
}

@end
