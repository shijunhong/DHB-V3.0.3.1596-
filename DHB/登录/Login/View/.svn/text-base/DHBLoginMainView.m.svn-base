//
//  DHBLoginMainView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/22.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define LOGO_MARGIN_TOP (SCREEN_HEIGHT > 480 ? 80.0f : 40.0f)
#define LOGO_MARGIN_LEFT Multiple*70.0f
#define LOGO_HEIGHT (SCREEN_HEIGHT > 480 ? 100.0f : 50.0f)
#define INPUT_MARGIN_TOP 48.0F
#define INPUT_MARGIN_LEFT Multiple*30.0f
#define INPUT_HEIGHT 45.0F
#define BUTTON_MARGIN_TOP 33.0F
#define BUTTON_HEIGHT 45.0F
#define REGISTER_MARGIN_TOP 20.0F
#define LABEL_HEIGHT 20.0F
#define FONT_SIZE 15.0F
#define FREEBUTTON_MARGIN_BOTTOM 80.0f
#define FREEBUTTON_HEIGHT 40.0f
#define FREEBUTTON_MARGIN_LEFT Multiple*100.0f
#define MOVE_ORIGIN_Y LOGO_MARGIN_TOP+LOGO_HEIGHT+INPUT_MARGIN_TOP-60.0f
#define RECORD_MARGIN_LEFT 45.0f
#define COMPANYBUTTON_HEIGHT 45.0f

#import "DHBLoginMainView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DHBLoginMainView

#pragma mark -init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if(self){
//        [self addMainBackgroundImageView];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addMaskView];
        [self addTopLogo];
        [self addOperateView];
//        [self addFreeButton];
        [self addCompanyButton];
    }
    return self;
}

#pragma mark 背景图
- (void)addMainBackgroundImageView
{
    if(!self.mainBackgroundView){
        self.mainBackgroundView = [[UIImageView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        [self.mainBackgroundView setImage: [UIImage imageNamed: @"lg_bg"]];
    }
    [self addSubview: self.mainBackgroundView];
}

#pragma mark 覆盖视图
- (void)addMaskView
{
    if(!self.maskView){
        self.maskView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        [self.maskView setBackgroundColor: [UIColor clearColor]];
        [self.maskView setAlpha: 0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(hiddenKeyBoard)];
        [self.maskView addGestureRecognizer: tap];
    }
    [self addSubview: self.maskView];
}

#pragma mark 顶部logo
- (void)addTopLogo
{
    if(!self.logoImageView){
        self.logoImageView = [[UIImageView alloc] initWithFrame: CGRectMake(LOGO_MARGIN_LEFT, LOGO_MARGIN_TOP, SCREEN_WIDTH - 2 * LOGO_MARGIN_LEFT, LOGO_HEIGHT)];
        [self.logoImageView setContentMode: UIViewContentModeScaleAspectFit];
        [self.logoImageView setImage: [UIImage imageNamed: @"logo"]];
    }
    [self addSubview: self.logoImageView];
}

#pragma mark 用户操作区域
- (void)addOperateView
{
    CGFloat origin_y = self.logoImageView.frame.origin.y + LOGO_HEIGHT + INPUT_MARGIN_TOP;
    if(!self.operateView){
        self.operateView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, SCREEN_WIDTH, SCREEN_HEIGHT - origin_y - FREEBUTTON_MARGIN_BOTTOM)];
        [self.operateView setBackgroundColor: [UIColor clearColor]];
    }
    [self addSubview: self.operateView];
    ///
    [self addInputView];
    [self addLogoButton];
    [self addRegisterButton];
    [self addFindPasswordButton];
}

