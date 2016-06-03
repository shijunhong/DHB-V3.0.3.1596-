//
//  DHBInvoiceViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/11.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBInvoiceViewController.h"
#import "DHBTextField.h"

@interface DHBInvoiceViewController ()<UITextFieldDelegate>
{
    CGFloat defaultTop;
}
@property (strong, nonatomic) UIView *invoceType_vi;

@property (strong, nonatomic) UIButton *bkInvice_btn;
@property (strong, nonatomic) IBOutlet UIView *ptInvice_vi;
@property (strong, nonatomic)  UIButton *ptInvice_btn;
@property (weak, nonatomic) IBOutlet DHBTextField *ptInvoice_title;
@property (weak, nonatomic) IBOutlet DHBTextField *ptInvoice_content;

@property (strong, nonatomic) IBOutlet UIView *zzInvice_vi;
@property (strong, nonatomic)  UIButton *zzInvice_btn;
@property (weak, nonatomic) IBOutlet DHBTextField *zzInvoice_title;
@property (weak, nonatomic) IBOutlet DHBTextField *zzInvoice_content;
@property (weak, nonatomic) IBOutlet DHBTextField *zzBank_address;
@property (weak, nonatomic) IBOutlet DHBTextField *zzBank_number;
@property (weak, nonatomic) IBOutlet DHBTextField *zz_number;

@property(nonatomic,assign)InvoiceType invoiceType;

@end

@implementation DHBInvoiceViewController

-(UIView *)invoceType_vi{
    if (!_invoceType_vi)
    {
        _invoceType_vi = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 128)];
        [_invoceType_vi setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_invoceType_vi];
    }
    return _invoceType_vi;
}




