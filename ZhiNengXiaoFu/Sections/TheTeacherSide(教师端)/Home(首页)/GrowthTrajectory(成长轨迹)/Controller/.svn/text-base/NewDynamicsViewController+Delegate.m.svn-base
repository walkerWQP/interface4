//
//  NewDynamicsViewController+Delegate.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/9/5.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "NewDynamicsViewController+Delegate.h"
#import "DynamicsModel.h"


@implementation NewDynamicsViewController (Delegate)

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewDynamicsLayout *layout = self.layoutsArr[indexPath.row];
    return layout.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layoutsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewDynamicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewDynamicsTableViewCell"];
    NewDynamicsLayout *layout = [self.layoutsArr objectAtIndex:indexPath.row];
    DynamicsModel * model = layout.model;
    if (self.layoutsArr.count == 0) {
        return cell;
    } else { //隐藏删除按钮
        if (model.is_myself == 0) {
            cell.layout = self.layoutsArr[indexPath.row];
            cell.deleteBtn.hidden = YES;
            cell.delegate = self;
            return cell;
        } else {
            cell.deleteBtn.hidden = NO;
            cell.layout = self.layoutsArr[indexPath.row];
            cell.delegate = self;
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [JRMenuView dismissAllJRMenu];
}

#pragma mark - ScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [JRMenuView dismissAllJRMenu];//收回JRMenuView
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.commentInputTF resignFirstResponder];
}

#pragma mark - NewDynamiceCellDelegate
-(void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUser:(NSString *)userId {
    NSLog(@"点击了用户");
}

- (void)DidClickMoreLessInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    layout.model.isOpening = !layout.model.isOpening;
    [layout resetLayout];
    CGRect cellRect = [self.dynamicsTable rectForRowAtIndexPath:indexPath];
    [self.dynamicsTable reloadData];
    if (cellRect.origin.y < self.dynamicsTable.contentOffset.y + 64) {
        [self.dynamicsTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}


-(void)DidClickGrayViewInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    NSLog(@"点击了灰色区域");
}


#pragma mark - 点击点赞
-(void)DidClickThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell {
   
    NSLog(@"点击点赞");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    NSIndexPath *indexPath = [self.dynamicsTable indexPathForCell:cell];
    self.commentIndexPath = indexPath;

    NewDynamicsLayout *layout = self.layoutsArr[indexPath.row];
    DynamicsModel *model = layout.model;
    
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    //PraiseURL
    NSDictionary *dataDic = @{@"key":[UserManager key],@"album_id":[NSString stringWithFormat:@"%ld",model.album_id]};
    [[HttpRequestManager sharedSingleton] POST:PraiseURL parameters:dataDic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            NSInteger commentRow = self.commentIndexPath.row;
            NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
            DynamicsModel * model = layout.model;
            model.isThumb = YES;
            NSDictionary *dic = [responseObject objectForKey:@"data"];
             NSMutableArray *arr = [DynamicsLikeItemModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"praise"]];
            model.likeArr = [arr copy];
            [layout resetLayout];
            [self.dynamicsTable reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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


#pragma mark - 取消点赞
- (void)DidClickCancelThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    NSLog(@"取消点赞");
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    
    self.commentIndexPath = indexPath;
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    DynamicsModel * model = layout.model;
    
    [WProgressHUD showHUDShowText:@"正在加载中..."];
    //PraiseURL
    NSDictionary *dataDic = @{@"key":[UserManager key],@"album_id":[NSString stringWithFormat:@"%ld",model.album_id]};
    [[HttpRequestManager sharedSingleton] POST:PraiseURL parameters:dataDic success:^(NSURLSessionDataTask *task, id responseObject) {
        [WProgressHUD hideAllHUDAnimated:YES];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            NSInteger commentRow = self.commentIndexPath.row;
            NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
            DynamicsModel * model = layout.model;
            model.isThumb = NO;
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSMutableArray *arr = [DynamicsLikeItemModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"praise"]];
            model.likeArr = [arr copy];
            [layout resetLayout];
            [self.dynamicsTable reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [WProgressHUD hideAllHUDAnimated:YES];
    }];
    
}


-(void)DidClickCommentInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    self.commentIndexPath = indexPath;
    self.commentInputTF.placeholder = @"输入评论...";
    [self.commentInputTF becomeFirstResponder];
    self.commentInputTF.hidden = NO;
}


-(void)DidClickSpreadInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    NSLog(@"点击了推广");
}


