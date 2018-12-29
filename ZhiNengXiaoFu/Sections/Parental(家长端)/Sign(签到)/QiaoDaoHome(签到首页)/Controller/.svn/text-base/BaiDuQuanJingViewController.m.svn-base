//
//  BaiDuQuanJingViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "BaiDuQuanJingViewController.h"
#import <BaiduPanoSDK/BaiduPanoramaView.h>
#import <BaiduPanoSDK/BaiduPanoUtils.h>

@interface BaiDuQuanJingViewController ()<BaiduPanoramaViewDelegate>
@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;

@end

@implementation BaiDuQuanJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全景地图";
    [self customPanoView];
}

- (void)customPanoView {
    
    // key 为在百度LBS平台上统一申请的接入密钥ak 字符串
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - 64) key:@"qCxlqkuChtld3MR5Y22eTBE3qija55GL"];
    // 为全景设定一个代理
    self.panoramaView.delegate = self;
    [self.view addSubview:self.panoramaView];
    // 设定全景的清晰度， 默认为middle
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionHigh];
    // 设定全景的pid， 这是指定显示某地的全景，/Work/Code/app/panosdk2/ios/demo/BaiduPanoDemo/BaiduPanoDemo也可以通过百度坐标进行显示全景
    // [self.panoramaView setPanoramaWithPid:@"01002200001309101607372275K"];
    // 西单大悦城坐标
    // [self.panoramaView setPanoramaWithLon:116.379918 lat:39.916634];
    
    /**
     * 百度iOS全景SDK接口和功能目前支持BD09坐标系。因此开发者需要将WGS84或者GCJ02坐标转换为BD09坐标。
     
     * 大地坐标系(WGS84):
     Latitude:  39.906283536127169
     Longitude: 116.39129554889048
     
     * 国测局加密坐标系(GCJ02):
     Latitude:  39.907687
     Longitude: 116.397539
     
     * 百度经纬度坐标系(BD09LL):
     Latitude:  39.91403075654526
     Longitude: 116.40391285827147
     
     * 百度墨卡托坐标(BD09MC):
     X:         12958165
     Y:         4825783
     */
//    switch (self.showType) {
//        case PanoShowTypePID:
//            [self.panoramaView setPanoramaWithPid:@"01002200001309101607372275K"];
//            break;
//        case PanoShowTypeUID:
//            [self.panoramaView setPanoramaWithUid:@"bff8fa7deabc06b9c9213da4"];
//            break;
//        case PanoShowTypeWGS84:
//        case PanoShowTypeGCJ02:
//        case PanoShowTypeBD09LL:

            [self.panoramaView setPanoramaWithLon:113.6063340323 lat:34.8030221972];
//            break;
//        case PanoShowTypeBD09MC:
//            [self.panoramaView setPanoramaWithX:12958165 Y:4825783];
//            break;
//        default:
//            break;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
