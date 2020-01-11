//
//  InfomationViewController.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/20.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InfomationViewController.h"
#import "InfomationBLL.h"
#import "InformationListCell.h"
#import "InfomationDetailVC.h"
#import "InfomationBLL.h"
#import "InfomationListModel.h"

@interface InfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
/** list */
@property (nonatomic, strong) NSMutableArray *listArray;
/** tabv */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger page;
@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.tableView.backgroundColor = [UIColor clearColor];
    label.text = AppLanguageStringWithKey(@"资讯");
    label.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.navigationItem.titleView = label;
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getListData:1];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getListData:weakSelf.page+1];
    }];
    
    [self getListData:1];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [InformationListCell initCell:tableView cellName:@"InformationListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [InformationListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfomationDetailVC *detail = [[UIStoryboard storyboardWithName:@"Infomation" bundle:nil] instantiateViewControllerWithIdentifier:@"InfomationDetailVC"];
    InfomationListModel *model = [self.listArray objectAtIndex:indexPath.row];
    detail.inf_id = model.info_id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)getListData:(NSInteger)page {
    
    [self loading];
    [[InfomationBLL sharedInfomationBLL] executeTaskWithDic:@{@"page":[NSString stringWithFormat:@"%ld",page]} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"articles/news" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        [self.tableView.mj_header endRefreshing];
        if (page == 1) {
            
            [self.listArray removeAllObjects];
            self.page = 1;
        } else {
            self.page ++;
        }
        NSArray *infoArray = resultDic[@"data"];
        for (NSDictionary *dic in infoArray) {
            
            InfomationListModel *model = [[InfomationListModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        NSInteger last_page = [resultDic[@"meta"][@"last_page"] integerValue];
        if (self.page == last_page) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
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
