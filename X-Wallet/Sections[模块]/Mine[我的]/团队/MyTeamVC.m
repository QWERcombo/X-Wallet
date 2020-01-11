//
//  MyTeamVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "MyTeamVC.h"
#import "TeamVC.h"
#import "RecommendVC.h"
//models
#import "XWTeamModel.h"
#import "DiscoverBLL.h"

@interface MyTeamVC ()<UIScrollViewDelegate>
/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

/** team */
@property (nonatomic, strong) TeamVC *teamList;
@property (nonatomic, strong) TeamVC *recommendList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger page;


@end

@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"我的团队");
    self.rightView.hidden = YES;
    self.leftBtn.selected = YES;
    self.listArray = [NSMutableArray array];
    _index = 0;
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(40);
    }];
    
    UIView *containerView = [UIView new];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    self.teamList = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TeamVC"];
    [self addChildViewController:self.teamList];
    [containerView addSubview:self.teamList.view];
    [self.teamList.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(containerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    self.recommendList = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TeamVC"];
    [self addChildViewController:self.recommendList];
    [containerView addSubview:self.recommendList.view];
    [self.recommendList.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(containerView);
        make.left.equalTo(self.teamList.view.mas_right);
        make.right.equalTo(containerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    
    [self operate];
    
    MJWeakSelf
    
    self.teamList.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getListData:1];
    }];
    self.teamList.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getListData:weakSelf.page+1];
    }];
    
    self.recommendList.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getListData:1];
    }];
    self.recommendList.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getListData:weakSelf.page+1];
    }];
    
    [self getListData:1];
}

- (void)getListData:(NSInteger)page {
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(AppLanguageStringWithKey(@"加载中"))];
    NSString *path = nil;
    NSDictionary *dic = nil;
    if (_index==0) {
        path = @"auth/teams/2";
    }
    else if (_index==1) {
        path = @"auth/teams/1";
    }
    dic = @{@"page":[NSString stringWithFormat:@"%ld",page]};
    
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:dic version:1 requestMethod:NETWORK_TYPE_GET apiUrl:path onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (page == 1) {
            self.page = 1;
            [self.listArray removeAllObjects];
        } else {
            self.page++;
        }
        
        NSArray *array = resultDic[@"data"][@"data"];
        for (NSDictionary *dic in array) {
            XWTeamUserModel *model = [[XWTeamUserModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        
        NSInteger last_page = [resultDic[@"data"][@"last_page"] integerValue];
        if (self.page == last_page) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        if (self.index==0) {
            self.teamList.listArray = self.listArray;
            self.teamList.validNumber = [resultDic[@"data"][@"count_valid"] integerValue];
            self.teamList.totalNumber = [resultDic[@"data"][@"total"] integerValue];
        }
        else if (self.index==1) {
            self.recommendList.listArray = self.listArray;
            self.recommendList.validNumber = [resultDic[@"data"][@"count_valid"] integerValue];
            self.recommendList.totalNumber = [resultDic[@"data"][@"total"] integerValue];
        }
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

- (void)operate {
    
    @weakify(self);
    [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        if (self.index!=0) {
            self.index=0;
            [self getListData:1];
        }
    }];
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        if (self.index!=1) {
            self.index=1;
            [self getListData:1];
        }
    }];
    
    
}

- (UITableView *)tableView {
    if (self.index==0) {
        return self.teamList.tableView;
    }
    else if (self.index==1) {
        return self.recommendList.tableView;
    }
    return nil;
}



@end
