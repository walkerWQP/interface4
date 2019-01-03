//
//  EMGroupInfoViewController.m
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 08/03/2017.
//  Copyright © 2017 XieYajie. All rights reserved.
//

#import "EMGroupInfoViewController.h"

#import <Hyphenate/EMGroup.h>
#import "EMMemberCell.h"
#import "GroupSubjectChangingViewController.h"
#import "EMGroupAdminsViewController.h"
#import "EMGroupMutesViewController.h"
#import "EMGroupBansViewController.h"
#import "EMGroupMembersViewController.h"
#import "EMGroupTransferOwnerViewController.h"
#import "ContactSelectionViewController.h"
#import "GroupSettingViewController.h"
#import "EMGroupSharedFilesViewController.h"

#import "EMDingMessageHelper.h"

@interface EMGroupInfoViewController ()<EMChooseViewDelegate>

@property (nonatomic, strong) EMGroup *group;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSArray *showMembers;

@property (nonatomic, strong) UIBarButtonItem *addItem;

@property (nonatomic) NSInteger moreCellIndex;
@property (nonatomic, strong) UITableViewCell *moreCell;

@property (nonatomic, strong) UIButton *leaveButton;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation EMGroupInfoViewController

- (instancetype)initWithGroupId:(NSString *)aGroupId
{
    self = [super init];
    if (self) {
        _groupId = aGroupId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"UpdateGroupDetail" object:nil];
    
    [self _setupNavigationBar];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    self.tableView.rowHeight = 60;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.sectionIndexBackgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = self.footerView;
    
    [self fetchGroupInfo];
    
    [self reloadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Bar

- (void)_setupNavigationBar
{
    self.title = @"群详情";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [addButton addTarget:self action:@selector(addMemberAction) forControlEvents:UIControlEventTouchUpInside];
    self.addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
}

#pragma mark - Subviews

- (UITableViewCell *)moreCell
{
    if (_moreCell == nil) {
        _moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonCell"];
        _moreCell.contentView.backgroundColor = [UIColor colorWithRed: 249 / 255.0 green: 250 / 255.0 blue: 251 / 255.0 alpha:1.0];
        
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
        [moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(moreMemberAction) forControlEvents:UIControlEventTouchUpInside];
        [_moreCell.contentView addSubview:moreButton];
    }
    
    return _moreCell;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, _footerView.frame.size.width - 40, 40)];
        clearButton.accessibilityIdentifier = @"clear_message";
        [clearButton setTitle:@"清空聊天记录" forState:UIControlStateNormal];
        [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearMessagesAction) forControlEvents:UIControlEventTouchUpInside];
        [clearButton setBackgroundColor:[UIColor greenColor]];
        [_footerView addSubview:clearButton];
        
        _leaveButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, _footerView.frame.size.width - 40, 40)];
        _leaveButton.accessibilityIdentifier = @"leave";
        [_leaveButton setTitle:@"解散群组" forState:UIControlStateNormal];
        [_leaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leaveButton addTarget:self action:@selector(leaveAction) forControlEvents:UIControlEventTouchUpInside];
        [_leaveButton setBackgroundColor:[UIColor colorWithRed:191 / 255.0 green:48 / 255.0 blue:49 / 255.0 alpha:1.0]];
        [_footerView addSubview:_leaveButton];
    }
    
    return _footerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) {
        count = [self.group.adminList count];
        if (count > 2) {
            count = 3;
        } else {
            count += 1;
        }
    } else if(section == 1) {
        count = [self.showMembers count];
        if (count > 3) {
            count = 4;
        } else {
            count += 1;
        }
        
        self.moreCellIndex = count - 1;
    } else if (section == 2) {
        if (self.group.permissionType == EMGroupPermissionTypeOwner || self.group.permissionType == EMGroupPermissionTypeAdmin) {
            count = 10;
        } else {
            count = 8;
        }
    } else if (section == 3) {
        count = 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 1 && row == self.moreCellIndex) {
        return self.moreCell;
    }
    
    if (section == 0 || section == 1) {
        EMMemberCell *memberCell = (EMMemberCell *)[tableView dequeueReusableCellWithIdentifier:@"EMMemberCell"];
        if (memberCell == nil) {
            memberCell = [[[NSBundle mainBundle] loadNibNamed:@"EMMemberCell" owner:self options:nil] lastObject];
        }
        
        memberCell.imgView.image = [UIImage imageNamed:@"default_avatar"];
        memberCell.rightLabel.text = @"";
        
        if (section == 0) {
            if (row == 0) {
                memberCell.leftLabel.text = self.group.owner;
                memberCell.rightLabel.text = @"群主";
            } else {
                memberCell.leftLabel.text = [self.group.adminList objectAtIndex:(row - 1)];
                memberCell.rightLabel.text = @"成员";
            }
        } else if (section == 1) {
            memberCell.leftLabel.text = [self.showMembers objectAtIndex:row];
        }
        
        return memberCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (section == 2) {
        switch (row) {
            case 0:
                cell.textLabel.text = @"群组ID";
                cell.detailTextLabel.text = self.groupId;
                break;
            case 1:
                cell.textLabel.text = @"群设置";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 2:
                cell.textLabel.text = @"改变群主";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                cell.textLabel.text = @"修改群名称";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 4:
                cell.textLabel.text = @"管理员列表";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 5:
                cell.textLabel.text = @"群公告";
                cell.detailTextLabel.text = _group.announcement;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 6:
                cell.textLabel.text = @"群扩展消息";
                cell.detailTextLabel.text = _group.setting.ext;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 7:
                cell.textLabel.text = @"群共享列表";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 8:
                cell.textLabel.text = @"黑名单列表";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 9:
                cell.textLabel.text = @"禁言列表";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
    } else if (section == 3 && row == 0) {
        cell.textLabel.text = @"发送群通知消息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    headerLabel.backgroundColor = [UIColor colorWithRed: 157 / 255.0 green: 170 / 255.0 blue: 179 / 255.0 alpha:1.0];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    if (section == 0) {
        headerLabel.text = [NSString stringWithFormat:@"群主/管理员"];
    } else if (section == 1) {
        headerLabel.text = [NSString stringWithFormat:@"普通成员"];
    } else if (section == 2) {
        headerLabel.text = [NSString stringWithFormat:@"设置"];
    } else if (section == 3) {
        headerLabel.text = [NSString stringWithFormat:@"扩展功能"];
    }
    
    return headerLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    if (section == 0 || section == 1) {
        return;
    }
    
    if (section == 3 && indexPath.row == 0) {
        [self.navigationController popViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_DingAction object:nil];
        return;
    }
    
    NSInteger row = indexPath.row;
    switch (row) {
        case 1:
        {
            GroupSettingViewController *settingController = [[GroupSettingViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:settingController animated:YES];
        }
            break;
        case 2:
        {
            if (self.group.permissionType == EMGroupPermissionTypeOwner) {
                EMGroupTransferOwnerViewController *transferController = [[EMGroupTransferOwnerViewController alloc] initWithGroup:self.group];
                [self.navigationController pushViewController:transferController animated:YES];
            } else {
                [self showHint:NSLocalizedString(@"group.onlyOwner", nil)];
            }
        }
            break;
        case 3:
        {
            GroupSubjectChangingViewController *changingController = [[GroupSubjectChangingViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:changingController animated:YES];
        }
            break;
        case 4:
        {
            EMGroupAdminsViewController *adminController = [[EMGroupAdminsViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:adminController animated:YES];

        }
            break;
        case 5:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改群公告" message:nil preferredStyle:UIAlertControllerStyleAlert];
            __weak typeof(self) weakSelf = self;
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *announcement = nil;
                if ([alert.textFields count] > 0) {
                    announcement = alert.textFields.firstObject.text;
                }
                [weakSelf showHudInView:weakSelf.view hint:[NSString stringWithFormat:@"%@...",@"更改群公告"]];
                [[EMClient sharedClient].groupManager updateGroupAnnouncementWithId:weakSelf.groupId announcement:announcement completion:^(EMGroup *aGroup, EMError *aError) {
                    [weakSelf hideHud];
                    if (aError) {
                        [weakSelf showHint:[NSString stringWithFormat:@"%@%@",@"更改公告失败", aError.errorDescription]];
                    } else {
                        [weakSelf.tableView reloadData];
                    }
                }];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入群公告";
                textField.text = self->_group.announcement;
            }];
            [self presentViewController:alert animated:YES completion:NULL];
        }
            break;
        case 6:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改群扩展信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            __weak typeof(self) weakSelf = self;
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *announcement = nil;
                if ([alert.textFields count] > 0) {
                    announcement = alert.textFields.firstObject.text;
                }
                [weakSelf showHudInView:weakSelf.view hint:[NSString stringWithFormat:@"%@...",@"修改群扩展信息"]];
                [[EMClient sharedClient].groupManager updateGroupExtWithId:weakSelf.groupId ext:announcement completion:^(EMGroup *aGroup, EMError *aError) {
                    [weakSelf hideHud];
                    if (aError) {
                        [weakSelf showHint:[NSString stringWithFormat:@"%@%@",@"更改群扩展失败", aError.errorDescription]];
                    } else {
                        [weakSelf.tableView reloadData];
                    }
                }];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入群扩展信息";
                textField.text = self->_group.setting.ext;
            }];
            [self presentViewController:alert animated:YES completion:NULL];
        }
            break;
        case 7:
        {
            EMGroupSharedFilesViewController *sharedFileController = [[EMGroupSharedFilesViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:sharedFileController animated:YES];
        }
            break;
        case 8:
        {
            EMGroupBansViewController *bansController = [[EMGroupBansViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:bansController animated:YES];
        }
            break;
        case 9:
        {
            EMGroupMutesViewController *mutesController = [[EMGroupMutesViewController alloc] initWithGroup:self.group];
            [self.navigationController pushViewController:mutesController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - EMChooseViewDelegate

- (BOOL)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
{
    NSInteger maxUsersCount = self.group.setting.maxUsersCount;
    if (([selectedSources count] + self.group.occupantsCount) > maxUsersCount) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"群成员数超过限额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return NO;
    }
    
    [self showHudInView:self.view hint:@"添加一个群成员..."];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *source = [NSMutableArray array];
        for (NSString *username in selectedSources) {
            [source addObject:username];
        }
        
        NSString *username = [[EMClient sharedClient] currentUsername];
        NSString *messageStr = [NSString stringWithFormat:@"%@邀请你加入小组%@", username, weakSelf.group.subject];
        EMError *error = nil;
        weakSelf.group = [[EMClient sharedClient].groupManager addOccupants:source toGroup:weakSelf.group.groupId welcomeMessage:messageStr error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (!error) {
                [weakSelf.tableView reloadData];
            }
            else {
                [weakSelf showHint:error.errorDescription];
            }
            
        });
    });
    
    return YES;
}

