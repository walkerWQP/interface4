//
//  DingWeiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DingWeiViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MapKit/MapKit.h>
#import "BaiDuQuanJingViewController.h"
#import "WeiLanViewController.h"
#import "WeiLanListViewController.h"

@interface DingWeiViewController ()<AMapLocationManagerDelegate, AMapGeoFenceManagerDelegate, MAMapViewDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAMapView           *mapView;
@property (nonatomic, strong) AMapGeoFenceManager *geoFenceManager;
@property (nonatomic, strong) NSMutableArray      *regions;
@property (nonatomic, strong) UIButton            *dingWeiImg;
@property (nonatomic, strong) UIButton            *luXianImg;
@property (nonatomic, strong) UIButton            *QuanJingImg;
@property (nonatomic, assign) CGFloat             startLatitude;
@property (nonatomic, assign) CGFloat             startLongitude;
@property (nonatomic, assign) CGFloat             endLatitude;
@property (nonatomic, assign) CGFloat             endLongitude;
@property (nonatomic, strong) NSMutableArray      *mapsUrlArray;

@end

@implementation DingWeiViewController

- (NSMutableArray *)mapsUrlArray {
    if (!_mapsUrlArray) {
        self.mapsUrlArray = [@[] mutableCopy];
    }
    return _mapsUrlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"电子围栏" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.title = @"所在位置";
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//    腾讯高德：34.7746120000,113.6555180000
    
    //设置缩放级别
    [_mapView setZoomLevel:15];
    //是否显示指南针
    [_mapView setShowsCompass:YES];
    //是否显示比例尺
    [_mapView setShowsScale:YES];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(34.797254 ,113.59985);
    //    self.mapView.centerCoordinate = coordinate;
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = self.title;
    [_mapView addAnnotation:annotation];
    //
    //   [_mapView setRegion:MACoordinateRegionMakeWithDistance(coordinate, 5000, 5000)];
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 20;
    //    UIImageView * dingweiImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    //    dingweiImg.image = [UIImage imageNamed:@"dingwei1"];
    //    [self.view addSubview:dingweiImg];
    
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
  
   
    //获得返回的地址
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//        [self.locationManager stopUpdatingLocation];
//
//        CLLocationCoordinate2D commonPolylineCoords[2];
//        commonPolylineCoords[0].latitude = 34.774612;
//        commonPolylineCoords[0].longitude = 113.655518;
//        commonPolylineCoords[1].latitude = location.coordinate.latitude;
//        commonPolylineCoords[1].longitude = location.coordinate.longitude;
//
//        //构造折线对象
//        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
//
//        //在地图上添加折线对象
//        [_mapView addOverlay:commonPolyline];
//    }];
    
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
//    }
    //开始持续定位
   [self.locationManager startUpdatingLocation];
    
    self.geoFenceManager = [[AMapGeoFenceManager alloc] init];
    self.geoFenceManager.delegate = self;
    self.geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside | AMapGeoFenceActiveActionStayed; //设置希望侦测的围栏触发行为，默认是侦测用户进入围栏的行为，即AMapGeoFenceActiveActionInside，这边设置为进入，离开，停留（在围栏内10分钟以上），都触发回调
//    self.geoFenceManager.allowsBackgroundLocationUpdates = YES;  //允许后台定位
   
}




- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 6.f;
        polylineRenderer.strokeColor  = THEMECOLOR;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kCGLineCapButt;
        polylineRenderer.lineDashType = kMALineDashTypeNone;
        return polylineRenderer;
    }
    return nil;
}

//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//        }
//        
//        annotationView.canShowCallout               = NO;
//        annotationView.animatesDrop                 = YES;
//        annotationView.draggable                    = YES;
//        
//        return annotationView;
//    }
//    
//    return nil;
//}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    
    CLLocationCoordinate2D commonPolylineCoords[2];
    commonPolylineCoords[0].latitude = location.coordinate.latitude;
    commonPolylineCoords[0].longitude = location.coordinate.longitude;
    commonPolylineCoords[1].latitude = 34.797254;
    commonPolylineCoords[1].longitude = 113.59985;
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    //在地图上添加折线对象
    [_mapView addOverlay:commonPolyline];
    [self.locationManager stopUpdatingLocation];
}


