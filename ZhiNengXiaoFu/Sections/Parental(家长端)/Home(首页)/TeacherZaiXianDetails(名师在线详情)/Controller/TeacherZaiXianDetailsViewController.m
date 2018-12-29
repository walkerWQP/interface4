//
//  TeacherZaiXianDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherZaiXianDetailsViewController.h"
#import "JohnTopTitleView.h"
#import "KeChengJieShaoViewController.h"
#import "ShiPinListViewController.h"
#import "TeacherZaiXianDetailsModel.h"
#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"
#import "TeacherZaiXianModel.h"

@interface TeacherZaiXianDetailsViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) SelVideoPlayer            *player;

@property (nonatomic,weak) CLPlayerView                 *playerView;
@property (nonatomic,strong) JohnTopTitleView           *titleView;
@property (nonatomic,strong) TeacherZaiXianDetailsModel * teacherZaiXianDetailsModel;
@property (nonatomic, strong) UIView                    *contentView;
@property (nonatomic, strong) UIScrollView              *teacherZaiXianDetailsScrollView;

@end

@implementation TeacherZaiXianDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    [self setNetWork:self.teacherZaiXianDetailsId];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shiPinList:) name:@"shipinListBoFang" object:nil];
    
}

- (void)shiPinList:(NSNotification *)nofity {
   TeacherZaiXianModel * model =  [[nofity object] objectForKey:@"SchoolDongTaiModel"];
    [self.playerView removeFromSuperview];
    [_playerView destroyPlayer];
    _playerView = nil;
    [self setNetWorkN:model.ID];
}

