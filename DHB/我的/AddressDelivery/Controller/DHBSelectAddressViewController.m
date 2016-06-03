//
//  DHBSelectAddressViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/5.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOM_HEIGHT 240.0f
#import "DHBSelectAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "DHBLoationManager.h"
#import "DHBSelectAddressCell.h"
#import "DHBSearchAddressViewController.h"
@interface DHBSelectAddressViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,DHBSearchAddressViewControllerDelegate>

@property(nonatomic,strong)UIButton *search_btn;
@property(nonatomic,strong)UIImageView *search_img;
@property(nonatomic,strong)UILabel *search_lb;

@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)AMapPOI *poi;
@property(nonatomic,strong)UIImageView *annotation_vi;


@property(nonatomic,strong)UIButton *showbottom_btn;
@property(nonatomic,strong)UIView *bottom_vi;
@property(nonatomic,strong)NSMutableArray *data_arr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DHBSelectAddressViewController
static NSString *identifier = @"addressCell";
#pragma mark - lazyload

-(UIButton *)search_btn{
    if (!_search_btn)
    {
        _search_btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6.4, 28, SCREEN_WIDTH-SCREEN_WIDTH/6.4-SCREEN_WIDTH/8, 30)];
        [_search_btn setBackgroundColor:HEX_RGB(0xc63700)];
        _search_btn.layer.cornerRadius = 5;
        [_search_btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _search_btn;
}

-(UIImageView *)search_img{
    if (!_search_img)
    {
        _search_img = [[UIImageView alloc] initWithFrame:CGRectMake(self.search_btn.left+5.0f, self.search_btn.top + 5.0f, 20.0f, 20.0f)];
        [_search_img setImage:[UIImage imageNamed:@"search_normal"]];
    }
    return _search_img;
}

-(UILabel *)search_lb{
    if (!_search_lb)
    {
        _search_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.search_img.right+5, self.search_btn.bottom-7-16, self.search_btn.width-self.search_img.right, 15)];
        _search_lb.font = [UIFont systemFontOfSize:14];
        _search_lb.textColor = HEX_RGB(0xff6046);
        _search_lb.alpha = 0.9;
        _search_lb.text = @"请输入相关地址名称";
    }
    return _search_lb;
}

-(MAMapView *)mapView{
    if (!_mapView)
    {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
        _mapView.delegate = self;
        [_mapView setZoomLevel:_mapView.zoomLevel+6 animated:YES];
        [_mapView setCenterCoordinate:[[ParameterPublic sharedManagered] coord] animated:YES];
//        NSLog_Blue(@"%lf,%lf",[[ParameterPublic sharedManagered] coord].latitude,[[ParameterPublic sharedManagered] coord].longitude);
    }
    return _mapView;
}

-(UIButton *)showbottom_btn{
    if (!_showbottom_btn)
    {
        _showbottom_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-65, self.view.frame.size.height-65, 65, 65)];
        [_showbottom_btn setImage:[UIImage imageNamed:@"zuobiao2"] forState:UIControlStateNormal];
        [_showbottom_btn addTarget:self action:@selector(showbottomView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showbottom_btn;
}

-(UIView *)bottom_vi{
    if (!_bottom_vi)
    {
        _bottom_vi = [[[NSBundle mainBundle] loadNibNamed:@"DHBSelectBottomView" owner:self options:nil] objectAtIndex:0];
        [_bottom_vi setFrame:CGRectMake(0, SCREEN_HEIGHT-BOTTOM_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)];
        //顶部还需要划线
        UIView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 3)];
        [topImageView setBackgroundColor:HEX_RGB(0xfe4600)];
        [_bottom_vi addSubview:topImageView];
    }
    return _bottom_vi;
}

