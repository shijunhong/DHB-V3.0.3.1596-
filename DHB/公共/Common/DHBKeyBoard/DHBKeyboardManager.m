//
//  DHBKeyboardManager.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/2/2.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBKeyboardManager.h"


@interface DHBKeyboardManager ()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIToolbar *toolBar;
@end

@implementation DHBKeyboardManager

- (UIToolbar *)createKeyboardToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnDown = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(didClickButtonDone)];
    [toolBar setItems:[[NSArray alloc]initWithObjects:spaceItem,btnDown, nil]];
    return toolBar;
}


-(UIView *)cleanMaskView{
    if (!_cleanMaskView)
    {
        _cleanMaskView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _cleanMaskView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickButtonDone)];
        [_cleanMaskView addGestureRecognizer:tap];
        //向上轻扫手势
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickButtonDone)];
        recognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [_cleanMaskView addGestureRecognizer:recognizer];
        
        //向下轻扫手势
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickButtonDone)];
        recognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [_cleanMaskView addGestureRecognizer:recognizer];
    }
    return _cleanMaskView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
        [notifCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [notifCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (DHBKeyboardManager *)sharedKeyboardManager{
    static DHBKeyboardManager *keyboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyboard = [[DHBKeyboardManager alloc]init];
        
    });
    return keyboard;
}


- (void)keyboardWillShow:(NSNotification *) notif
{
    CGFloat keyboardH = [notif.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    if (self.is_shwoCMview)
    {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.cleanMaskView];
        self.cleanMaskView.height = SCREEN_HEIGHT - keyboardH;
    }
}

- (void)keyboardWillHide:(NSNotification *) notif
{

    self.cleanMaskView.height = 0.0f;
}

- (void)didClickButtonDone
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (BOOL)validateNumber:(NSString*)str Format:(NSString*)format{
//    BOOL res = YES;
//    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int i = 0;
//    while (i < number.length) {
//        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//        if (range.length == 0) {
//            res = NO;
//            break;
//        }
//        i++;
//    }
//    return res;
    NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:format]invertedSet];
//    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
//    BOOL canChange = [str isEqualToString:filtered];
    
    return [strPredicate evaluateWithObject:str];
}

@end