-  (void)setNetWorkN:(NSString *)str {
    NSDictionary *dic = @{@"key":[UserManager key], @"id":str};
    [[HttpRequestManager sharedSingleton] POST:indexOnlineVideoById parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.teacherZaiXianDetailsModel = [TeacherZaiXianDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            self.title = self.teacherZaiXianDetailsModel.title;
            if ([self.teacherZaiXianDetailsModel.video_url isEqualToString:@""]) {
                UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
                [back sd_setImageWithURL:[NSURL URLWithString:self.teacherZaiXianDetailsModel.img] placeholderImage:nil];
                [self.view addSubview:back];
            } else {
                [self setBoFang];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else if ([[responseObject objectForKey:@"status"] integerValue] == 405) {
                UIImageView * back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
                [back sd_setImageWithURL:[NSURL URLWithString:self.teacherZaiXianDetailsModel.img] placeholderImage:nil];
                [self.view addSubview:back];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNetWork:(NSString *)str {
    NSDictionary *dic = @{@"key":[UserManager key], @"id":str};
    [[HttpRequestManager sharedSingleton] POST:indexOnlineVideoById parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        self.teacherZaiXianDetailsModel = [TeacherZaiXianDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        self.title = self.teacherZaiXianDetailsModel.title;
//        [self createUI];
        [self makeContentViewUI];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200 ) {
            if ([self.teacherZaiXianDetailsModel.video_url isEqualToString:@""]) {
                UIImageView * back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
                [back sd_setImageWithURL:[NSURL URLWithString:self.teacherZaiXianDetailsModel.img] placeholderImage:nil];
                [self.view addSubview:back];
            } else {
                [self setBoFang];
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else if ([[responseObject objectForKey:@"status"] integerValue] == 405) {
                UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
                [back sd_setImageWithURL:[NSURL URLWithString:self.teacherZaiXianDetailsModel.img] placeholderImage:nil];
                [self.view addSubview:back];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        }
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setBoFang {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = YES;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:self.teacherZaiXianDetailsModel.video_url];
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, width, 200) configuration:configuration];
    [self.view addSubview:_player];
    

}

#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


- (void)makeContentViewUI {
    
    self.teacherZaiXianDetailsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.teacherZaiXianDetailsScrollView.backgroundColor = backColor;
    self.teacherZaiXianDetailsScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 1.5);
    self.teacherZaiXianDetailsScrollView.bounces = YES;
    self.teacherZaiXianDetailsScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.teacherZaiXianDetailsScrollView.maximumZoomScale = 2.0;//最多放大到两倍
    self.teacherZaiXianDetailsScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    self.teacherZaiXianDetailsScrollView.bouncesZoom = YES; //设置是否允许缩放超出倍数限制，超出后弹回
    self.teacherZaiXianDetailsScrollView.delegate = self;//设置委托
    [self.view addSubview:self.teacherZaiXianDetailsScrollView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.teacherZaiXianDetailsScrollView addSubview:self.contentView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
    headImgView.layer.masksToBounds = YES;
    headImgView.layer.cornerRadius  = 25;
    [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.teacherZaiXianDetailsModel.head_img]] placeholderImage:[UIImage imageNamed:@"user"]];
    [self.contentView addSubview:headImgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + headImgView.frame.size.width, 25, 90, 20)];
    nameLabel.textColor = RGB(51, 51, 51);
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.text = self.teacherZaiXianDetailsModel.name;
    [self.contentView addSubview:nameLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 120, 10, 100, 20)];
    numLabel.textColor = RGB(170, 170, 170);
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.text = self.teacherZaiXianDetailsModel.name;
    if (self.teacherZaiXianDetailsModel.view > 9999) {
        CGFloat num = self.teacherZaiXianDetailsModel.view / 10000;
        numLabel.text = [NSString stringWithFormat:@"播放数:%.1f", num];
    } else {
        numLabel.text = [NSString stringWithFormat:@"播放数:%ld", self.teacherZaiXianDetailsModel.view];
    }
    numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:numLabel];
    
    UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 170, 40, 150, 20)];
    dataLabel.textColor = RGB(170, 170, 170);
    dataLabel.font = [UIFont systemFontOfSize:12];
    dataLabel.text = self.teacherZaiXianDetailsModel.name;
    dataLabel.text = [NSString stringWithFormat:@"发布日期:%@", self.teacherZaiXianDetailsModel.create_time];
    dataLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:dataLabel];
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, headImgView.frame.size.height + 20, APP_WIDTH - 40, 1)];
    lineView.backgroundColor = RGB(238, 238, 238);
    [self.contentView addSubview:lineView];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headImgView.frame.size.height + 30, 200, 20)];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.text = @"内容简介";
    typeLabel.textColor = RGB(51, 51, 51);
    typeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:typeLabel];
    
   UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headImgView.frame.size.height + typeLabel.frame.size.height + 40, APP_WIDTH - 40, 100)];
    NSString *labelStr = self.teacherZaiXianDetailsModel.content;
    CGSize labelSize = {0, 0};
    labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:12]
                     constrainedToSize:CGSizeMake(200.0, 5000)
                         lineBreakMode:NSLineBreakByWordWrapping];
    contentLabel.numberOfLines = 0;//表示label可以多行显示
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，与上面的计算保持一致。
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度。
    contentLabel.textColor = RGB(102, 102, 102);
    contentLabel.text = labelStr;
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.isTop = YES;
    [self.contentView addSubview:contentLabel];
    
    
    
}


- (void)createUI {
    NSArray *titleArray = [NSArray arrayWithObjects:@"视频介绍",@"相关推荐", nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC {
    KeChengJieShaoViewController * vc1 = [[KeChengJieShaoViewController alloc]init];
    vc1.teacherZaiXianDetailsModel = self.teacherZaiXianDetailsModel;
    ShiPinListViewController *vc2 = [[ShiPinListViewController alloc]init];
    vc2.teacherZaiXianDetailsModel = self.teacherZaiXianDetailsModel;
    NSArray *childVC = [NSArray arrayWithObjects:vc1,vc2, nil];
    return childVC;
}

#pragma mark - getter
- (JohnTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}

-(void)viewDidDisappear:(BOOL)animated {
    [_playerView destroyPlayer];
    _playerView = nil;
    [super viewDidDisappear:animated];
    [_player _deallocPlayer];
}

#pragma mark - UIScrollViewDelegate
//返回缩放时所使用的UIView对象
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView;
}

//开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}

//结束缩放时调用，告知缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}

//已经缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}

//确定是否可以滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}

//滚动到顶部时调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
}

//已经滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

//开始进行拖动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

//抬起手指停止拖动时调用，布尔值确定滚动到最后位置时是否需要减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

//如果上面的方法决定需要减速继续滚动，则调用该方法，可以读取contentOffset属性，判断用户抬手位置（不是最终停止位置）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

//减速完毕停止滚动时调用，这里的读取contentOffset属性就是最终停止位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
