//
//  DHBLoationManager.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/6.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface DHBLoationManager : NSObject<AMapLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
/**
 *  初始化
 *
 *  @return
 */
+(DHBLoationManager *)sharedInstance;

/**
 *  开始连续定位
 *
 *  调用此方法会cancel掉所有的单次定位请求。
 */
- (void)startUpdatingLocation;

/**
 *  停止连续定位
 *
 *  调用此方法会cancel掉所有的单次定位请求，可以用来取消单次定位。
 */
- (void)stopUpdatingLocation;

/**
 *  单次定位
 *
 *  如果当前正在连续定位，调用此方法将会失败，返回NO。
 *
 *  该方法将会根据设定的 desiredAccuracy 去获取定位信息。
 *  如果获取的定位信息精确度低于 desiredAccuracy ，将会持续的等待定位信息，直到超时后通过completionBlock返回精度最高的定位信息。
 *
 *  可以通过 stopUpdatingLocation 方法去取消正在进行的单次定位请求。
 *
 *  @param withReGeocode 是否带有逆地理信息(获取逆地理信息需要联网)
 *  @param completionBlock 单次定位完成后的Block
 *  @return 是否成功添加单次定位Request
 */
-(void)startLocationOnce;

/**
 *  反向EGO地理位置查询
 *
 *  @param coord 位置经纬结果 修改内存ego
 */
- (void)egoSearch:(CLLocationCoordinate2D)coord;
@end
