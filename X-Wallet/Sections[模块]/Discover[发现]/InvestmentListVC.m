//
//  InvestmentListVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InvestmentListVC.h"
#import "InvestmentListCell.h"
#import "InvestmentDetailVC.h"
#import "DiscoverBLL.h"
#import "InvestmentListModel.h"

@interface InvestmentListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation InvestmentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"立即投资");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self getListData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InvestmentListCell *cell = [InvestmentListCell initCell:tableView cellName:@"InvestmentListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [InvestmentListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InvestmentDetailVC *detail = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"InvestmentDetailVC"];
    InvestmentListModel *model = [self.listArray objectAtIndex:indexPath.row];
    detail.title = model.name;
    detail.inv_id = model.inv_id;
    detail.isVip = !model.is_vip.boolValue;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)getListData {
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"contract/contracts" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        
        NSArray *array = resultDic[@"data"];
        for (NSDictionary *dic in array) {
            InvestmentListModel *model = [[InvestmentListModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        
        [self.tableView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}

@end
