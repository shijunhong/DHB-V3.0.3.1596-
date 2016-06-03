//
//  ReturnedSubmitViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ReturnedSubmitViewController.h"
#import "OrderModuleDTO.h"
#import "ReturnSubmitGoodsTableViewCell.h"
#import "ReturnSubmitTableViewCell.h"
#import "DHBReturnedSubmitRequest.h"
#import "ReturnsOrderListViewController.h"
#import "DHBUploadImage.h"
#import "AppDelegate.h"

@interface ReturnedSubmitViewController ()<UITableViewDataSource,UITableViewDelegate,ReturnSubmitTableViewCellDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSMutableArray *image_arr;
//底部视图
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)TTTAttributedLabel *total_lb;
@property(nonatomic,strong)UILabel *goods_lb;
@property(nonatomic, retain) DHBButton *submitButton;

//上传图片信息
@property(nonatomic,strong)NSString *content_id;
@end

@implementation ReturnedSubmitViewController
static NSString *identifier_1 = @"cell";
static NSString *identifier_2 = @"returnGoodsCell";
#pragma mark - lazyload
-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
        [_tableView setBackgroundColor:[UIColor UIViewBackGroundColor]];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


-(ReturnedSubmitService *)service{
    if (!_service)
    {
        _service = [[ReturnedSubmitService alloc] init];
    }
    return _service;
}

-(NSMutableArray *)image_arr{
    if (!_image_arr)
    {
        _image_arr = [NSMutableArray array];
    }
    return _image_arr;
}

- (DHBButton *)submitButton{
    if(!_submitButton){
        _submitButton = [[DHBButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150*Multiple, 0, 150*Multiple, 50) style:kDHBButton_StyleValue1];
        [_submitButton setBackgroundColor:[UIColor BtnSelectBorder_Color]];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(addSubimtAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(UIView *)bottomView{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        [_bottomView setBackgroundColor:HEX_RGB(0xf2f2f2)];
        //顶部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
        [topImageView setBackgroundColor:HEX_RGB(0xc5c5c5)];
        [_bottomView addSubview:topImageView];
        
        [_bottomView addSubview:self.submitButton];
    }
    return _bottomView;
}

-(TTTAttributedLabel *)total_lb{
    if (!_total_lb)
    {
        _total_lb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15*Multiple, 7, 150, 15)];
        _total_lb.font = [UIFont systemFontOfSize:15];
        [_total_lb setTextColor:[UIColor TextRed_Color]];
        [_total_lb setText:@"合计："];
        [_total_lb setText:[NSString stringWithFormat:@"合计：%@%@",L(@"￥"),self.service.totalPrice] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            
            NSRange grayRange = [[mutableAttributedString string] rangeOfString:@"合计：" options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor TextGray_Color] range:grayRange];
            
            NSRange sRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"合计：%@",L(@"￥")] options:NSCaseInsensitiveSearch];
            UIFont *RMBFont = [UIFont systemFontOfSize:13];
            CTFontRef RMBfont = CTFontCreateWithName((__bridge CFStringRef)RMBFont.fontName, RMBFont.pointSize, NULL);
            if (RMBfont) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)RMBfont range:sRange];
                CFRelease(RMBfont);
            }
            return mutableAttributedString;
        }];
    }
    return _total_lb;
}

-(UILabel *)goods_lb{
    if (!_goods_lb)
    {
        _goods_lb = [[UILabel alloc] initWithFrame:CGRectMake(15*Multiple, 29, 150, 15)];
        _goods_lb.font = [UIFont systemFontOfSize:13];
        [_goods_lb setTextColor:[UIColor TextGray_Color]];
        [_goods_lb setText:@"商品："];
        [self.bottomView addSubview:_goods_lb];
    }
    return _goods_lb;
}

#pragma mark - View lifecycle

- (id)init{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(goodsNumberShouldBeginEditing:)
                                                     name:@"goodsNumberShouldBeginEditing"
                                                   object:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabBar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"提交申请"];
    [self.view addSubview:self.tableView];
    UINib *nib = [UINib nibWithNibName:@"ReturnSubmitGoodsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier_2];
    nib = [UINib nibWithNibName:@"ReturnSubmitTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier_1];
    [self.view addSubview:self.bottomView];
    self.goods_lb.text = [NSString stringWithFormat:@"商品：%ld",(long)[self.service.goodsnum integerValue]];
    [self.bottomView addSubview:self.total_lb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TreeView UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return [self.service.goods_arr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        ReturnSubmitTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier_1];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mark_lb.text = self.remark;
        cell.price_lb.text = [NSString stringWithFormat:@"%@%@",L(@"￥"),self.service.totalPrice];
        [cell updateCellData:self.image_arr];
        return cell;
    }
    else
    {
        OrdersgoodsModuleDTO *goods= [self.service.goods_arr safeObjectAtIndex:indexPath.row];
        ReturnSubmitGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier_2];
        [cell updateCellData:goods];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark TreeView UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 278;
    }
    else
    {
        return 98;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1)
    {
        return 45;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1)
    {
        UIView *header_vi = [[UIView alloc] init];
        [header_vi setBackgroundColor:[UIColor whiteColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 45)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor TextBlack_Color];
        label.text = @"退货清单";
        [header_vi addSubview:label];
        //底部还需要划线
        UIView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45 - DEFAULT_LINE_HEIGHT, SCREEN_WIDTH, DEFAULT_LINE_HEIGHT)];
        [bottomImageView setBackgroundColor:[UIColor CellLine_Color]];
        [header_vi addSubview:bottomImageView];
        return header_vi;
    }
    return nil;
}

