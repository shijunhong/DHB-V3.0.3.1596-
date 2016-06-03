//
//  DHBSearchAddressViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/6.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBSearchAddressViewController.h"
#import "DHBSelectAddressCell.h"
@interface DHBSearchAddressViewController ()<UITextFieldDelegate,AMapSearchDelegate>

@property(nonatomic,strong)UITextField *search_lb;
@property(nonatomic,strong)UIImageView *search_img;
@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation DHBSearchAddressViewController
static NSString *identifier = @"addressCell";

-(UIImageView *)search_img{
    if (!_search_img)
    {
        _search_img = [[UIImageView alloc] initWithFrame:CGRectMake(self.search_lb.left+5.0f, self.search_lb.top + 5.0f, 20.0f, 20.0f)];
        [_search_img setImage:[UIImage imageNamed:@"search_normal"]];
    }
    return _search_img;
}

-(UITextField *)search_lb{
    if (!_search_lb)
    {
        _search_lb = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6.4, 28, SCREEN_WIDTH-SCREEN_WIDTH/6.4-SCREEN_WIDTH/8, 30)];
        _search_lb.layer.masksToBounds = YES;
        [_search_lb setBackgroundColor:HEX_RGB(0xc63700)];
        _search_lb.layer.cornerRadius = 5;
        _search_lb.layer.borderWidth = 0.5;
        _search_lb.layer.borderColor = HEX_RGB(0xc63700).CGColor;
        _search_lb.font = [UIFont systemFontOfSize:14];
        _search_lb.textColor = [UIColor whiteColor];
        _search_lb.tintColor = [UIColor TextRed_Color];
        _search_lb.alpha = 0.9;
        _search_lb.placeholder = @"请输入相关地址名称";
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 0)];
        _search_lb.leftView = paddingView;
        _search_lb.leftViewMode = UITextFieldViewModeAlways;
        _search_lb.delegate = self;
        _search_lb.returnKeyType = UIReturnKeySearch;
        //监听输入框改变消息
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:_search_lb];
    }
    return _search_lb;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view.]
    [self showBack:YES];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"DHBSelectAddressCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self.search_lb becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.search_lb];
    [self.navigationView addSubview:self.search_img];
}

-(void)backAction:(UIButton *)sender{
    [self.search_lb resignFirstResponder];
    [super backAction:sender];
}

#pragma mark UITextFieldDelegate
-(void)textFiledEditChanged:(NSNotification *)obj{
    [self POISearch:self.search_lb.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"string = %@",textField.text);
    [self POISearch:textField.text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark POISearch
-(void)POISearch:(NSString*)searchKey{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = searchKey;
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma mark AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    self.data_arr = [NSMutableArray arrayWithArray:response.pois];
    [self.tableView reloadData];
}


#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBSelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    AMapPOI *poi = [self.data_arr safeObjectAtIndex:indexPath.row];
    cell.name_lb.text = poi.name;
    cell.address_lb.text = poi.address;
    return cell;
}

#pragma mark  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *poi = [self.data_arr safeObjectAtIndex:indexPath.row];
    [self.delegate searchAddressViewController:self AMapPOI:poi];
    [self.search_lb resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