#pragma mark 信息输入框
- (void)addInputView
{
    if(!self.accountInputView){
//        NSLog(@"%lf", INPUT_MARGIN_LEFT);
        self.accountInputView = [[DHBInputView alloc] initWithFrame: CGRectMake(INPUT_MARGIN_LEFT, 0.0f, SCREEN_WIDTH - 2 * INPUT_MARGIN_LEFT, INPUT_HEIGHT) InputType: kAccount_Input_Type];
        [self.accountInputView setDelegate: self];
        [self.accountInputView setPlaceholder: @"手机号码"];
        [self.accountInputView setKeyboardType: UIKeyboardTypeNumberPad];
        [self.accountInputView.mainTextFiled setTag: 0];
//        [self.accountInputView textFiledBecomeFirstResponder];
    }
    [self.operateView addSubview: self.accountInputView];
    
    CGFloat origin_y = self.accountInputView.frame.origin.y + INPUT_HEIGHT + 15.0f;
    if(!self.passwordInputView){
        self.passwordInputView = [[DHBInputView alloc] initWithFrame: CGRectMake(INPUT_MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * INPUT_MARGIN_LEFT, INPUT_HEIGHT) InputType: kPassWord_Input_Type];
        [self.passwordInputView setDelegate: self];
        [self.passwordInputView setSecureTextEntry: YES];
        [self.passwordInputView.mainTextFiled setTag: 1];
        [self.passwordInputView setPlaceholder: @"6-18位数字、字母"];
        [self.passwordInputView setKeyboardType: UIKeyboardTypeNamePhonePad];
    }
    [self.operateView addSubview: self.passwordInputView];
}

#pragma mark 登录按钮
- (void)addLogoButton
{
    CGFloat origin_y = self.passwordInputView.frame.origin.y + INPUT_HEIGHT + BUTTON_MARGIN_TOP;
    if(!self.loginButton){
        self.loginButton = [[DHBButton alloc] initWithFrame: CGRectMake(INPUT_MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * INPUT_MARGIN_LEFT, DEFAULT_BUTTON_HEIGHT) style: kDHBButton_StyleValue3];
        [self.loginButton setTitle: @"登录" forState: UIControlStateNormal];
        [self.loginButton addTarget: self action: @selector(loginButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self.operateView addSubview: self.loginButton];
}

#pragma mark 注册按钮
- (void)addRegisterButton
{
    CGFloat origin_y = self.loginButton.frame.origin.y + BUTTON_HEIGHT + REGISTER_MARGIN_TOP;
    if(!self.registerLabel){
        self.registerLabel = [[UILabel alloc] initWithFrame: CGRectMake(INPUT_MARGIN_LEFT, origin_y, (SCREEN_WIDTH - 2 * INPUT_MARGIN_LEFT) / 2.0f, LABEL_HEIGHT)];
        [self.registerLabel setText: @"注册"];
        [self.registerLabel setTextColor: HEX_RGB(0xb6aba5)];
        [self.registerLabel setFont: [UIFont boldSystemFontOfSize: FONT_SIZE]];
        [self.registerLabel setUserInteractionEnabled: YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(registerLabelClick:)];
        [self.registerLabel addGestureRecognizer: tap];
    }
    [self.operateView addSubview: self.registerLabel];
}

#pragma mark 找回密码按钮
- (void)addFindPasswordButton
{
    CGFloat origin_y = self.loginButton.frame.origin.y + BUTTON_HEIGHT + REGISTER_MARGIN_TOP;
    CGFloat origin_x = self.registerLabel.frame.size.width + self.registerLabel.origin.x;
    if(!self.findPasswordLabel){
        self.findPasswordLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, origin_y, (SCREEN_WIDTH - 2 * INPUT_MARGIN_LEFT) / 2.0f, LABEL_HEIGHT)];
        [self.findPasswordLabel setText: @"忘记密码"];
        [self.findPasswordLabel setTextAlignment: NSTextAlignmentRight];
        [self.findPasswordLabel setTextColor: HEX_RGB(0xb6aba5)];
        [self.findPasswordLabel setFont: [UIFont boldSystemFontOfSize: FONT_SIZE]];
        [self.findPasswordLabel setUserInteractionEnabled: YES];
        ///
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(findPasswordLabelClick:)];
        [self.findPasswordLabel addGestureRecognizer: tap];
    }
    [self.operateView addSubview: self.findPasswordLabel];
}

