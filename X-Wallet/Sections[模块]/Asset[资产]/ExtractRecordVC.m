//
//  ExtractRecordVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExtractRecordVC.h"
#import "ExtractRecordCell.h"
//models
#import "XWExtractRecordModel.h"
//views
#import "ExtractAlertView.h"

@interface ExtractRecordVC ()<UITableViewDelegate,UITableViewDataSource>
/** arr */
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExtractRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"提币明细");
    self.tableView.tableFooterView = [UIView new];
    self.listArray = [NSMutableArray array];
    self.tableView.backgroundColor = [UIColor clearColor];
//    [UISet setCornerByRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(6, 6) targetView:self.tableView];
    
    [self p_getList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UISet setCornerByRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(6, 6) targetView:self.tableView viewBounds:self.tableView.bounds];
}

- (void)p_getList {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(AppLanguageStringWithKey(@"加载中"))];
    [NetWork dataTaskWithPath:@"wallet/tibi_log" requestMethod:NetWorkMethodPost version:1 parameters:nil mapModelClass:[XWExtractRecordModel class] responsePath:@"data.data" completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.listArray = responseObject;
            [self.tableView reloadData];
        }
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWExtractRecordModel *model = [self.listArray objectAtIndex:indexPath.row];
    ExtractRecordCell *cell = [ExtractRecordCell initCell:tableView cellName:@"ExtractRecordCell" dataObjc:model];
    cell.titleLab.text = [NSString stringWithFormat:@"%@ %@",model.number,model.currency.name];
    cell.timeLab.text = model.created_at;
    cell.completeBtn.text = model.status_new.info;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ExtractRecordCell tableViewHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XWExtractRecordModel *model = [self.listArray objectAtIndex:indexPath.row];
    ExtractAlertView *alert = [ExtractAlertView showExtractAlertViewWithInfo:[NSString stringWithFormat:@"%@",model.number] address:model.to_address time:model.created_at status:model.status];
    [alert.showImg sd_setImageWithURL:[NSURL URLWithString:model.currency.logo]];
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
