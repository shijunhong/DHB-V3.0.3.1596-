//
//  UINavigationController+DHBNavController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "UINavigationController+DHBNavController.h"

@implementation UINavigationController (DHBNavController)


- (void)pushAnimationDidStop {
}

- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}

@end