#pragma mark 免费体验按钮
- (void)addFreeButton
{
    CGFloat origin_y = SCREEN_HEIGHT - FREEBUTTON_MARGIN_BOTTOM;
    if(!self.freeButon){
        self.freeButon = [[UIButton alloc] initWithFrame: CGRectMake(FREEBUTTON_MARGIN_LEFT, origin_y, SCREEN_WIDTH - 2 * FREEBUTTON_MARGIN_LEFT, FREEBUTTON_HEIGHT)];
        [self.freeButon setTitle: @"免费体验>" forState: UIControlStateNormal];
        [self.freeButon setTitleColor: HEX_RGB(0xff5b1d) forState: UIControlStateNormal];
        [self.freeButon.titleLabel setFont: [UIFont boldSystemFontOfSize: 18.0f]];
        [self.freeButon addTarget: self action: @selector(freeButonDidClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: self.freeButon];
}

#pragma mark  公司链接
- (void)addCompanyButton{
    if(!self.companyButton){
        self.companyButton = [[UIButton alloc] initWithFrame: CGRectMake(0.0f, SCREEN_HEIGHT - COMPANYBUTTON_HEIGHT, SCREEN_WIDTH, COMPANYBUTTON_HEIGHT)];
        [self.companyButton setTitle: @"【订货宝】提供技术支持" forState: UIControlStateNormal];
        [self.companyButton setTitleColor: HEX_RGB(0xb6aba5) forState: UIControlStateNormal];
        [self.companyButton.titleLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [self.companyButton addTarget: self action: @selector(companyButtonClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    [self addSubview: self.companyButton];
}

#pragma mark -
#pragma mark 键盘消失
- (void)hiddenKeyBoard
{
    [firstResponser resignFirstResponder];
    if(isEdit){
        isEdit = NO;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"opacity"];
        [animation setDuration: 0.3f];
        [animation setFromValue: [NSNumber numberWithInteger: 0]];
        [animation setToValue: [NSNumber numberWithInteger: 1]];
        [animation setFillMode: kCAFillModeForwards];
        [animation setRemovedOnCompletion: NO];
        [self.logoImageView.layer addAnimation: animation forKey: @"opacity"];
        [UIView animateWithDuration: 0.3f animations: ^{
            CGRect frame = [self.operateView frame];
            frame.origin.y = LOGO_MARGIN_TOP + LOGO_HEIGHT + INPUT_MARGIN_TOP;
            [self.operateView setFrame: frame];
        }];
    }
    [self dismissLoginRecordView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyBoard];
}

#pragma mark - action
#pragma mark 免费体验
- (void)freeButonDidClick:(UIButton *)sender
{
    if([_delegate respondsToSelector: @selector(loginMainView_DidFreeButton:)]){
        [_delegate loginMainView_DidFreeButton: sender];
    }
}

#pragma mark 登录操作
- (void)loginButtonClick:(UIButton *)sender
{
    [self hiddenKeyBoard];
    if([_delegate respondsToSelector: @selector(loginMainView_DidLoginButtonClick:)]){
        [_delegate loginMainView_DidLoginButtonClick: sender];
    }
}

#pragma mark 选择历史的登录账号
- (void)selectLocalRecordDidClick:(UITapGestureRecognizer *) sender
{
    if([_delegate respondsToSelector: @selector(loginMainView_DidSelectRecordAtIndex:)]){
        [_delegate loginMainView_DidSelectRecordAtIndex: [sender.view tag]];
    }
}

#pragma mark 删除历史登录记录
- (void)deleteRecordButtonClick:(UIButton *) sender
{
    if([_delegate respondsToSelector: @selector(loginMainView_DidDeleteRecordButtonClick:)]){
        [_delegate loginMainView_DidDeleteRecordButtonClick: sender];
    }
}

#pragma mark DHBInputView delegate
- (void)inputView_DidTextFieldBeginEdit:(UITextField *)textField
{
    firstResponser = textField;
    if(!isEdit){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"opacity"];
        [animation setDuration: 0.3f];
        [animation setFromValue: [NSNumber numberWithInteger: 1]];
        [animation setToValue: [NSNumber numberWithInteger: 0]];
        [animation setFillMode: kCAFillModeForwards];
        [animation setRemovedOnCompletion: NO];
        [self.logoImageView.layer addAnimation: animation forKey: @"opacity"];
        [UIView animateWithDuration: 0.3f animations: ^{
            CGRect frame = [self.operateView frame];
            frame.origin.y = MOVE_ORIGIN_Y;
            [self.operateView setFrame: frame];
        } completion:^(BOOL finished){
            isEdit = YES;
        }];
    }
    if([textField tag] == 0){
        [self.accountInputView setHeightLight];
        [self.passwordInputView setLowLight];
    }
    else{
        [self.passwordInputView setHeightLight];
        [self.accountInputView setLowLight];
    }
}

- (void)inputView_DidSelectOnClick
{
    if([_delegate respondsToSelector: @selector(loginMainView_DidOpenRecordListButton)]){
        [_delegate loginMainView_DidOpenRecordListButton];
    }
}

#pragma mark - show LoginRecordView
- (void)showLoginRecordView:(NSArray *) dataArray
{
    self.accountInputView.mainTextFiled.textColor = HEX_RGB(0x999999);
    if(!self.loginRecordView){
        [self.operateView bringSubviewToFront: self.accountInputView];
        CGFloat origin_y = INPUT_HEIGHT;
        self.loginRecordView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, origin_y, self.accountInputView.frame.size.width, 0.0f)];
        [self.loginRecordView.layer setMasksToBounds: YES];
        [self.loginRecordView setBackgroundColor: HEX_RGB(0xf2f2f2)];
        [self.accountInputView addSubview: self.loginRecordView];
    }
    for(UIView *view in [self.loginRecordView subviews]){
        [view removeFromSuperview];
    }
    NSInteger flag = ([dataArray count] > 3 ? 3 : [dataArray count]);
    for(NSInteger i = 0; i < flag; i++){
        LoginRecordMouleDTO *record = [dataArray objectAtIndex: i];
        UIView *tmpView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, i * INPUT_HEIGHT, self.accountInputView.frame.size.width, INPUT_HEIGHT)];
        [self.loginRecordView addSubview: tmpView];
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame: CGRectMake(RECORD_MARGIN_LEFT, 0.0f, self.accountInputView.frame.size.width -RECORD_MARGIN_LEFT - INPUT_HEIGHT, INPUT_HEIGHT)];
        [tmpLabel setText: record.phone];
        [tmpLabel setFont: [UIFont systemFontOfSize: FONT_SIZE]];
        [tmpLabel setTextColor: HEX_RGB(0x333333)];
        [tmpLabel setTag: i];
        [tmpView addSubview: tmpLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(selectLocalRecordDidClick:)];
        [tmpLabel setUserInteractionEnabled: YES];
        [tmpLabel addGestureRecognizer: tap];
        //删除按钮
        UIButton *tmpButton = [[UIButton alloc] initWithFrame: CGRectMake(tmpView.frame.size.width - RECORD_MARGIN_LEFT, 0.0f, INPUT_HEIGHT, INPUT_HEIGHT)];
        [tmpButton setTag: i];
        [tmpButton addTarget: self action: @selector(deleteRecordButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [tmpButton setImage: [UIImage imageNamed: @"X"] forState: UIControlStateNormal];
        [tmpView addSubview: tmpButton];
        [tmpView initLineisBottom:YES];
    }
    [UIView animateWithDuration: 0.3f animations: ^{
        CGRect frame = [self.loginRecordView frame];
        frame.size.height = flag * INPUT_HEIGHT;
        [self.loginRecordView setFrame: frame];
        frame = [self.accountInputView frame];
        frame.size.height = (flag + 1) * INPUT_HEIGHT;
        [self.accountInputView setFrame: frame];
    }];
}

#pragma mark - dismiss LoginRecordView
- (void)dismissLoginRecordView
{
    self.accountInputView.mainTextFiled.textColor = [UIColor TextBlack_Color];
    [UIView animateWithDuration: 0.3f animations: ^{
        CGRect frame = [self.loginRecordView frame];
        frame.size.height = 0.0f;
        [self.loginRecordView setFrame: frame];
        frame = [self.accountInputView frame];
        frame.size.height = INPUT_HEIGHT;
        [self.accountInputView setFrame: frame];
    }];
}

#pragma mark - 设置登录账号
- (void)setLoginAccount:(NSString *)account
{
    [self.accountInputView setText: account];
}

#pragma mark - 找回密码
- (void)findPasswordLabelClick:(UITapGestureRecognizer *) tap{
    if([_delegate respondsToSelector: @selector(loginMainView_DidFindPasswordClick)]){
        [_delegate loginMainView_DidFindPasswordClick];
    }
}

- (void)registerLabelClick:(UITapGestureRecognizer *)tap{
    if([_delegate respondsToSelector: @selector(loginMainView_DidRegisterClick)]){
        [_delegate loginMainView_DidRegisterClick];
    }
}

#pragma mark - 公司链接
- (void)companyButtonClick:(UIButton *) button{
    if(_delegate && [_delegate respondsToSelector: @selector(loginMainView_DidCompanyLinkClick)]){
        [_delegate loginMainView_DidCompanyLinkClick];
    }
}
@end
