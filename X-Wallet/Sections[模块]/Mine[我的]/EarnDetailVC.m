//
//  EarnDetailVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "EarnDetailVC.h"
#import "EarnDetailCell.h"

//models
#import "XWEarnDetailModel.h"

@interface EarnDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UILabel *totalEarns;
@property (weak, nonatomic) IBOutlet UILabel *todayEarns;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (nonatomic, assign) NSInteger page;
@end

@implementation EarnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"收益明细");
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kContentBgN,kWhiteR,kWhiteR);
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.tableView.tableFooterView = [UIView new];
    self.listArray = [NSMutableArray array];
    [self p_requestInfo];
    
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf p_requestInfo];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf p_requestListWithPage:weakSelf.page+1];
    }];
}

- (void)p_requestInfo {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"contract/account_money" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:nil responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        if (!error) {
            self.totalEarns.text = [NSString stringWithFormat:@"≈$%@",responseObject[@"income"]];
            self.todayEarns.text = [NSString stringWithFormat:@"≈$%@",responseObject[@"today_income"]];
            [self p_requestListWithPage:1];
        }
        else {
            
        }
    }];
    
//    [NetWork dataTaskWithPath:@"wallet/logs" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[XWEarnDetailModel class] responsePath:@"data.data" completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        if (error) {
//            [self promptMsg:error.localizedDescription];
//        }
//        else {
//            self.listArray = [NSMutableArray arrayWithArray:responseObject];
//            [self.tableView reloadData];
//        }
//    }];
}
- (void)p_requestListWithPage:(NSInteger)page {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithURLString:@"wallet/logs" version:1 requestMethod:NETWORK_TYPE_GET parameters:@{@"page":[NSString stringWithFormat:@"%ld", page]} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, URLResponseStatusEnum error) {
        [SVProgressHUD dismiss];
        if (page == 1) {
            self.page = 1;
            [self.listArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            self.page ++;
        }
        NSArray *array = responseObject[@"data"][@"data"];
        for (NSDictionary *dic in array) {
            XWEarnDetailModel *model = [[XWEarnDetailModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        NSInteger last_page = [responseObject[@"data"][@"last_page"] integerValue];
        if (last_page > self.page) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWEarnDetailModel *model = self.listArray[indexPath.row];
    EarnDetailCell *cell = [EarnDetailCell initCell:tableView cellName:@"EarnDetailCell" dataObjc:model];
    cell.showTitle.text = model.memo_new.info;
    cell.showPrice.text = [NSString stringWithFormat:@"$%@",model.number];
    cell.showTime.text = model.updated_at;
    cell.showEarn.text = [NSString stringWithFormat:@"≈%@%@",model.value,model.currencies.name];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EarnDetailCell tableViewHeight];
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