-(UIImageView *)annotation_vi{
    if (!_annotation_vi)
    {
        _annotation_vi = [[UIImageView alloc] initWithFrame:CGRectMake(self.mapView.center.x-23/2, self.mapView.center.y-35, 23, 35)];
        [_annotation_vi setImage:[UIImage imageNamed:@"zuobiao3"]];
    }
    return _annotation_vi;
}

#pragma mark - Controllerlife
- (id)init{
    self = [super init];
    if (self)
    {
        [[DHBLoationManager sharedInstance] startLocationOnce];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBack:YES];
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.showbottom_btn];
    [self.mapView addSubview:self.annotation_vi];
//    NSLog_Blue(@" map = %lf %lf",self.mapView.centerCoordinate.latitude,self.mapView.centerCoordinate.longitude);
    
    [self.view insertSubview:self.bottom_vi aboveSubview:self.mapView];
    UINib *nib = [UINib nibWithNibName:@"DHBSelectAddressCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTitelView{
    [super initTitelView];
    [self.navigationView addSubview:self.search_btn];
    [self.navigationView addSubview:self.search_img];
    [self.navigationView addSubview:self.search_lb];
}

#pragma mark ButtonAction
- (void)searchAction:(UIButton *)sender {
    DHBSearchAddressViewController *searchAddress = [[DHBSearchAddressViewController alloc] init];
    searchAddress.delegate = self;
    [self.navigationController pushViewController:searchAddress animated:YES];
}

- (IBAction)bottomAction:(UIButton *)sender {
    WS(weakSelf);
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.bottom_vi.top = self.view.frame.size.height;
    } completion:^(BOOL finished) {
    }];
}

-(void)showbottomView:(UIButton *)sender{
    WS(weakSelf);
    [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.bottom_vi.top = self.view.frame.size.height-BOTTOM_HEIGHT - 64.0f;
    } completion:^(BOOL finished) {
    }];
}


#pragma mark MAMapViewDelegate

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.radius = 1000;
    request.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    //发起行政区划查询
    [self.search AMapPOIAroundSearch:request];
}

#pragma mark AMapSearchDelegate


/**
 *  POI查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    self.data_arr = [NSMutableArray arrayWithArray:response.pois];
    [self.tableView reloadData];
}

/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    self.poi.citycode = response.regeocode.addressComponent.citycode;//市编码
    self.poi.adcode = response.regeocode.addressComponent.adcode;//区编码
    self.poi.province = response.regeocode.addressComponent.province;//省
    self.poi.city = response.regeocode.addressComponent.city;//市
    self.poi.district = response.regeocode.addressComponent.district;//区
    
    [self.delegate selectAddressViewController:self AMapPOI:self.poi];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark TreeView UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBSelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    AMapPOI *poi = [self.data_arr safeObjectAtIndex:indexPath.row];
    cell.name_lb.text = poi.name;
    cell.address_lb.text = poi.address;
    if (indexPath.row == 0)
    {
        [cell.name_lb setTextColor:[UIColor TextRed_Color]];
        [cell.address_lb setTextColor:[UIColor TextRed_Color]];
    }
    else{
        [cell.name_lb setTextColor:[UIColor TextGray_Color]];
        [cell.address_lb setTextColor:[UIColor TextGray_Color]];
    }
    return cell;
}

#pragma mark  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.poi = [self.data_arr safeObjectAtIndex:indexPath.row];
    AMapReGeocodeSearchRequest *georequest = [[AMapReGeocodeSearchRequest alloc] init];
    georequest.location = self.poi.location;
    //发起行政区划查询
    [self.search AMapReGoecodeSearch:georequest];
}


#pragma mark DHBSearchAddressViewControllerDelegate
-(void)searchAddressViewController:(DHBSearchAddressViewController *)controller AMapPOI:(AMapPOI *)poi{
//    self.poi = poi;
    CLLocationCoordinate2D coord;
    coord.latitude =poi.location.latitude;
    coord.longitude =poi.location.longitude;
    [self.mapView setCenterCoordinate:coord animated:YES];
}

@end