#pragma mark - Action

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addMemberAction
{
    NSMutableArray *occupants = [[NSMutableArray alloc] init];
    [occupants addObject:self.group.owner];
    [occupants addObjectsFromArray:self.group.adminList];
    [occupants addObjectsFromArray:self.group.memberList];
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] initWithBlockSelectedUsernames:occupants];
    selectionController.delegate = self;
    [self.navigationController pushViewController:selectionController animated:YES];
}

- (void)moreMemberAction
{
    EMGroupMembersViewController *membersController = [[EMGroupMembersViewController alloc] initWithGroup:self.group];
    [self.navigationController pushViewController:membersController animated:YES];
}

- (void)clearMessagesAction
{
    __weak typeof(self) weakSelf = self;
    [EMAlertView showAlertWithTitle:@"提示"
                            message:@"请确定删除"
                    completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                        if (buttonIndex == 1) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATIONNAME_DELETEALLMESSAGE object:weakSelf.groupId];
                        }
                    } cancelButtonTitle:@"取消"
                  otherButtonTitles:@"确定", nil];
}

- (void)leaveAction
{
    __weak typeof(self) weakSelf = self;
    if (self.group.permissionType == EMGroupPermissionTypeOwner) {
        [self showHudInView:self.view hint:@"解散群"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
            EMError *error = [[EMClient sharedClient].groupManager destroyGroup:weakSelf.group.groupId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                if (error) {
                    [weakSelf showHint:@"解散群失败"];
                }
                else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
                }
            });
        });
        
    } else {
        [self showHudInView:self.view hint:@"退出群"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
            EMError *error = nil;
            [[EMClient sharedClient].groupManager leaveGroup:weakSelf.group.groupId error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                if (error) {
                    [weakSelf showHint:@"退出群失败"];
                }
                else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
                }
            });
        });
    }
}

