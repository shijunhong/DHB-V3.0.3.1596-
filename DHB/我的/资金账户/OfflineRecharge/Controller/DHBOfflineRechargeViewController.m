//
//  DHBOfflineRechargeViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOM_HEIGHT 50.0f
#import "DHBOfflineRechargeViewController.h"
#import "DHBOfflineSubmitRequest.h"
@implementation DHBOfflineRechargeViewController

#pragma mark - init
- (DHBOfflineRechargeService *)mainService{
    if(!_mainService){
        _mainService = [[DHBOfflineRechargeService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (DHBUploadImage *)uploadImage{
    if (!_uploadImage) {
        _uploadImage = [[DHBUploadImage alloc] init];
    }
    return _uploadImage;
}

#pragma mark -
- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, SCREEN_HEIGHT - Titel_HEIGHT - BOTTOM_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)];
        [_bottomView setBackgroundColor: [UIColor whiteColor]];
        [_bottomView.layer setBorderWidth: 1.0f];
        [_bottomView.layer setBorderColor: HEX_RGB(0xe8e8e8).CGColor];
        //金额标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(15.0f, 0.0f, 35.0f, BOTTOM_HEIGHT)];
        [titleLabel setText: @"金额:"];
        [titleLabel setTextColor: [UIColor TextBlack_Color]];
        [titleLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [titleLabel setTextAlignment: NSTextAlignmentLeft];
        [_bottomView addSubview: titleLabel];
        //金额
        CGFloat origin_x = titleLabel.frame.size.width + titleLabel.origin.x;
        UILabel *priceLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, _bottomView.size.width / 2.0f, BOTTOM_HEIGHT)];
        [priceLabel setText: [NSString stringWithFormat:@"%@%@",L(@"￥"),self.amount]];
        [priceLabel setTextColor: [UIColor Money_Color]];
        [priceLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [_bottomView addSubview: priceLabel];
        //按钮
        submitButton = [[DHBButton alloc] initWithFrame: CGRectMake(_bottomView.size.width * 2.0f / 3.0f, 0.0f, _bottomView.frame.size.width / 3.0f, BOTTOM_HEIGHT) style: kDHBButton_StyleValue1];
        [submitButton setTitle: @"提交" forState: UIControlStateNormal];
        [submitButton addTarget: self action: @selector(submitButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_bottomView addSubview: submitButton];
    }
    return _bottomView;
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"线下转账"];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(uploadover) name: @"uploadover" object: nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableView
    [self removeHeaderView];
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - BOTTOM_HEIGHT)];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView setDelegate:self];
    //请求数据
    [self.mainService queryData];
    //
    [self.view addSubview: self.bottomView];
}

#pragma mark - DHBOfflineRechargeService_Delegte
- (void)offlineRechargeService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        for (NSDictionary *bank in self.mainService.dataArray)
        {
            if ([[bank EncodeStringFromDicWithKey:@"is_default"] isEqualToString:@"T"])
            {
                _selectBank = bank;
            }
        }
        [self.tableView reloadData];
    }
}

#pragma mark - tabelView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.mainService floorsArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath section]];
    if([indexPath section] == 1){
        DeliveryDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DeteCell"];
        if(!cell){
            cell = [[DeliveryDateTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"DeteCell" size: CGSizeMake(tableView.frame.size.width, datePicker_height)];
            [cell setDelegate: self];
        }
        return cell;
    }
    else{
        DHBOfflineRechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"BaseCell"];
        if(!cell){
            cell = [[DHBOfflineRechargeTableViewCell
                     alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"BaseCell"];
            [cell setDelegate: self];
        }
        [cell updateViewWithFloorDTO: dto];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath section]];
    if([indexPath section] == 1){
        return datePicker_height;
    }
    else{
        return [dto hight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HomeFloorDTO *floorDTO = [[self.mainService floorsArray] objectAtIndex: section];
    return [floorDTO sectionHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: [UIColor UIViewBackGroundColor]];
    return view;
}

#pragma mark - DHBOfflineRechargeTableViewCell_Delegte
- (void)offlineRechargeTableViewCell_textFieldDidBeginEditing:(UITextField *)textField{
    ///打开时间选择器
    [textField resignFirstResponder];
    datePicker_height = CUR_DATEPICKER_HEIGHT;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)offlineRechargeTableViewCell_textViewDidEndEditing:(UITextView *)textView cell:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell: cell];
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath section]];
    [dto setModuleList: [NSMutableArray arrayWithObject: [textView text]]];
    _remark = textView.text;
}