- (void)luXianBtn:(UIButton *)sender {
    NSArray *ary = [NSArray arrayWithObjects:@"34.797254", @"113.59985",nil];
    [self doNavigationWithEndLocation:ary];
}

//导航只需要目的地经纬度，endLocation为纬度、经度的数组
-(void)doNavigationWithEndLocation:(NSArray *)endLocation {
    
    //NSArray * endLocation = [NSArray arrayWithObjects:@"26.08",@"119.28", nil];
    NSMutableArray *maps = [NSMutableArray array];
    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"导航功能",@"nav123456",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",@"导航测试",@"nav123456",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    NSMutableDictionary *quxiaoMapDic = [NSMutableDictionary dictionary];
    quxiaoMapDic[@"title"] = @"取消";
    [maps addObject:quxiaoMapDic];
    //选择
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSInteger index = maps.count;
    for (int i = 0; i < index; i++) {
        NSString * title = maps[i][@"title"];
        //苹果原生地图方法
        if (i == 0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMap];
            }];
            [alert addAction:action];
            continue;
        }
        
        if (i + 1 == index) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }];
            [alert addAction:action];
            continue;
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = maps[i][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alert addAction:action];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

//苹果地图
- (void)navAppleMap {
    //    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.destinationCoordinate2D];
    //终点坐标
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(34.797254, 113.59985);
    
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    //第二个，都可以用
    //    NSDictionary * dic = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]};
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}


- (void)dingWei:(UIButton *)sender {
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
}

- (void)QuanJing:(UIButton *)sender {
    BaiDuQuanJingViewController * baiDuQuanJingVC = [[BaiDuQuanJingViewController alloc] init];
    [self.navigationController pushViewController:baiDuQuanJingVC animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.luXianImg removeFromSuperview];
    [self.dingWeiImg removeFromSuperview];
    [self.QuanJingImg removeFromSuperview];
}

- (void)rightBarButton:(UIBarButtonItem *)sender {
    WeiLanListViewController * weiLanVC = [[WeiLanListViewController alloc] init];
    [self.navigationController pushViewController:weiLanVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.dingWeiImg = [[UIButton alloc] initWithFrame:CGRectMake(15, APP_HEIGHT - 250 - 64, 51, 51)];
    [self.dingWeiImg setBackgroundImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [self.view addSubview:self.dingWeiImg];
    [self.dingWeiImg addTarget:self action:@selector(dingWei:) forControlEvents:UIControlEventTouchDown];
    self.dingWeiImg.userInteractionEnabled = YES;
    
    self.luXianImg = [[UIButton alloc] initWithFrame:CGRectMake(15, self.dingWeiImg.frame.origin.y + self.dingWeiImg.frame.size.height + 20, 51, 51)];
    [self.luXianImg setBackgroundImage:[UIImage imageNamed:@"路线"] forState:UIControlStateNormal];
    [self.view  addSubview:self.luXianImg];
    [self.luXianImg addTarget:self action:@selector(luXianBtn:) forControlEvents:UIControlEventTouchDown];
    self.luXianImg.userInteractionEnabled = YES;
    
    self.QuanJingImg = [[UIButton alloc] initWithFrame:CGRectMake(23, self.luXianImg.frame.origin.y + self.luXianImg.frame.size.height + 20, 34, 61)];
    [self.QuanJingImg setBackgroundImage:[UIImage imageNamed:@"全景"] forState:UIControlStateNormal];
    [self.view  addSubview:self.QuanJingImg];
    [self.QuanJingImg addTarget:self action:@selector(QuanJing:) forControlEvents:UIControlEventTouchDown];
    self.QuanJingImg.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
