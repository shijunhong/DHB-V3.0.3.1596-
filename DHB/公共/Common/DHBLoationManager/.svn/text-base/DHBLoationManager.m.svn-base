//
//  DHBLoationManager.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/6.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBLoationManager.h"
#import "ParameterPublic.h"

@implementation DHBLoationManager
+(DHBLoationManager *)sharedInstance
{
    
    static DHBLoationManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DHBLoationManager alloc]init];
        shareInstance.locationManager = [[AMapLocationManager alloc] init];
        shareInstance.locationManager.delegate = shareInstance;
        [shareInstance.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    });
    return shareInstance;
}


- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];;
}


- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}


/**
 *  当定位发生错误时，会调用代理的此方法。
 *
 *  @param manager 定位 AMapLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog_Red(@"持续定位失败 error= %@",error)
}

/**
 *  连续定位回调函数
 *
 *  @param manager 定位 AMapLocationManager 类。
 *  @param location 定位结果。
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    [[ParameterPublic sharedManagered] setCoord:location.coordinate];
//    NSLog_Red(@"%lf %lf",location.coordinate.latitude,location.coordinate.longitude);
    //创建逆向查询
//    CLLocationCoordinate2D coord  = location.coordinate;
//    [self egoSearch:coord];
}


- (void)egoSearch:(CLLocationCoordinate2D)coord {
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    //构造AMapWeatherSearchRequest对象，配置查询参数
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude longitude:coord.longitude];
    //发起行政区划查询
    [self.search AMapReGoecodeSearch:request];
}

/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
//    [[ParameterPublic sharedManagered] setGeo:response.regeocode];
}


-(void)startLocationOnce{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog_Red(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        if (regeocode)
        {
            [[ParameterPublic sharedManagered] setCoord:location.coordinate];
            [[ParameterPublic sharedManagered] setGeo:regeocode];
            NSLog_Red(@"%lf,%lf",location.coordinate.latitude,location.coordinate.longitude);
        }
    }];
}



@end
