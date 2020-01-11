//
//  TeamVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "TeamVC.h"
#import "TeamListCell.h"
//models
#import "XWTeamModel.h"

@interface TeamVC ()<UITableViewDelegate,UITableViewDataSource>
/** arr */
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *validNum;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation TeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
//    self.bgImageView.image = [[UIImage imageNamed:@"min_team_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 30.0, 100.0, 100.0) resizingMode:UIImageResizingModeStretch];
    
}

- (void)setListArray:(NSArray *)listArray {
    _listArray = listArray;
    [self.tableView reloadData];
}

- (void)setTotalNumber:(NSInteger)totalNumber {
    _totalNumber = totalNumber;
    _totalNum.text = [NSString stringWithFormat:@"%zd",totalNumber];
}

- (void)setValidNumber:(NSInteger)validNumber {
    _validNumber = validNumber;
    _validNum.text = [NSString stringWithFormat:@"%zd",validNumber];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWTeamUserModel *model = self.listArray[indexPath.row];
    
    TeamListCell *cell = [TeamListCell initCell:tableView cellName:@"TeamListCell" dataObjc:model];
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.user.avatar] placeholderImage:[UIImage imageNamed:@"min_user"]];
    cell.showPhone.text = model.user.nickname;
    if (model.user.is_valid) {
        cell.showType.image = [UIImage imageNamed:@"min_team_use"];
    }
    else {
        cell.showType.image = [UIImage imageNamed:@"min_team_unuse"];
    }
    cell.showLevel.image = [UIImage imageNamed:[NSString stringWithFormat:@"min_level_%zd",model.user.user_level]];
    cell.showAccount.text = [NSString stringWithFormat:@"%@：$%.4f",AppLanguageStringWithKey(@"投资额"),model.user.team_user_money];
    cell.showResult.text = [NSString stringWithFormat:@"$%.4f",model.user.team_money];
    cell.showTime.text = model.updated_at;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TeamListCell tableViewHeight];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
