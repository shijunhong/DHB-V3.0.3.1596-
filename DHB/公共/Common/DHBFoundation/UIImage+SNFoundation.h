//
//  UIImage+SNFoundation.h
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SNFoundation)

+ (UIImage *)noCacheImageNamed:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)streImageNamed:(NSString *)imageName;
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;

- (UIImage *)stretched;
- (UIImage *)grayscale;
- (UIImage *)roundCornerImageWithRadius:(CGFloat)cornerRadius;

- (UIColor *)patternColor;

-(UIImage*)adjustImageWithSize:(CGSize)size; //改变图片大小
@end
