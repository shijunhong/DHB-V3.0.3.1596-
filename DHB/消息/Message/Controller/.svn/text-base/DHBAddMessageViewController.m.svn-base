//
//  DHBAddMessageViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddMessageViewController.h"
#import "DHBAlertView.h"

@interface DHBAddMessageViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UIView *content_vi;
@property(nonatomic,strong)DHBTextView *content_tv;
@property(nonatomic,strong)UILabel *textnum_lb;
@property(nonatomic,strong)DHBButton *submit_btn;
@end

@implementation DHBAddMessageViewController

#pragma mark -init
- (DHBAddMessageService *)mainService{
    if(!_mainService){
        _mainService = [[DHBAddMessageService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}


-(UIView *)content_vi{
    if (!_content_vi)
    {
        _content_vi = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 281)];
        [_content_vi setBackgroundColor:[UIColor whiteColor]];
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGr.cancelsTouchesInView = NO;
        [_content_vi addGestureRecognizer:tapGr];
        UIView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _content_vi.height - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomView setBackgroundColor:HEX_RGB(0xdcdcdc)];
        [_content_vi addSubview:bottomView];
        TT_RELEASE_SAFELY(bottomView);
    }
    return _content_vi;
}

-(DHBTextView *)content_tv{
    if (!_content_tv) {
        _content_tv = [[DHBTextView alloc] initWithFrame:CGRectMake(15, 15, self.content_vi.frame.size.width-30, 185)];
        _content_tv.layer.borderWidth = 1.0f;
        _content_tv.layer.borderColor = [UIColor InputBorder_Color].CGColor;
        _content_tv.layer.cornerRadius = 2.5;
        [_content_tv setFont:[UIFont systemFontOfSize:14]];
        [_content_tv setTextColor:[UIColor TextBlack_Color]];
        _content_tv.placeholder = @"请输入您给供货商的留言内容";
        _content_tv.placeholderColor = HEX_RGB(0x757575);
        _content_tv.tintColor = [UIColor TextRed_Color];
        _content_tv.delegate = self;
    }
    return _content_tv;
}

-(UILabel *)textnum_lb{
    if (!_textnum_lb)
    {
        _textnum_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.content_vi.frame.size.width-15-60, self.content_tv.bottom, 60.0f, 21)];
        _textnum_lb.font = [UIFont systemFontOfSize:12];
        _textnum_lb.textAlignment = NSTextAlignmentRight;
        _textnum_lb.textColor = [UIColor TextGray_Color];
        _textnum_lb.text = @"0/200";
    }
    return _textnum_lb;
}

-(DHBButton *)submit_btn{
    if (!_submit_btn)
    {
        _submit_btn = [[DHBButton alloc] initWithFrame:CGRectMake(15, self.content_vi.bottom+15, self.view.frame.size.width-30, DEFAULT_BUTTON_HEIGHT) style:kDHBButton_StyleValue3];
        [_submit_btn setTitle:@"确定" forState:UIControlStateNormal];
        [_submit_btn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submit_btn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showBack:YES];
    [self showTabBar: NO];
    [self showTitel:YES andTitelText: (self.titleStr ? self.titleStr : @"留言咨询")];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.content_vi];
    [self.content_vi addSubview:self.content_tv];
    if(self.is_feedback){
        [self.content_tv setPlaceholder: @"欢迎您反馈：\n对产品使用的方便性、功能建议、不满足你的业务特性与管理要求、产生疑惑、困扰、看不懂的地方等。"];
    }
    [self.content_vi addSubview:self.textnum_lb];
    [self.view addSubview:self.submit_btn];
}

//-(void)backAction:(UIButton *)sender{
////    UIViewController *viewCtl = self.navigationController.viewControllers[1];
////    [self.navigationController popToViewController:viewCtl animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    ////(此处的长度，需要考虑用户使用粘贴的情况，所以需要通过之前的文本长度加上当前输入的文本长度来计算)
    NSInteger length = [text length] + [[textView text] length];
    if([text isEqualToString: @""] && length > 0){
        ///当用户使用删除键时,长度减去删除的长度
        length -= range.length;
    }
    if (length <= 200)
    {
        self.textnum_lb.text = [NSString stringWithFormat:@"%lu/200",(long)length];
    }
    return (length < 200 ? YES : NO);
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.content_tv resignFirstResponder];
}

-(void)submitAction:(UIButton*)sender{
    if([[self.content_tv text] length] > 0)
    {
        [self.mainService setContent: [self.content_tv text]];
        if (self.is_feedback)
        {
            if ([[self.content_tv text] length] <=4)
            {
                [[DHBAlertView sharedManagered] showMessage:@"请输入4-200字符"];
                [self.content_tv resignFirstResponder];
            }
            else
            {
                [self.mainService addFeedBack];
            }
        }
        else
        {
            [self.mainService addNewMessage];
        }
    }
    else
    {
        [[DHBAlertView sharedManagered] showMessage:@"请填写留言的内容"];
        [self.content_tv resignFirstResponder];
    }
}

#pragma mark - DHBAddMessageService_Delegate
- (void)addMessageService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.navigationController popViewControllerAnimated: YES];
    }
}
@end