#pragma mark - 删除
- (void)DidClickDeleteInDynamicsCell:(NewDynamicsTableViewCell *)cell {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        return;
    }
    
    WS(weakSelf);
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"确定删除该条成长相册吗?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
            NSIndexPath * indexPath1 = [self.dynamicsTable indexPathForCell:cell];
            NewDynamicsLayout * layout = self.layoutsArr[indexPath1.row];
            DynamicsModel * model = layout.model;
            NSDictionary *dic = @{@"key":[UserManager key], @"album_id":[NSString stringWithFormat:@"%ld",model.album_id]};
            [WProgressHUD showHUDShowText:@"正在删除中..."];
            [[HttpRequestManager sharedSingleton] POST:DeleteAlbumURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    
                    [WProgressHUD showSuccessfulAnimatedText:@"删除成功!"];
                    [weakSelf.dynamicsTable beginUpdates];
                    [weakSelf.layoutsArr removeObjectAtIndex:indexPath.row];
                    [weakSelf.dynamicsTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf.dynamicsTable endUpdates];
                    [WProgressHUD hideAllHUDAnimated:YES];
                } else {
                    if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                        [UserManager logoOut];
                    } else {
                        
                    }
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [WProgressHUD hideAllHUDAnimated:YES];
            }];
        }
    }];
}



- (void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUrl:(NSString *)url PhoneNum:(NSString *)phoneNum {
    if (url) {
        if ([url rangeOfString:@"wemall"].length != 0 || [url rangeOfString:@"t.cn"].length != 0) {
            if (![url hasPrefix:@"http://"]) {
                url = [NSString stringWithFormat:@"http://%@",url];
            }
            NSLog(@"点击了链接:%@",url);
        }else{
            [WProgressHUD showErrorAnimatedText:@"暂不支持打开外部链接"];
        }
    }
    if (phoneNum) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要拨打的电话吗?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *alertT = [UIAlertAction actionWithTitle:phoneNum style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.webView == nil) {
                self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]]]];
            
        }];
        
        UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        
        [actionSheet addAction:alertT];
        [actionSheet addAction:alertF];
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}

- (void)DidClickChatInDynamicsCell:(NewDynamicsTableViewCell *)cell { 
    
}


- (void)DidClickShareInDynamicsCell:(NewDynamicsTableViewCell *)cell { 
    
}

#pragma mark ======= 删除该条数据 =======
- (void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickComment:(DynamicsCommentItemModel *)commentModel {
    
    NSInteger commentRow = self.commentIndexPath.row;
    NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
    DynamicsModel * model = layout.model;
    
    if ([[NSString stringWithFormat:@"%ld",commentModel.discuss_is_self] isEqualToString:@"1"]) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"确定要删除该条评论吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [WProgressHUD showHUDShowText:@"正在删除中..."];
            NSDictionary *dic = @{@"key":[UserManager key],@"album_id":[NSString stringWithFormat:@"%ld",model.album_id],@"discuss_id":commentModel.discuss_id};
            [[HttpRequestManager sharedSingleton] POST:DeleteDiscussURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                [WProgressHUD hideAllHUDAnimated:YES];
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                    NSInteger commentRow = self.commentIndexPath.row;
                    NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
                    DynamicsModel * model = layout.model;
                    NSMutableArray *arr = [DynamicsCommentItemModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
                    
                    model.optcomment = [arr copy];
                    [layout resetLayout];
                    
                    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
                    self.commentIndexPath = indexPath;
                    
                    [self.dynamicsTable reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                } else {
                    if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                        [UserManager logoOut];
                    } else {
                        
                    }
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [WProgressHUD hideAllHUDAnimated:YES];
            }];
            
        }];
        
        UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        [actionSheet addAction:alertT];
        [actionSheet addAction:alertF];
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
}

#pragma mark ======= 评论 =======
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"]) {
        [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
        
    } else {
    
    NSInteger commentRow = self.commentIndexPath.row;
    NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
    DynamicsModel * model = layout.model;
    if (![self.commentInputTF.text isEqualToString:@""]) {
#pragma mark ======= 上传评论 =======
        [WProgressHUD showHUDShowText:@"正在加载中..."];
        NSDictionary *dataDic = @{@"key":[UserManager key],@"album_id":[NSString stringWithFormat:@"%ld",model.album_id],@"content":self.commentInputTF.text};
        [[HttpRequestManager sharedSingleton] POST:AddDiscussURL parameters:dataDic success:^(NSURLSessionDataTask *task, id responseObject) {
            [WProgressHUD hideAllHUDAnimated:YES];
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                NSInteger commentRow = self.commentIndexPath.row;
                NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
                DynamicsModel * model = layout.model;
                NSMutableArray *arr = [DynamicsCommentItemModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
                
                model.optcomment = [arr copy];
                [layout resetLayout];
                [self.dynamicsTable reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                } else {
                    
                }
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [WProgressHUD hideAllHUDAnimated:YES];
        }];
        
      }
        
    }
    self.commentInputTF.text = nil;
    [self.commentInputTF resignFirstResponder];
    return YES;
    
}


@end
