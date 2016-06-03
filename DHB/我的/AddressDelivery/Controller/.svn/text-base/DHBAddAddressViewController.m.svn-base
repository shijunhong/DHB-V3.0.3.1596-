//
//  DHBAddAddressViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/29.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBAddAddressViewController.h"
#import "DHBSearchAddressTableViewCell.h"
#import "DHBAddressSubmitRequest.h"
#import "DHBGaryTextField.h"
#import "DHBSelectAddressViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface DHBAddAddressViewController ()<UITextFieldDelegate,DHBSelectAddressViewControllerDelegate, DHBTextField_Delegate>

@property(nonatomic, strong)UIButton *submit_btn;

@property (strong, nonatomic) UIButton *addDefault_btn;

@property (weak, nonatomic) IBOutlet UIView *view_1;
@property (nonatomic,strong)DHBTextField *name_tf;

@property (weak, nonatomic) IBOutlet UIView *view_2;
@property (nonatomic,strong)DHBTextField *consignee_tf;

@property (weak, nonatomic) IBOutlet UIView *view_3;
@property (nonatomic,strong) DHBTextField *phone_tf;

@property (weak, nonatomic) IBOutlet UIView *view_4;
@property (nonatomic,strong)DHBTextField *address_tf;
@property (weak, nonatomic) IBOutlet UIButton *address_btn;

@property (nonatomic,strong)UIView *view_5;
@property (nonatomic,strong)UIButton *address_btn5;
@property (nonatomic,strong)DHBTextField *address_tf5;

@property(nonatomic,strong)AMapPOI *poi;
@end

@implementation DHBAddAddressViewController

#pragma mark - lazyload
-(AddressModuleDTO *)address{
    if (!_address)
    {
        _address = [[AddressModuleDTO alloc] init];
    }
    return _address;
}

-(UIButton *)addDefault_btn{
    if (!_addDefault_btn)
    {
        _addDefault_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-125-8, self.view_4.bottom+8, 125, 22)];
        [_addDefault_btn addTarget:self action:@selector(defaultAddAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addDefault_btn setTitle:@" 设为默认地址" forState:UIControlStateNormal];
        _addDefault_btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addDefault_btn setTitleColor:[UIColor TextGray_Color] forState:UIControlStateNormal];
        [_addDefault_btn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [_addDefault_btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        if ([self.address.is_default isEqualToString:@"T"])
        {
            [_addDefault_btn setSelected:YES];
        }
    }
    return _addDefault_btn;
}

-(DHBTextField *)name_tf{
    if (!_name_tf)
    {
        _name_tf = [[DHBTextField alloc] initWithFrame:CGRectMake(92, 15, SCREEN_WIDTH-92-15, 40) style: kDHBTextField_MaxInputStyle];
        _name_tf.placeholder = @"例:成都阿商信息技术有限公司";
        _name_tf.font = [UIFont systemFontOfSize:15];
        _name_tf.textColor = [UIColor TextBlack_Color];
        _name_tf.returnKeyType = UIReturnKeyDone;
        _name_tf.DHB_Delegate = self;
        _name_tf.text = self.address.consignee;
    }
    return _name_tf;
}

-(DHBTextField *)consignee_tf{
    if (!_consignee_tf)
    {
        _consignee_tf = [[DHBTextField alloc] initWithFrame:CGRectMake(92, 15, SCREEN_WIDTH-92-15, 40) style: kDHBTextField_MaxInputStyle];
        _consignee_tf.placeholder = @"请填写收货人姓名，例：蒋先生";
        _consignee_tf.font = [UIFont systemFontOfSize:15];
        _consignee_tf.textColor = [UIColor TextBlack_Color];
        _consignee_tf.returnKeyType = UIReturnKeyDone;
        _consignee_tf.DHB_Delegate = self;
        _consignee_tf.text = self.address.contact;
    }
    return _consignee_tf;
}

-(DHBTextField *)phone_tf{
    if (!_phone_tf)
    {
        _phone_tf = [[DHBTextField alloc] initWithFrame:CGRectMake(92, 15, SCREEN_WIDTH-92-15, 40) style: kDHBTextField_MaxInputStyle];
        _phone_tf.placeholder = @"请填写收货人电话号码";
        _phone_tf.font = [UIFont systemFontOfSize:15];
        _phone_tf.textColor = [UIColor TextBlack_Color];
        _phone_tf.returnKeyType = UIReturnKeyDone;
        _phone_tf.tag = 1;
        _phone_tf.DHB_Delegate = self;
        _phone_tf.text = self.address.phone;
        [_phone_tf setKeyboardType: UIKeyboardTypeNumberPad];
    }
    return _phone_tf;
}