#pragma mark ButtonAction
-(void)addSubimtAction:(UIButton*)sender{
    [ParameterPublic sharedManagered].upload_arr = self.image_arr;
    
    DHBReturnedSubmitRequest *request = [[DHBReturnedSubmitRequest alloc] init];
    request.returnslist = self.service.goods_arr;
    request.orders_num = self.service.orders_num;
    request.returns_reason = self.remark;
    WS(weakSelf);
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if (isSuccess)
        {
            [[NSNotificationCenter defaultCenter] addObserver: weakSelf selector: @selector(uploadover) name: @"uploadover" object: nil];
            weakSelf.content_id = [[dic objectForKey:@"data"] EncodeStringFromDicWithKey:@"returns_id"];
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] uploadImageContent_table:@[@{@"content_id":weakSelf.content_id,@"content_table":@"business_returns"}]];
            [weakSelf.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:NO];
            ///提交成功马上跳转，禁用提交按钮
            [weakSelf.submitButton setEnabled: NO];
            /**
             *  当上传的图片的数量为0时，直接跳转至退货单列表
             */
            if([[ParameterPublic sharedManagered].upload_arr count] <= 0){
                ReturnsOrderListViewController *returnedGoodsList = [[ReturnsOrderListViewController alloc] init];
                [returnedGoodsList setIsComeFromSubmitVC: YES];
                [self.navigationController pushViewController:returnedGoodsList animated:YES];
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
    }];
}


#pragma mark ReturnSubmitTableViewCellDelegate
-(void)selectaddImgReturnSubmitTableViewCell:(ReturnSubmitTableViewCell *)cell{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张", @"从相册选取", nil];
    [actionSheet showInView:self.view];
}

-(void)deleteImgReturnSubmitTableViewCell:(ReturnSubmitTableViewCell *)cell{
    NSLog_Red(@"%@",self.image_arr);
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:NO];
}

-(void)returnSubmitTableViewCell:(ReturnSubmitTableViewCell*)cell textmark:(NSString*)mark{
    self.remark = mark;
}

#pragma mark - IBActionSheet/UIActionSheet Delegate Method

// the delegate method to receive notifications is exactly the same as the one for UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {//拍一张
        
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
    }
    else if (buttonIndex==1){//从相册选取
        
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WS(weakSelf);
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //压缩
        DHBUploadImage *image = [[DHBUploadImage alloc] init];
        image.image = [self compressedImgLess4M:selectedImage];
        image.status = NOUPLOAD;
        
        [weakSelf.image_arr addObject:image];
        [weakSelf.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:NO];
        
    }];
}


#pragma mark 压缩图片在4M以下
-(NSData *)compressedImgLess4M:(UIImage*)image{
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    int i = 1;
    while ([imageData length]>4000000 && i<100)
    {
        imageData = UIImageJPEGRepresentation(image,(double)(100-i)/100.0f);
        i++;
    }
    
    return imageData;
}


//取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

#pragma mark - goodsNumberShouldBeginEditing
-(void)goodsNumberShouldBeginEditing:(NSNotification *)note{
    firstResposer = note.object;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [firstResposer resignFirstResponder];
}

#pragma mark -
- (void)uploadover{
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:NO];
    NSInteger flag = 0;
    NSInteger succrss = 0;
    for(DHBUploadImage *image in self.image_arr){
        if(image.status == UPLOADED ||image.status == ERROR)
        {
            flag++;
            if (image.status == UPLOADED)
            {
                succrss++;
            }
        }
    }
    if(flag == [self.image_arr count]){
        //上传全部处理完成
        if (succrss == [self.image_arr count])
        {
            //全部成功
            [[[ParameterPublic sharedManagered] upload_arr] removeAllObjects];
            ////图片上传完毕
            [[NSNotificationCenter defaultCenter] removeObserver: self name: @"uploadover" object: nil];
            ////所有图片上传完毕再跳转
            ReturnsOrderListViewController *returnedGoodsList = [[ReturnsOrderListViewController alloc] init];
            [returnedGoodsList setIsComeFromSubmitVC: YES];
            [self.navigationController pushViewController:returnedGoodsList animated:YES];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] removeObserver: self name: @"uploadover" object: nil];
            //有部分上传失败
            UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"上传图片有部分上传失败哦，是否继续上传？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续上传",nil];
            msg.delegate = self;
            [msg show];
        }
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(uploadover) name: @"uploadover" object: nil];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] uploadImageContent_table:@[@{@"content_id":self.content_id,@"content_table":@"business_returns"}]];
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:NO];
    }
    else
    {
        [[[ParameterPublic sharedManagered] upload_arr] removeAllObjects];
        ////所有图片上传完毕再跳转
        ReturnsOrderListViewController *returnedGoodsList = [[ReturnsOrderListViewController alloc] init];
        [returnedGoodsList setIsComeFromSubmitVC: YES];
        [self.navigationController pushViewController:returnedGoodsList animated:YES];
    }
}
@end
