//
//  WeiLanViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WeiLanViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface WeiLanViewController ()<AMapLocationManagerDelegate, AMapGeoFenceManagerDelegate, MAMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MAMapView           *mapView;
@property (nonatomic, strong) AMapGeoFenceManager *geoFenceManager;
@property (nonatomic, strong) CLLocation          *userLocation;  //获得自己的位置，方便demo添加围栏进行测试，
@property (nonatomic, strong) MACircle            *circleOverlay;
@property (nonatomic, strong) UISlider            *slider;
@property (nonatomic, strong) MAPointAnnotation   *annotation;
@property (nonatomic, strong) UITextField         *shuruText;
@property (nonatomic, strong) UIButton            *baoCunBtn;

@end

@implementation WeiLanViewController

- (void)viewWillAppear:(BOOL)animated {
    self.shuruText = [[UITextField alloc] initWithFrame:CGRectMake(0, APP_HEIGHT - 40, APP_WIDTH - 80, 40)];
    self.shuruText.backgroundColor = [UIColor whiteColor];
    self.shuruText.placeholder = @"   请输入内容";
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.shuruText];
    
    self.baoCunBtn = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH - 80, APP_HEIGHT - 40, 80, 40)];
    [self.baoCunBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.baoCunBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [self.baoCunBtn setBackgroundColor:[UIColor whiteColor]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.baoCunBtn];
    
    [self.baoCunBtn addTarget:self action:@selector(baoCunBtn:) forControlEvents:UIControlEventTouchDown];
    self.baoCunBtn.userInteractionEnabled = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电子围栏";
    
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    //设置缩放级别
    [_mapView setZoomLevel:10];
    //是否显示指南针
    [_mapView setShowsCompass:YES];
    //是否显示比例尺
    [_mapView setShowsScale:YES];
    
    self.geoFenceManager = [[AMapGeoFenceManager alloc] init];
    self.geoFenceManager.delegate = self;
    self.geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside | AMapGeoFenceActiveActionStayed; //进入，离开，停留都要进行通知
    
    [self doClear];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.latitude,self.longitude);
    if (self.userLocation) {
        coordinate = self.userLocation.coordinate;
    }
    [self.geoFenceManager addCircleRegionForMonitoringWithCenter:coordinate radius:self.radis customID:@"circle_1"];
    
    self.annotation = [[MAPointAnnotation alloc] init];
    self.annotation.coordinate = coordinate;
    
    [_mapView addAnnotation:self.annotation];
    
    
    if ([UIScreen mainScreen].bounds.size.height == 812) {
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(15, 124, APP_WIDTH - 30, 20)];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.slider];
    } else {
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(15, 74, APP_WIDTH - 30, 20)];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.slider];
    }
    
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //给_mapView添加长按手势
    UITapGestureRecognizer *lpress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    lpress.delegate = self;
    [_mapView addGestureRecognizer:lpress];

    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardActionShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardActionHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardActionShow:(NSNotification *)nofity {
    NSDictionary *useInfo = [nofity userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.shuruText.frame = CGRectMake(0, APP_HEIGHT - [value CGRectValue].size.height - 40, APP_WIDTH - 80, 40);
    self.baoCunBtn.frame = CGRectMake(APP_WIDTH - 80, APP_HEIGHT - [value CGRectValue].size.height - 40, 80, 40);
}

- (void)keyboardActionHidden:(NSNotification *)nofity {
    self.shuruText.frame = CGRectMake(0, APP_HEIGHT - 40, APP_WIDTH - 80, 40);
    self.baoCunBtn.frame = CGRectMake(APP_WIDTH - 80, APP_HEIGHT - 40, 80, 40);
}



- (void)baoCunBtn:(UIButton *)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    if ([self.shuruText.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入描述" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });

    } else {
        NSDictionary *dic = @{@"key":[UserManager key], @"name":self.shuruText.text, @"radius":[NSString stringWithFormat:@"%f", self.circleOverlay.radius], @"longitude":[NSString stringWithFormat:@"%f", self.circleOverlay.coordinate.longitude], @"latitude":[NSString stringWithFormat:@"%f", self.circleOverlay.coordinate.latitude]};
        [[HttpRequestManager sharedSingleton] POST:indexFenceAddFence parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                } else {
                    
                }
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (double)StringChangeToDoubleForJingdu:(NSString *)textString {
    if (textString == nil || [textString isEqualToString:@""]) {
        return 0.0;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [[formatter numberFromString:textString]doubleValue];
}



#pragma mark - 允许多手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)longPress:(UITapGestureRecognizer *)gestureRecognizer {
    
    [_mapView removeAnnotation:_annotation];
    //坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    _annotation.coordinate = touchMapCoordinate;
    [_mapView addAnnotation:_annotation];
    _circleOverlay.coordinate = touchMapCoordinate;

//    [self setLocationWithLatitude:touchMapCoordinate.latitude AndLongitude:touchMapCoordinate.longitude];

}


- (void)sliderValueChanged:(UISlider *)slider {
    
    NSLog(@"slider value%f",slider.value);
    self.circleOverlay.radius = slider.value * 2000;
    
}


// 清除上一次按钮点击创建的围栏
- (void)doClear {
    [self.mapView removeOverlays:self.mapView.overlays];  //把之前添加的Overlay都移除掉
    [self.geoFenceManager removeAllGeoFenceRegions];  //移除所有已经添加的围栏，如果有正在请求的围栏也会丢弃
}

//添加地理围栏对应的Overlay，方便查看。地图上显示圆
- (MACircle *)showCircleInMap:(CLLocationCoordinate2D )coordinate radius:(NSInteger)radius {
    self.circleOverlay = [MACircle circleWithCenterCoordinate:coordinate radius:radius];
    [self.mapView addOverlay:self.circleOverlay];
    return self.circleOverlay;
}

#pragma mark - AMapGeoFenceManagerDelegate

//添加地理围栏完成后的回调，成功与失败都会调用
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray<AMapGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error {
    
    if ([customID hasPrefix:@"circle"]) {
        if (error) {
            
            NSLog(@"======= circle error %@",error);
            
        } else {
            AMapGeoFenceCircleRegion *circleRegion = (AMapGeoFenceCircleRegion *)regions.firstObject;  //一次添加一个圆形围栏，只会返回一个
            MACircle *circleOverlay = [self showCircleInMap:circleRegion.center radius:self.radis];
            [self.mapView setVisibleMapRect:circleOverlay.boundingMapRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];   //设置地图的可见范围，让地图缩放和平移到合适的位置
        }
    }
}

//地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(AMapGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"status changed error %@",error);
    } else {
        NSLog(@"status changed %@",[region description]);
    
        NSString *status = @"unknown";
        switch (region.fenceStatus) {
            case AMapGeoFenceRegionStatusInside:
                status = @"Inside";
                break;
            case AMapGeoFenceRegionStatusOutside:
                status = @"Outside";
                break;
            case AMapGeoFenceRegionStatusStayed:
                status = @"Stayed";
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - MAMapViewDelegate

//- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
//{
//    self.userLocation = userLocation.location;
//}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolygon class]]) {
        MAPolygonRenderer *polylineRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polylineRenderer.lineWidth = 3.0f;
        polylineRenderer.strokeColor = [UIColor orangeColor];
        
        return polylineRenderer;
    } else if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth = 3.0f;
        circleRenderer.strokeColor = [UIColor purpleColor];
        
        return circleRenderer;
    }
    return nil;
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
//        annotationView.image = [UIImage imageNamed:@"定位红"];

        annotationView.canShowCallout               = NO;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = NO;

        return annotationView;
    }

    return nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.slider removeFromSuperview];
    [self.shuruText removeFromSuperview];
    [self.baoCunBtn removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
