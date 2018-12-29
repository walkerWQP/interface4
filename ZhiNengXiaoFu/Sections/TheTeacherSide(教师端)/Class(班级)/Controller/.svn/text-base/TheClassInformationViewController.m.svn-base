//
//  TheClassInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TheClassInformationViewController.h"
#import "ClassHomeModel.h"
#import "PublishJobModel.h"

@interface TheClassInformationViewController ()<WPopupMenuDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView    *theClassInformationScrollView;
@property (nonatomic, strong) UIImageView     *backImgView;
@property (nonatomic, strong) UIImageView     *headImgView;
@property (nonatomic, strong) UIView          *bgView;
//班主任
@property (nonatomic, strong) UILabel         *chargeLabel;
@property (nonatomic, strong) UILabel         *chargeNameLabel;
//课任教师
@property (nonatomic, strong) UILabel         *teachersLabel;
@property (nonatomic, strong) UIButton        *teachersBtn;
//班委班干
@property (nonatomic, strong) UILabel         *dryLabel;
@property (nonatomic, strong) UILabel         *dryNameLabel;
//班级人数
@property (nonatomic, strong) UILabel         *numberLabel;
@property (nonatomic, strong) UILabel         *numberPeopleLabel;
//班级寄语
@property (nonatomic, strong) UILabel         *remarkLabel;
@property (nonatomic, strong) UILabel         *remarksLabel;
@property (nonatomic, strong) UIImageView     *userIcon;
@property (nonatomic, assign) NSInteger       hnew;
@property (nonatomic, strong) NSMutableArray  *publishJobArr;
@property (nonatomic, strong) NSMutableArray  *classNameArr;
@property (nonatomic, strong) UIButton        *rightBtn;
@property (nonatomic, strong) NSMutableArray  *buttonArr;
@property (nonatomic, strong) UIWebView       *webView;

@end

@implementation TheClassInformationViewController

- (NSMutableArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
        [self getClassURLData];
    } else {
        [self setNetWork:@""];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    self.view.backgroundColor = backColor;
    self.title = @"班级信息";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    } else {
        
    }
}



- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击选择班级");
    [self getClassURLDataForClassID];
}

- (void)getClassURLDataForClassID {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.classNameArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
            }
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
            }
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    if (self.classNameArr.count != 0) {
        PublishJobModel *model = [self.classNameArr objectAtIndex:index];
        if (model.ID == nil) {
            [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
        } else {
            self.ID = model.ID;
            [self setNetWork:self.ID];
        }
    }
}