-(DHBTextField *)address_tf{
    if (!_address_tf)
    {
        _address_tf = [[DHBTextField alloc] initWithFrame:CGRectMake(92, 15, SCREEN_WIDTH-92-15, 40) style: kDHBTextField_MaxInputStyle];
        _address_tf.placeholder = @"     点击选择";
        _address_tf.font = [UIFont systemFontOfSize:14];
        _address_tf.textColor = [UIColor TextBlack_Color];
        _address_tf.DHB_Delegate = self;
    }
    return _address_tf;
}


-(UIButton *)submit_btn{
    if (!_submit_btn)
    {
        _submit_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-18*2, 20.0f, 18*2, self.navigationView.height-20.0f)];
        [_submit_btn setTitle:@"确定" forState:UIControlStateNormal];
        [_submit_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submit_btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_submit_btn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submit_btn;
}


-(UIView *)view_5{
    if (!_view_5)
    {
        _view_5 = [[UIView alloc] initWithFrame:CGRectMake(0, self.view_4.top, SCREEN_WIDTH, 143)];
        [_view_5 setBackgroundColor:[UIColor whiteColor]];
        [_view_5 setHidden:YES];
        //顶部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [topImageView setBackgroundColor:[UIColor CellLine_Color]];
        [_view_5 addSubview:topImageView];
        //底部还需要划线
        UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _view_5.height - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
        [_view_5 addSubview:bottomImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 62, 21)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor TextBlack_Color];
        label.text = @"收货地址";
        [_view_5 addSubview:label];
        
        [_view_5 addSubview:self.address_btn5];
        [_view_5 addSubview:self.address_tf5];
    }
    return _view_5;
}