- (void)updateUI:(NSNotification *)aNotif
{
    id obj = aNotif.object;
    if ([obj isKindOfClass:[EMGroup class]]) {
        EMGroup *group = (EMGroup *)obj;
        if (![group.groupId isEqualToString:self.group.groupId]) {
            return;
        }
        self.group = (EMGroup *)obj;
        
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *groupId = (NSString *)obj;
        if (![groupId isEqualToString:self.group.groupId]) {
            return;
        }
    }
    
    self.showMembers = self.group.memberList;
    [self reloadUI];
}

- (void)reloadUI
{
    self.navigationItem.rightBarButtonItem = nil;
    if (self.group.permissionType == EMGroupPermissionTypeOwner || self.group.permissionType == EMGroupPermissionTypeAdmin || self.group.setting.style == EMGroupStylePrivateMemberCanInvite) {
        self.navigationItem.rightBarButtonItem = self.addItem;
    }
    
    if (self.group.permissionType == EMGroupPermissionTypeOwner) {
        [self.leaveButton setTitle:@"解散群组" forState:UIControlStateNormal];
    } else {
        [self.leaveButton setTitle:@"退出群" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}

#pragma mark - DataSource

- (void)fetchGroupInfo
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:@"加载数据..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        EMError *error = nil;
        EMGroup *group = [[EMClient sharedClient].groupManager getGroupSpecificationFromServerWithId:weakSelf.groupId error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
        });
        
        if (!error) {
            weakSelf.group = group;
            EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:group.groupId type:EMConversationTypeGroupChat createIfNotExist:YES];
            if ([group.groupId isEqualToString:conversation.conversationId]) {
                NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                [ext setObject:group.subject forKey:@"subject"];
                [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                conversation.ext = ext;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf fetchGroupMembers];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showHint:@"未能获取群详细信息，请稍后重试"];
            });
        }
        
    });
    
    [[EMClient sharedClient].groupManager getGroupAnnouncementWithId:_groupId completion:^(NSString *aAnnouncement, EMError *aError) {
        if (!aError) {
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHint:@"未得到通知"];
        }
    }];
}

- (void)fetchGroupMembers
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:@"加载数据..."];
    [[EMClient sharedClient].groupManager getGroupMemberListFromServerWithId:self.groupId cursor:@"" pageSize:10 completion:^(EMCursorResult *aResult, EMError *aError) {
        [weakSelf hideHud];
        if (!aError) {
            weakSelf.showMembers = aResult.list;
            [weakSelf reloadUI];
        } else {
            [weakSelf showHint:@"未能获取群详细信息，请稍后重试"];
        }
    }];
}


@end