-(UIButton *)bkInvice_btn{
    if (!_bkInvice_btn)
    {
        _bkInvice_btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 200, 16)];
        [_bkInvice_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 5,0,_bkInvice_btn.width-16-5)];
        [_bkInvice_btn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [_bkInvice_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        [_bkInvice_btn setTitle:@"不需要发票" forState: UIControlStateNormal];
        [_bkInvice_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_bkInvice_btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_bkInvice_btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-70,0,0)];
        [_bkInvice_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_bkInvice_btn setTitleColor:[UIColor TextRed_Color] forState:UIControlStateSelected];
        _bkInvice_btn.tag = 1;
        [_bkInvice_btn addTarget:self action:@selector(invoiceTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bkInvice_btn;
}

-(UIButton *)ptInvice_btn{
    if (!_ptInvice_btn)
    {
        _ptInvice_btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 56, 200, 16)];
        [_ptInvice_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 5,0,_ptInvice_btn.width-16-5)];
        [_ptInvice_btn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [_ptInvice_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        [_ptInvice_btn setTitle:[NSString stringWithFormat:@"普通发票(%@%%税点)",self.userInformation.venders.pt_taxing_point] forState:UIControlStateNormal];
        [_ptInvice_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_ptInvice_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_ptInvice_btn setTitleColor:[UIColor TextRed_Color] forState:UIControlStateSelected];
        [_ptInvice_btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_ptInvice_btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-25,0 ,0)];
        _ptInvice_btn.tag = 2;
        [_ptInvice_btn addTarget:self action:@selector(invoiceTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ptInvice_btn;
}

-(UIButton *)zzInvice_btn{
    if (!_zzInvice_btn)
    {
        _zzInvice_btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 92, 200, 16)];
        [_zzInvice_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 5,0 ,_zzInvice_btn.width-16-5)];
        [_zzInvice_btn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [_zzInvice_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        [_zzInvice_btn setTitle:[NSString stringWithFormat:@"增值税发票(%@%%税点)",self.userInformation.venders.zz_taxing_point] forState:UIControlStateNormal];
        [_zzInvice_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_zzInvice_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10,0 ,0)];
        [_zzInvice_btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_zzInvice_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_zzInvice_btn setTitleColor:[UIColor TextRed_Color] forState:UIControlStateSelected];
        _zzInvice_btn.tag = 3;
        [_zzInvice_btn addTarget:self action:@selector(invoiceTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zzInvice_btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showTitel:YES andTitelText:@"发票类型"];
    [self showBack:YES];
    [self.invoceType_vi addSubview:self.bkInvice_btn];
    [self.invoceType_vi addSubview:self.ptInvice_btn];
    [self.invoceType_vi addSubview:self.zzInvice_btn];
    
    [self.ptInvice_vi setFrame:CGRectMake(0, self.invoceType_vi.bottom, SCREEN_WIDTH, 134)];
    [self.ptInvice_vi setHidden:YES];
    [self.view addSubview:self.ptInvice_vi];
    
    [self.zzInvice_vi setFrame:CGRectMake(0, self.invoceType_vi.bottom, SCREEN_WIDTH, 323)];
    [self.zzInvice_vi setHidden:YES];
    [self.view addSubview:self.zzInvice_vi];
    
    [self initView];
    
    defaultTop = self.zzInvice_vi.top;
    
    //
    [self adjustTextFiled];
}


-(void)initView{
    if (![[ParameterPublic sharedManagered] plain_invoice] && [[ParameterPublic sharedManagered] added_tax_invoice])//只显示增值税发票
    {
        ///调整视图位置
        [self.zzInvice_btn setFrame:CGRectMake(self.ptInvice_btn.frame.origin.x, self.ptInvice_btn.frame.origin.y, self.zzInvice_btn.frame.size.width, self.zzInvice_btn.frame.size.height)];
        self.invoceType_vi.height -= 40;
        self.zzInvice_vi.top -= 40;
        ///调整视图显示方式
        [self.ptInvice_btn setHidden:YES];
    }
    else if ([[ParameterPublic sharedManagered] plain_invoice] && ![[ParameterPublic sharedManagered] added_tax_invoice])//只显示普通发票
    {
        [self.zzInvice_btn setHidden:YES];
        [self.ptInvice_btn setHidden: NO];
        self.invoceType_vi.height -= 40;
        self.ptInvice_vi.top -= 40;
    }
    ////初始化默认值
    switch ([self.userInformation.venders invoice_type]) {
        case BK:{
            //不需要发票
            self.invoiceType = BK;
            [self.bkInvice_btn setSelected: YES];
            break;
        }
        case ZZ:{
            ///显示增值税的默认值
            [self.zzInvice_vi setHidden:NO];
            [self.zzInvice_btn setSelected: YES];
            self.invoiceType = ZZ;
            ///
            self.zzInvoice_title.text = self.userInformation.purchasers.invoice_title;
            self.zzInvoice_content.text = self.userInformation.purchasers.invoice_content;
            self.zzBank_address.text = self.userInformation.purchasers.bank;
            self.zzBank_number.text = self.userInformation.purchasers.bank_account;
            self.zz_number.text = self.userInformation.purchasers.taxpayer_number;
            break;
        }
        case PT:{
            ///普通发票
            [self.ptInvice_vi setHidden:NO];
            [self.ptInvice_btn setSelected: YES];
            self.invoiceType = PT;
            ///
            self.ptInvoice_title.text = self.userInformation.purchasers.invoice_title;
            self.ptInvoice_content.text = self.userInformation.purchasers.invoice_content;
            break;
        }
        default:
            break;
    }
    //底部还需要划线
    UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.invoceType_vi.height-0.5, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
    [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
    [self.invoceType_vi addSubview:bottomImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(UIButton *)sender{
    self.userInformation = nil;
    [super backAction:sender];
}

-(void)initTitelView{
    [super initTitelView];
    UIButton *sure_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-18*2, 32, 18*2, 22)];
    [sure_btn setTitle:@"确定" forState:UIControlStateNormal];
    [sure_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure_btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [sure_btn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:sure_btn];
}

- (void)invoiceTypeAction:(UIButton*)sender {
    for (NSObject *obj in [[sender superview] subviews])
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)obj;
            [btn setSelected:NO];
        }
    }
    [sender setSelected:YES];
    [self.ptInvice_vi setHidden:YES];
    [self.zzInvice_vi setHidden:YES];
    switch (sender.tag)
    {
        case 1:
            self.invoiceType = BK;
            break;
        case 2:
            [self.ptInvice_vi setHidden:NO];
            self.invoiceType = PT;
            self.ptInvoice_title.text = self.userInformation.purchasers.invoice_title;
            self.ptInvoice_content.text = self.userInformation.purchasers.invoice_content;
            break;
        case 3:
            [self.zzInvice_vi setHidden:NO];
            self.invoiceType = ZZ;
            self.zzInvoice_title.text = self.userInformation.purchasers.invoice_title;
            self.zzInvoice_content.text = self.userInformation.purchasers.invoice_content;
            self.zzBank_address.text = self.userInformation.purchasers.bank;
            self.zzBank_number.text = self.userInformation.purchasers.bank_account;
            self.zz_number.text = self.userInformation.purchasers.taxpayer_number;
            break;
        default:
            break;
    }
}

#pragma mark ButtonAction
-(void)sureAction:(UIButton*)sender{
    if (!self.userInformation)
    {
        self.userInformation = [[UserInformationModuleDTO alloc] init];
    }
    BOOL flag = NO;
    switch (self.invoiceType)
    {
        case BK:
            flag =[self BKInvoice];
            break;
        case PT:
            flag = [self PTInvoice];
            break;
        case ZZ:
            flag = [self ZZInvoice];
            break;
        default:
            break;
    }
    if (flag)
    {
        [self.delegate DHBInvoiceViewController:self userInformation:self.userInformation];
        [self.navigationController popViewControllerAnimated:YES ];
    }
}



-(BOOL)BKInvoice
{
    [self.userInformation.venders setInvoice_type:BK];
    return YES;
}
-(BOOL)PTInvoice
{
    if (!self.ptInvoice_title.text ||[self.ptInvoice_title.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入发票抬头！"];
        return NO;
    }
    if (!self.ptInvoice_content.text ||[self.ptInvoice_content.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入发票内容！"];
        return NO;
    }
    [self.userInformation.venders setInvoice_type:PT];
    self.userInformation.purchasers.invoice_title = self.ptInvoice_title.text;
    self.userInformation.purchasers.invoice_content = self.ptInvoice_content.text;
    return YES;
}

-(BOOL)ZZInvoice
{
    if (!self.zzInvoice_title.text ||[self.zzInvoice_title.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入发票抬头！"];
        return NO;
    }
    if (!self.zzInvoice_content.text ||[self.zzInvoice_content.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入发票内容！"];
        return NO;
    }
    if (!self.zzBank_address.text ||[self.zzBank_address.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入开户银行！"];
        return NO;
    }
    if (!self.zzBank_number.text ||[self.zzBank_number.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入银行账号！"];
        return NO;
    }
    if (!self.zz_number.text ||[self.zz_number.text isEqualToString:@""])
    {
        [[DHBAlertView sharedManagered] showMessage:@"请输入纳税人识别号！"];
        return NO;
    }
    [self.userInformation.venders setInvoice_type:ZZ];
    self.userInformation.purchasers.invoice_title = self.zzInvoice_title.text;
    self.userInformation.purchasers.invoice_content = self.zzInvoice_content.text;
    self.userInformation.purchasers.bank = self.zzBank_address.text;
    self.userInformation.purchasers.bank_account = self.zzBank_number.text;
    self.userInformation.purchasers.taxpayer_number = self.zz_number.text;
    return YES;
}

#pragma mark UITextFieldDelegate
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.zzInvice_vi.top  = defaultTop + (-50.0f * textField.tag);
    }];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.zzInvice_vi.top  = defaultTop;
    }];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""])
    {
        if (range.location >= 30) return NO;//不能超过30字
        if (textField == self.zzBank_number)//银行账号只能输入0-9数字
            return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"] evaluateWithObject:string];
    }
    return YES;
}

#pragma mark -

//输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField.tag == 1)
//    {
//        WS(weakSelf);
//        [UIView animateWithDuration:0.2 animations:^{
//            weakSelf.zzInvice_vi.top  = defaultTop;
//        }];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)adjustTextFiled{
    CGFloat margin = 8.0f;
    UIView *leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.ptInvoice_title setLeftView: leftView];
    [self.ptInvoice_title setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.ptInvoice_content setLeftView: leftView];
    [self.ptInvoice_content setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.zzInvoice_title setLeftView: leftView];
    [self.zzInvoice_title setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.zzInvoice_content setLeftView: leftView];
    [self.zzInvoice_content setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.zzBank_address setLeftView: leftView];
    [self.zzBank_address setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.zzBank_number setLeftView: leftView];
    [self.zzBank_number setLeftViewMode: UITextFieldViewModeAlways];
    
    leftView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, margin, margin)];
    [self.zz_number setLeftView: leftView];
    [self.zz_number setLeftViewMode: UITextFieldViewModeAlways];
}
@end