-(void)offlineRechargeTableViewCell_DidSelectedAcctount:(UITableViewCell *)cell whithBankRow:(NSInteger)row{
    _selectBank = [self.mainService.dataArray safeObjectAtIndex:row];
}



//#pragma mark 键盘即将显示
//- (void)keyBoardWillShow:(NSNotification *)note{
//    self.keyboard_isShow = NO;
//    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyBoardHeight = rect.size.height;
//    WS(weakSelf);
//    if (self.tableView.contentSize.height > self.view.frame.size.height - Titel_HEIGHT -keyBoardHeight - self.bottomView.height){
//        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//            [weakSelf.tableView setContentOffset:CGPointMake(0.0, weakSelf.tableView.contentSize.height - keyBoardHeight + self.bottomView.height)];
//            weakSelf.bottomView.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight);
//        } completion:^(BOOL finished) {
//            weakSelf.keyboard_isShow = YES;
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//            weakSelf.bottomView.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight);
//        } completion:^(BOOL finished) {
//            weakSelf.keyboard_isShow = YES;
//        }];
//    }
//
//}
//#pragma mark 键盘即将退出
//- (void)keyBoardWillHide:(NSNotification *)note{
//    WS(weakSelf);
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        weakSelf.view.transform = CGAffineTransformIdentity;
//        weakSelf.bottomView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        weakSelf.keyboard_isShow = NO;
//    }];
//}


