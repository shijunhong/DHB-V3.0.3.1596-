
//  DHBScanningErWeiMaViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/23.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBScanningErWeiMaViewController.h"
#import "DHBGoodsViewController.h"
#import "DHBAlertView.h"

@interface DHBScanningErWeiMaViewController ()

@end

@implementation DHBScanningErWeiMaViewController
#pragma mark - load
- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加四周阴影视图
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:maskView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [maskPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH/2 -285/2, SCREEN_HEIGHT/2-285/2 - 64.0f, 285, 285) cornerRadius:1] bezierPathByReversingPath]];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskView.layer.mask = maskLayer;
    
    //设置扫描框图片
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sacn_frame"]];
    image.frame = CGRectMake(SCREEN_WIDTH/2 -285/2, SCREEN_HEIGHT/2-285/2, 285, 285);
    [self.view insertSubview:image atIndex:4];
    
    ///设置扫描线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-280/2, SCREEN_HEIGHT/2-285/2, 280, 1.0f)];
    _line.image = [UIImage imageNamed:@"sacn"];
    [self.view insertSubview:_line atIndex:1];
    
    [UIView animateWithDuration: 1.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        self.line.height = 285;
    } completion:^(BOOL finished) {
        self.line.top -= 300;
    }];
}

-(void)initTitelView{
    [super initTitelView];
    [self showTabBar:NO];
    [self showBack:YES];
    [self showTitel:YES andTitelText:@"二维码扫码"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ///1.先提示用户获取相机权限
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];// Device
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];// Input
    ///2.再判断用户是否开启相机权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized)
    {
        [self setupCamera];
    }
    else
    {
        [[DHBAlertView sharedManagered] showMessage:@"没获取到相机权限!请在，设置-隐私-相机 开启相机访问权限"];
        [[DHBAlertView sharedManagered] setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex)
         {
             [self.navigationController popViewControllerAnimated:YES];
         }];
    }
}

#pragma mark - 设置相机扫描参数
- (void)setupCamera
{
    ////InputOutput
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描区域
    [_output setRectOfInterest: CGRectMake((SCREEN_HEIGHT/2-285/2) / SCREEN_HEIGHT, (SCREEN_WIDTH/2 -285/2) / SCREEN_WIDTH, 285 / SCREEN_HEIGHT, 285 / SCREEN_WIDTH)]; ///(y/屏幕高度, x/屏幕宽度, height/屏幕高度, width/屏幕宽度)
    
    ////Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    ////条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code];
    //Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    //Start
    [_session startRunning];
    
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        [self.session stopRunning];
        DHBGoodsViewController * goodslist = [[DHBGoodsViewController alloc] init];
        goodslist.goodsListService.page = 1;
        goodslist.goodsListService.barcode = metadataObject.stringValue;
        goodslist.is_Barcode = YES;
        [self.navigationController pushViewController:goodslist animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