-(UIButton *)address_btn5{
    if (!_address_btn5)
    {
        _address_btn5 = [[UIButton alloc] initWithFrame:CGRectMake(92, 15, SCREEN_WIDTH-92-15, 58)];
        _address_btn5.titleLabel.font = [UIFont systemFontOfSize: 14];
        _address_btn5.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _address_btn5.titleLabel.numberOfLines = 0;
        [_address_btn5 setTitleColor:[UIColor TextBlack_Color] forState:UIControlStateNormal];
        _address_btn5.layer.borderWidth = 0.5;
        _address_btn5.layer.borderColor = HEX_RGB(0xdcdcdc).CGColor;
        _address_btn5.layer.cornerRadius = 2.5;
        [_address_btn5 addTarget:self action:@selector(selectAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [_address_btn5 setTitle:self.address.address forState:UIControlStateNormal];
        [_address_btn5 setTitleEdgeInsets: UIEdgeInsetsMake( 5.0f, 5.0f, 5.0f, 5.0f)];
    }
    return _address_btn5;
}

-(DHBTextField *)address_tf5{
    if (!_address_tf5) {
        _address_tf5 = [[DHBTextField alloc] initWithFrame:CGRectMake(15, self.address_btn.bottom+15, SCREEN_WIDTH-30, 40) style: kDHBTextField_MaxInputStyle];
        _address_tf5.placeholder = @"这里可补充详细地址，如小区 楼号，门牌号等";
        _address_tf5.font = [UIFont systemFontOfSize:14];
        _address_tf5.textColor = [UIColor TextBlack_Color];
        _address_tf5.returnKeyType = UIReturnKeyDone;
        _address_tf5.tag = 5;
        _address_tf5.DHB_Delegate = self;
        _address_tf5.text = self.address.address_detail;
    }
    return _address_tf5;
}

#pragma mark - View lifecycle
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    if(![self.view_5 isHidden]){
        [self.address_tf5 becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack:YES];
    if (self.titName)
    {
        [self showTitel:YES andTitelText:self.titName];
    }
    else
    {
        [self showTitel:YES andTitelText:@"新增收货地址"];
    }
    [self.view_1 addSubview:self.name_tf];
    [self.view_2 addSubview:self.consignee_tf];
    [self.view_3 addSubview:self.phone_tf];
    [self.view_4 insertSubview:self.address_tf belowSubview:self.address_btn];
    [self.view addSubview:self.view_5];
    [self.view addSubview:self.addDefault_btn];
    if (self.address.address_id != 0 )
    {
        [self.view_4 setHidden:YES];
        self.addDefault_btn.top = self.view_5.bottom+8;
        [self.view_5 setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.submit_btn];
}



#pragma mark - DHBTextField delegate
#pragma mark 开始编辑输入框的时候，软键盘出现，执行此事件
-(void)DHBTextFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 5){
        WS(weakSelf);
        [UIView animateWithDuration: 0.3f animations:^{
            weakSelf.view.transform = CGAffineTransformMakeTranslation(0, -180.0f);
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - 当用户按下return键或者按回车键，keyboard消失
-(BOOL)DHBTextFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)DHBTextFieldDidEndEditing:(UITextField *)textField
{
    WS(weakSelf);
    [UIView animateWithDuration: 0.3f animations:^{
        weakSelf.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}


- (BOOL)DHBTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""])
    {
        if (textField == self.phone_tf)//电话号码
        {
            if (range.location >= 11) return NO;//小于11位数
            return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"] evaluateWithObject:string];//只能输入0-9数字
        }else if (textField == self.name_tf || textField == self.consignee_tf)//公司名称，收货人
        {
            if (range.location >= 30) return NO;
        }
        else if (textField == self.address_tf5)//详细地址
        {
            if (range.location >= 50) return NO;
        }
    }
    return YES;
}

#pragma mark ButtonAction
- (void)defaultAddAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (IBAction)selectAddressAction:(UIButton *)sender {
    DHBSelectAddressViewController *selectAddress = [[DHBSelectAddressViewController alloc] init];
    selectAddress.delegate = self;
    [self.navigationController pushViewController:selectAddress animated:YES];
}

- (void)submitAction:(UIButton *)sender {
    self.address.phone = self.phone_tf.text;
    self.address.consignee = self.name_tf.text;
    self.address.contact = self.consignee_tf.text;
    self.address.address = self.address_btn5.titleLabel.text;
    self.address.address_detail = self.address_tf5.text;
    self.address.latitude = self.poi.location.latitude*1e6;
    self.address.longitude = self.poi.location.longitude*1e6;
    self.address.city_id = self.poi.citycode;
    self.address.district_id = self.poi.adcode;
    self.address.is_default = self.addDefault_btn.selected?@"T":@"F";
    if ([self checkValue])
    {
        DHBAddressSubmitRequest *request = [[DHBAddressSubmitRequest alloc] init];
//        request.hidden_effect =YES;
        request.delete_flag = @"F";
        request.address = self.address;
        WS(weakSelf);
        [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
            NSDictionary *dic = (NSDictionary*)data;
            if ([[dic objectForKey:@"code"] intValue] ==100){
                if ([[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 1)
                {
                    NSLog(@"is_success = %@",[[dic objectForKey:@"data"] objectForKey:@"is_success"]);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
            
        } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
            
        }];
    }
}

-(BOOL)checkValue{
    BOOL check = YES;
    NSString *errormsg = [NSString string];
    if (!self.address.phone||[self.address.phone isEqualToString:@""])
    {
        errormsg = @"请填写电话号码";
        check = NO;
    }
    else if (!self.address.contact||[self.address.contact isEqualToString:@""])
    {
        errormsg = @"请填写收货人";
        check = NO;
    }
    else if (!self.address.address||[self.address.address isEqualToString:@""])
    {
        errormsg = @"请填写地址";
        check = NO;
    }
    else if (self.address.latitude == 0 && self.address.longitude == 0 && self.address.address_id == 0)
    {
        errormsg = @"选择地址";
        check = NO;
    }
    if (!check)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:errormsg delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    return check;
}


#pragma mark DHBSelectAddressViewControllerDelegate
-(void)selectAddressViewController:(DHBSelectAddressViewController *)controller AMapPOI:(AMapPOI *)poi{
    self.poi = poi;
    [self.view_5 setHidden:NO];
    self.addDefault_btn.top = self.view_5.bottom+8;
    [self.view_4 setHidden:YES];
    NSLog(@"省 = %@ 区=%@ 区编码=%@ citycode = %@",self.poi.province ,self.poi.district,self.poi.adcode,self.poi.citycode);
    [self.address_btn5 setTitle:[NSString stringWithFormat:@"%@%@%@%@%@",self.poi.province,self.poi.city,self.poi.district,self.poi.address,self.poi.name] forState:UIControlStateNormal];
}

#pragma mark - back
- (void)backAction:(UIButton *)sender{
    CustomIOSAlertView *alert = [[CustomIOSAlertView alloc] init];
    // 添加CustomIOSAlertView 的显示视图
    UILabel *tipView = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, 0, SCREEN_WIDTH- 45.0f * 2 * Multiple, 80 * Multiple)];
    [tipView setText: L(@"确认要放弃此次编辑？")];
    [tipView setFont:[UIFont systemFontOfSize: 14.0f]];
    [tipView setTextAlignment: NSTextAlignmentCenter];
    [tipView setTextColor: [UIColor TextGray_Color]];
    [alert setContainerView: tipView];
    // 添加按钮
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@{@"name":L(@"取消"),@"type":@(kDHBButton_StyleValue4)},@{@"name":L(@"确定"),@"type":@(kDHBButton_StyleValue3)}, nil]];
    WS(weakSelf);
    [alert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1)
        {
            [weakSelf.navigationController popViewControllerAnimated: YES];
        }
        else
            [alertView close];
    }];
    
    [alert setUseMotionEffects:true];
    [alert show];

}
@end