- (void)offlineRechargeTableViewCell_DidUploadPicture:(UIButton *)sender{
    //上传凭证
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"请选择上传方式" delegate: self cancelButtonTitle: @"取消" destructiveButtonTitle: nil otherButtonTitles: @"拍照", @"打开相册", nil];
//    [actionSheet showInView: [[UIApplication sharedApplication] keyWindow]];
    [actionSheet showInView: [self view]];
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: case 1:
        {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            [imagePickerController setDelegate: self];
            [imagePickerController setAllowsEditing: YES];
            if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
                [imagePickerController.navigationBar setBarTintColor: [UIColor NavBack_Red_Color]];
            else
                [imagePickerController.navigationBar setTintColor: [UIColor NavBack_Red_Color]];
            [imagePickerController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
            if(buttonIndex == 0){
                ///拍照
                if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                {
                    [imagePickerController setSourceType: UIImagePickerControllerSourceTypeCamera];
                    [imagePickerController setCameraDevice: UIImagePickerControllerCameraDeviceFront];
//                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//                    {
//                        //当前设备是iPad
//                        UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController: imagePickerController];
//                        //permittedArrowDirections 设置箭头方向
//                        [popover presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//                    }
//                    else{
                        [self presentViewController: imagePickerController animated: YES completion: nil];
//                    }
                }
                else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message:  @"对不起，您的设备不支持拍照" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
                    [alertView show];
                }
            }
            else{
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//                {
//                    //当前设备是iPad
//                    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController: imagePickerController];
//                    //permittedArrowDirections 设置箭头方向
//                    [popover presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//                }
//                else{
                    ////打开相册
                    [imagePickerController setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
                    [self presentViewController: imagePickerController animated: YES completion: nil];
//                }
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark 获取相册的委托方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
     DHBOfflineRechargeTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 4]];
    NSData *imageData = [self compressedImgLess4M: image];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    if(!imageData){
//        imageData = UIImageJPEGRepresentation(image, 1);
//    }
    [self.uploadImage setImage: imageData];
    [self.uploadImage setStatus: NOUPLOAD];
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: 4];
    if(dto){
        [dto setModuleList: [NSMutableArray arrayWithObject: self.uploadImage]];
    }
    [cell showImage: self.uploadImage];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - DeliveryDateTableViewCell Delegate
- (void)deliveryDateTableViewCell_DidCancelButtonClick{
    datePicker_height = 0.0f;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)deliveryDateTableViewCell_DidOkButtonClick:(RBCustomDatePickerView *)button selectTime:(NSString *)selectTime{
    [self deliveryDateTableViewCell_DidCancelButtonClick];
    DHBOfflineRechargeTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    [cell.rechargeTextField setText: selectTime];
}

#pragma mark - 提交按钮
- (void)submitButtonClick:(UIButton *) sender{
    DHBOfflineSubmitRequest *request = [[DHBOfflineSubmitRequest alloc] init];
    request.bank_id = [_selectBank EncodeStringFromDicWithKey:@"bank_id"];
    request.orders_num = self.order?self.order.orders_num:@"";
    request.remark = _remark ? _remark : @"";
    request.amount = self.amount;
    request.receipts_date = _receipts_date ? _receipts_date:[NSDate getNowDateFormat:DEFAULT_DATE_PATTERN];
//    WS(weakSelf)
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess)
        {
            [submitButton setEnabled: NO];
            requestDictionary = dic;
            if ([[[dic objectForKey:@"data"] EncodeStringFromDicWithKey:@"is_success"] isEqualToString:@"1"])
            {
//                NSLog_Blue(@"%@",[dic objectForKey:@"data"]);
                if([self.uploadImage image]){
                    ///当有图片的时候，开始上传图片
                    [[ParameterPublic sharedManagered] setUpload_arr: [NSMutableArray arrayWithObject: self.uploadImage]];
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] uploadImageContent_table:[[dic objectForKey:@"data"] EncodeArrayFromDicWithKey:@"content"]];
                    DHBOfflineRechargeTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 4]];
                    [cell showImage: self.uploadImage];
                }
                else{
                    ///没图片直接上传
                    DHBRechargeResultViewController *resultVC = [[DHBRechargeResultViewController alloc] init];
                    resultVC.order = self.order;
                    resultVC.mainView.type = self.paytype;
                    resultVC.mainView.amount = self.amount;
                    [self.navigationController pushViewController: resultVC animated: YES];
                }
            }
        }
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        
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

#pragma mark -
- (void)uploadover{
    if ([self.uploadImage status] == ERROR){
        //有部分上传失败
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"上传图片有部分上传失败哦，是否继续上传？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续上传",nil];
        msg.delegate = self;
        [msg show];
    }
    else{
        DHBOfflineRechargeTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 4]];
        [cell showImage: self.uploadImage];
        ////
        [[[ParameterPublic sharedManagered] upload_arr] removeAllObjects];
        [[NSNotificationCenter defaultCenter] removeObserver: self name: @"uploadover" object: nil];
        ///跳转至充值成功页面
        DHBRechargeResultViewController *resultVC = [[DHBRechargeResultViewController alloc] init];
        resultVC.order = self.order;
        resultVC.mainView.type = self.paytype;
        resultVC.mainView.amount = self.amount;
        [self.navigationController pushViewController: resultVC animated: YES];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        ///当有图片的时候，开始上传图片
        [[ParameterPublic sharedManagered] setUpload_arr: [NSMutableArray arrayWithObject: self.uploadImage]];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] uploadImageContent_table:[[requestDictionary objectForKey:@"data"] EncodeArrayFromDicWithKey:@"content"]];
        DHBOfflineRechargeTableViewCell *cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 4]];
        [cell showImage: self.uploadImage];
    }
    else
    {
        [[[ParameterPublic sharedManagered] upload_arr] removeAllObjects];
        [[NSNotificationCenter defaultCenter] removeObserver: self name: @"uploadover" object: nil];
        ///跳转至充值成功页面
        DHBRechargeResultViewController *resultVC = [[DHBRechargeResultViewController alloc] init];
        resultVC.order = self.order;
        resultVC.mainView.type = self.paytype;
        resultVC.mainView.amount = self.amount;
        [self.navigationController pushViewController: resultVC animated: YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
