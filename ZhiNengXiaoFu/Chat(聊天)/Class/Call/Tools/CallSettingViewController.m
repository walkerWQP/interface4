//
//  CallSettingViewController.m
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 06/12/2016.
//  Copyright © 2016 XieYajie. All rights reserved.
//

#import "CallSettingViewController.h"

#import "DemoCallManager.h"
#import "CallResolutionViewController.h"

#define FIXED_BITRATE_ALERTVIEW_TAG 100
#define AUTO_MAXRATE_ALERTVIEW_TAG 99
#define AUTO_MINKBPS_ALERTVIEW_TAG 98

@interface CallSettingViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) UISwitch *callPushSwitch;
@property (strong, nonatomic) UISwitch *showCallInfoSwitch;

@property (nonatomic, strong) UISwitch *cameraSwitch;
@property (nonatomic, strong) UISwitch *fixedSwitch;

@end

@implementation CallSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"音视频设置";
    
    self.fixedSwitch = [[UISwitch alloc] init];
    [self.fixedSwitch addTarget:self action:@selector(fixedSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    CGRect frame = self.fixedSwitch.frame;
    frame.origin.x = self.view.frame.size.width - 10 - frame.size.width;
    frame.origin.y = 10;
    self.fixedSwitch.frame = frame;
    
    EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
    [self.fixedSwitch setOn:options.isFixedVideoResolution animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISwitch *)callPushSwitch
{
    if (_callPushSwitch == nil) {
        _callPushSwitch = [self _setupSwitchWithAction:@selector(callPushChanged:)];
        
        EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
        [_callPushSwitch setOn:options.isSendPushIfOffline animated:NO];
    }
    
    return _callPushSwitch;
}

- (UISwitch *)showCallInfoSwitch
{
    if (_showCallInfoSwitch == nil) {
        _showCallInfoSwitch = [self _setupSwitchWithAction:@selector(showCallInfoChanged:)];
        
        _showCallInfoSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"showCallInfo"] boolValue];
    }
    
    return _showCallInfoSwitch;
}

- (UISwitch *)cameraSwitch
{
    if (_cameraSwitch == nil) {
        _cameraSwitch = [self _setupSwitchWithAction:@selector(cameraSwitchValueChanged:)];
        
        _cameraSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"em_IsUseBackCamera"] boolValue];
    }
    
    return _cameraSwitch;
}

#pragma mark - Subviews

- (UISwitch *)_setupSwitchWithAction:(SEL)aAction
{
    UISwitch *retSwitch = [[UISwitch alloc] init];
    [retSwitch addTarget:self action:aAction forControlEvents:UIControlEventValueChanged];
    
    CGRect frame = retSwitch.frame;
    frame.origin.x = self.view.frame.size.width - 10 - frame.size.width;
    frame.origin.y = 10;
    retSwitch.frame = frame;
    
    return retSwitch;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) {
        count = 2;
    } else if (section == 1) {
        count = 1;
    } else if (section == 2) {
        count = 4;
    }
    
    return count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = @"";
    if (section == 0) {
        str = @"1v1设置";
    } else if (section == 1) {
        str = @"多人设置";
    } else if (section == 2) {
        str = @"通用设置";
    }
    
    return str;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"是否发送离线推送";
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.contentView addSubview:self.callPushSwitch];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"显示视频通话信息";
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.contentView addSubview:self.showCallInfoSwitch];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"默认使用后置摄像头";
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.contentView addSubview:self.cameraSwitch];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            cell.textLabel.text = @"固定视频分辨率";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"视频最大码率";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (self.fixedSwitch.isOn) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"视频最小码率";
                [cell.contentView addSubview:self.fixedSwitch];
            } else if (indexPath.row == 3) {
                cell.textLabel.text = @"视频分辨率";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"自动调配视频分辨率";
                [cell.contentView addSubview:self.fixedSwitch];
            } else if (indexPath.row == 3) {
                cell.textLabel.text = @"视频最大帧率";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"视频分辨率最大?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            alert.tag = FIXED_BITRATE_ALERTVIEW_TAG;
            
            UITextField *textField = [alert textFieldAtIndex:0];
            EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
            textField.text = [NSString stringWithFormat:@"%ld", options.maxVideoKbps];
            
            [alert show];
        } else if (indexPath.row == 2) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"视频最小分辨率?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            alert.tag = AUTO_MINKBPS_ALERTVIEW_TAG;
            
            UITextField *textField = [alert textFieldAtIndex:0];
            EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
            textField.text = [NSString stringWithFormat:@"%d", options.minVideoKbps];
            
            [alert show];
        }
        if (self.fixedSwitch.isOn) {
             if (indexPath.row == 3) {
                CallResolutionViewController *resoulutionController = [[CallResolutionViewController alloc] init];
                [self.navigationController pushViewController:resoulutionController animated:YES];
            }
        } else {
            if (indexPath.row == 3) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"视频最大帧速率" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                alert.tag = AUTO_MAXRATE_ALERTVIEW_TAG;
                
                UITextField *textField = [alert textFieldAtIndex:0];
                EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
                textField.text = [NSString stringWithFormat:@"%d", options.maxVideoFrameRate];
                
                [alert show];
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate

//弹出提示的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
#if DEMO_CALL == 1
    if ([alertView cancelButtonIndex] != buttonIndex) {
        //获取文本输入框
        UITextField *textField = [alertView textFieldAtIndex:0];
        int value = 0;
        if ([textField.text length] > 0) {
            value = [textField.text intValue];
        }

        if (alertView.tag == FIXED_BITRATE_ALERTVIEW_TAG) {
            if ((value >= 150 && value <= 1000) || value == 0) {
                EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
                options.maxVideoKbps = value;
                [[DemoCallManager sharedManager] saveCallOptions];
            } else {
                [self showHint:@"视频分辨率150-1000"];
            }
        } else if (alertView.tag == AUTO_MAXRATE_ALERTVIEW_TAG) {
            EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
            options.maxVideoFrameRate = value;
            [[DemoCallManager sharedManager] saveCallOptions];
        } else if (alertView.tag == AUTO_MINKBPS_ALERTVIEW_TAG) {
            EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
            options.minVideoKbps = value;
            [[DemoCallManager sharedManager] saveCallOptions];
        }
    }
#endif
}

#pragma mark - Action

- (void)fixedSwitchValueChanged:(UISwitch *)control
{
    [self.tableView reloadData];
    
#if DEMO_CALL == 1
    EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
    options.isFixedVideoResolution = control.on;
    [[DemoCallManager sharedManager] saveCallOptions];
    
#endif
}

- (void)showCallInfoChanged:(UISwitch *)control
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:control.isOn] forKey:@"showCallInfo"];
    [userDefaults synchronize];
}

- (void)callPushChanged:(UISwitch *)control
{
#if DEMO_CALL == 1
    EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
    options.isSendPushIfOffline = control.on;
    [[DemoCallManager sharedManager] saveCallOptions];
#endif
}

- (void)cameraSwitchValueChanged:(UISwitch *)control
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:control.isOn] forKey:@"em_IsUseBackCamera"];
    [userDefaults synchronize];
}

@end