- (void)setNetWork:(NSString *)classID {
    NSDictionary * dic = [NSDictionary dictionary];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
        dic = @{@"key":[UserManager key], @"class_id":classID};
    }else {
        dic = @{@"key":[UserManager key]};
    }
    
    [[HttpRequestManager sharedSingleton] POST:userClassInfo parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            ClassHomeModel * model = [ClassHomeModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self makeTheClassInformationViewControllerUI:model];
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


- (void)getClassURLData {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }

            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                if (ary.count == 0) {
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                } else {
                    self.ID = ary[0];
                    [self setNetWork:self.ID];
                }
            }
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)makeTheClassInformationViewControllerUI:(ClassHomeModel *)model {
    
    self.view.backgroundColor = backColor;
    self.backImgView.hidden = YES;
    self.backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH - APP_NAVH)];
    self.backImgView.backgroundColor = backColor;
    self.backImgView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:self.backImgView];
    
    self.headImgView.hidden = YES;
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, APP_WIDTH - 80, 60)];
    self.headImgView.image = [UIImage imageNamed:@"班级信息"];
    [self.backImgView addSubview:self.headImgView];
    
    self.theClassInformationScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT * 0.2, APP_WIDTH, APP_HEIGHT - APP_NAVH)];
    self.theClassInformationScrollView.backgroundColor = [UIColor clearColor];
    self.theClassInformationScrollView.contentSize = CGSizeMake(APP_WIDTH, APP_HEIGHT);
    self.theClassInformationScrollView.bounces = YES;
    self.theClassInformationScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.theClassInformationScrollView.maximumZoomScale = 2.0;//最多放大到两倍
    self.theClassInformationScrollView.minimumZoomScale = 0.5;//最多缩小到0.5倍
    //设置是否允许缩放超出倍数限制，超出后弹回
    self.theClassInformationScrollView.bouncesZoom = YES;
    //设置委托
    self.theClassInformationScrollView.delegate = self;
    [self.view addSubview:self.theClassInformationScrollView];
   
    self.bgView.hidden = YES;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_HEIGHT * 0.15 )];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self.theClassInformationScrollView addSubview:self.bgView];
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.bgView.frame.size.width - 80) / 2, 10, 80, 80)];
    self.userIcon.layer.cornerRadius = 40;
    self.userIcon.layer.masksToBounds = YES;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.class_head_img]];
    [self.bgView addSubview:self.userIcon];

    self.chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 80, 20)];
    self.chargeLabel.text = @"班级主任:";
    self.chargeLabel.textColor = [UIColor blackColor];
    self.chargeLabel.font = titFont;
    [self.bgView addSubview:self.chargeLabel];
    
    self.chargeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chargeLabel.frame.size.width + 30, 120, 200, 20)];
    self.chargeNameLabel.text = model.adviser_name;
    self.chargeNameLabel.textColor = [UIColor blackColor];
    self.chargeNameLabel.font = titFont;
    self.chargeNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.chargeNameLabel];
    
    self.teachersLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y + 10, self.chargeLabel.frame.size.width, 20)];
    self.teachersLabel.text = @"科任老师:";
    self.teachersLabel.textColor = [UIColor blackColor];
    self.teachersLabel.font = titFont;
    [self.bgView addSubview:self.teachersLabel];
    
    self.bgView.userInteractionEnabled = YES;
    self.backImgView.userInteractionEnabled = YES;
    
    for (int i = 0; i < model.teachers.count; i++ ) {
        self.teachersBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.teachersLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y  + 10 * (i + 1) + 20 * (i), 200, 20)];
        NSDictionary * dic = [model.teachers objectAtIndex:i];
        if ([[dic objectForKey:@"teacher_mobile"] isEqualToString:@""] || [dic objectForKey:@"teacher_mobile"] == nil) {
            [self.teachersBtn setTitle:[NSString stringWithFormat:@"(%@) %@",[dic objectForKey:@"course_name"],[dic objectForKey:@"teacher_name"]] forState:UIControlStateNormal];
        } else {
            [self.teachersBtn setTitle:[NSString stringWithFormat:@"(%@) %@-%@",[dic objectForKey:@"course_name"],[dic objectForKey:@"teacher_name"], [dic objectForKey:@"teacher_mobile"]] forState:UIControlStateNormal];
        }
        
        self.teachersBtn.tag = i;
        [self.buttonArr addObject:self.teachersBtn];
        //.text = [NSString stringWithFormat:];
        [self.teachersBtn addTarget:self action:@selector(teachersBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.teachersBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.teachersBtn.titleLabel.font = titFont;
        self.teachersBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.teachersBtn.userInteractionEnabled = YES;
        [self.bgView addSubview:self.teachersBtn];

    }
    self.hnew = self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y + 30 * model.teachers.count;
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.hnew + 10, self.chargeLabel.frame.size.width, 20)];
    self.numberLabel.text = @"班级人数:";
    self.numberLabel.textColor = [UIColor blackColor];
    self.numberLabel.font = titFont;
    [self.bgView addSubview:self.numberLabel];

    self.numberPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.numberLabel.frame.size.width + 30, self.hnew + 10, self.teachersBtn.frame.size.width, 20)];
    self.numberPeopleLabel.text = [NSString stringWithFormat:@"%ld人", model.num];
    self.numberPeopleLabel.textColor = [UIColor blackColor];
    self.numberPeopleLabel.font = titFont;
    [self.bgView addSubview:self.numberPeopleLabel];

    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.numberLabel.frame.origin.y + self.numberLabel.frame.size.height + 10, self.chargeLabel.frame.size.width, 20)];
    self.remarkLabel.text = @"班级寄语:";
    self.remarkLabel.textColor = [UIColor blackColor];
    self.remarkLabel.font = titFont;
    [self.bgView addSubview:self.remarkLabel];

    self.remarksLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.remarkLabel.frame.size.width + 30,  self.remarkLabel.frame.origin.y , self.bgView.frame.size.width - self.remarkLabel.frame.size.width - 50, 180)];
    self.remarksLabel.text = model.message;
    self.remarksLabel.textColor = [UIColor blackColor];
    self.remarksLabel.font = titFont;
    self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarksLabel.numberOfLines = 0;
    self.remarksLabel.isTop = YES;
    [self.bgView addSubview:self.remarksLabel];
    
}

- (void)teachersBtn:(UIButton *)sender {
    NSArray *array = [sender.titleLabel.text componentsSeparatedByString:@"-"];//从字符-中分隔成2个元素的数组
    if([sender.titleLabel.text rangeOfString:@"-"].location !=NSNotFound) {
        NSString *nameStr = array[0];
        NSString *phoneStr = array[1];
        if ([phoneStr isEqualToString:@""] || phoneStr == nil) {
            [WProgressHUD showErrorAnimatedText:@"暂无电话"];
        } else {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要拨打%@的电话吗?",nameStr] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *alertT = [UIAlertAction actionWithTitle:phoneStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (self.webView == nil) {
                    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                }
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneStr]]]];
            }];
            UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            [actionSheet addAction:alertT];
            [actionSheet addAction:alertF];
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
    } else {
        NSLog(@"no");
    }
}

#pragma mark - UIScrollViewDelegate
//返回缩放时所使用的UIView对象
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView;
}

//开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}

//结束缩放时调用，告知缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}

//已经缩放时调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

//确定是否可以滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

//滚动到顶部时调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
}

//已经滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

//开始进行拖动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

//抬起手指停止拖动时调用，布尔值确定滚动到最后位置时是否需要减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

//如果上面的方法决定需要减速继续滚动，则调用该方法，可以读取contentOffset属性，判断用户抬手位置（不是最终停止位置）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

//减速完毕停止滚动时调用，这里的读取contentOffset属性就是最终停止位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}


@end

