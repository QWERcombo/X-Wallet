//
//  CommunityRecordVC.m
//  X-Wallet
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CommunityRecordVC.h"
#import "DiscoverBLL.h"
#import "CommunityRecordListCell.h"
#import "CommunityRecordModel.h"

@interface CommunityRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;


@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation CommunityRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"明细");
    self.tableView.backgroundColor = [UIColor clearColor];
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getListData:1];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getListData:weakSelf.page+1];
    }];
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self getListData:1];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommunityRecordListCell initCell:tableView cellName:@"CommunityRecordListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


- (void)getListData:(NSInteger)page {
    
    NSString *url = @"";
    NSDictionary *dic = nil;
    if (self.isTeam) {
        /** 团队 */
        url = @"wallet/team_logs";
        dic = @{@"page":[NSString stringWithFormat:@"%ld",page]};
    } else {
        url = @"wallet/logs";
        dic = @{@"page":[NSString stringWithFormat:@"%ld",page],@"type":self.type};
    }
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:dic version:1 requestMethod:NETWORK_TYPE_GET apiUrl:url onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        [self.tableView.mj_header endRefreshing];
        if (page == 1) {
            self.page = 1;
            [self.listArray removeAllObjects];
        } else {
            self.page++;
        }
        
        NSArray *array = resultDic[@"data"][@"data"];
        for (NSDictionary *dic in array) {
            CommunityRecordModel *model = [[CommunityRecordModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        
        NSInteger last_page = [resultDic[@"data"][@"last_page"] integerValue];
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



@end
