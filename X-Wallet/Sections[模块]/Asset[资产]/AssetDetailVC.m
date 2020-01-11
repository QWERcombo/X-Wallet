//
//  AssetDetailVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "AssetDetailVC.h"
#import "AssetDetailCell.h"
#import "ChargeCoinVC.h"
#import "ExtractCoinVC.h"
#import "YBPopupMenu.h"
#import "InvestmentListVC.h"

#import "DiscoverBLL.h"

//models
#import "XWHomeAssetDetailResponseModel.h"

@interface AssetDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UIButton *shanDuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanZhangBtn;
@property (weak, nonatomic) IBOutlet UIButton *heYueBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg;
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UILabel *coinInfo;
@property (weak, nonatomic) IBOutlet UILabel *coinUse;
@property (weak, nonatomic) IBOutlet UILabel *coinBottom;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIImageView *topImg;

@property (nonatomic, strong) XWHomeAssetDetailResponseModel *model;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger currentType;

@end

@implementation AssetDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coinImg.layer.cornerRadius = 17;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.topImg.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"ass_detail_bg"],[UIImage imageNamed:@"ass_detail_bg"],[UIImage imageNamed:@"ass_detail_bg"],[UIImage imageNamed:@"ass_top_bg_1"]);
    
    self.currentType = 0;
    [self.shanDuiBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.shanDuiBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    [self.zhuanZhangBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.zhuanZhangBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    [self.heYueBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.heYueBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    [self.allBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.allBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    self.shanDuiBtn.hidden = YES;
    self.zhuanZhangBtn.hidden = YES;
    self.heYueBtn.hidden = YES;
    self.listArray = [NSMutableArray array];
    [self operate];
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf p_requestDetailWithPage:0];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf p_requestDetailWithPage:weakSelf.page+1];
    }];
    [self p_requestDetailWithPage:1];
    
    
}

- (void)p_requestDetailWithPage:(NSInteger)page {
    
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(AppLanguageStringWithKey(@"加载中"))];
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",page],@"currency_id":@(self.id),@"type":@(_currentType)};
    
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:dic version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"wallet/wallets_detail" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (page == 1) {
            self.page = 1;
            [self.listArray removeAllObjects];
        } else {
            self.page++;
        }
        
        self.model = [[XWHomeAssetDetailResponseModel alloc] initWithDictionary:resultDic[@"data"] error:nil];

        [self.coinImg sd_setImageWithURL:[NSURL URLWithString:self.model.wallet_info.logo]];
        self.coinName.text = self.model.wallet_info.currency_name;
        self.coinInfo.text = [NSString stringWithFormat:@"1 %@≈%@USDT",self.model.wallet_info.currency_name,self.model.wallet_info.usdt_price];
        self.coinUse.text = [NSString stringWithFormat:@"%@：%@",AppLanguageStringWithKey(@"可用"),self.model.wallet_info.change_balance];
        self.coinBottom.text = [NSString stringWithFormat:@"≈$%@",self.model.wallet_info.doll_balance];
        [self.tableView reloadData];
        
        [self.listArray addObjectsFromArray:self.model.list.data];
        
        NSMutableArray *bottomButtonInfosArray = [NSMutableArray array];
        if (self.model.wallet_info.is_dui) {
            [bottomButtonInfosArray addObject:@{@"title":AppLanguageStringWithKey(@"闪兑"),@"image":@"ass_detail_0"}];
        }
        if (self.model.wallet_info.is_transfer) {
            [bottomButtonInfosArray addObject:@{@"title":AppLanguageStringWithKey(@"转账"),@"image":@"ass_detail_1"}];
        }
        if (self.model.wallet_info.is_recharge) {
            [bottomButtonInfosArray addObject:@{@"title":AppLanguageStringWithKey(@"充币"),@"image":@"ass_detail_3"}];
        }
        if (self.model.wallet_info.is_withdraw) {
            [bottomButtonInfosArray addObject:@{@"title":AppLanguageStringWithKey(@"提币"),@"image":@"ass_detail_4"}];
        }
        if (self.model.wallet_info.is_contract) {
            [bottomButtonInfosArray addObject:@{@"title":AppLanguageStringWithKey(@"合约"),@"image":@"ass_detail_2"}];
        }
        
        NSArray *bottomButtonsArray = @[self.shanDuiBtn,self.zhuanZhangBtn,self.heYueBtn];
        NSInteger index = 0;
        for (NSDictionary *infoDic  in bottomButtonInfosArray) {
            UIButton *button = bottomButtonsArray[index];
            button.hidden = NO;
            [button setTitle:infoDic[@"title"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:infoDic[@"image"]] forState:UIControlStateNormal];
            index++;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWHomeAssetRecordModel *model = self.listArray[indexPath.row];
    AssetDetailCell *cell = [AssetDetailCell initCell:tableView cellName:@"AssetDetailCell" dataObjc:model];
    cell.showTitle.text = model.memo_new.info;
    cell.showTime.text = model.updated_at;
    cell.showContent.text = [NSString stringWithFormat:@"%@ %@",model.value,model.currencies.name];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AssetDetailCell tableViewHeight];
}


- (void)operate {
    
    @weakify(self);
    [[self.allBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSMutableArray *titlesArray = [NSMutableArray array];
        [titlesArray addObject:AppLanguageStringWithKey(@"全部")];
        for (XWHomeAssetTypeModel *typeModel in self.model.show_list) {
            [titlesArray addObject:typeModel.memeo_new.info];
        }
        [YBPopupMenu showRelyOnView:self.allBtn titles:titlesArray icons:nil menuWidth:120.0 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.maxVisibleCount = 7;
            popupMenu.delegate = self;
        }];
    }];
    
    [[self.shanDuiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * _Nullable x) {
        @strongify(self);
        [self p_bottomButtonAction:x];

    }];
    [[self.zhuanZhangBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
       
        [self p_bottomButtonAction:x];

    }];
    [[self.heYueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self p_bottomButtonAction:x];
    }];
    
}

- (void)p_bottomButtonAction:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:AppLanguageStringWithKey(@"闪兑")]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"ExchangeCoinVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:AppLanguageStringWithKey(@"转账")]){
        [SVProgressHUD showInfoWithStatus:AppLanguageStringWithKey(@"暂未开放")];
    }
    else if ([title isEqualToString:AppLanguageStringWithKey(@"充币")]){
        ChargeCoinVC *charge = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ChargeCoinVC"];
        charge.model = self.model.wallet_info;
        [self.navigationController pushViewController:charge animated:YES];
    }
    else if ([title isEqualToString:AppLanguageStringWithKey(@"提币")]){
        ExtractCoinVC *extract = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ExtractCoinVC"];
        extract.model = self.model.wallet_info;
        [self.navigationController pushViewController:extract animated:YES];
        
    }
    else if ([title isEqualToString:AppLanguageStringWithKey(@"合约")]) {
        InvestmentListVC *vc = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"ContractVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - YBPopupMenuDelegate

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    if (index==0) {
        _currentType = 0;
        [self.allBtn setTitle:AppLanguageStringWithKey(@"全部") forState:UIControlStateNormal];
        [self.allBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [self p_requestDetailWithPage:1];
    }
    else {
        XWHomeAssetTypeModel *model = self.model.show_list[index-1];
        _currentType = model.type;
        [self.allBtn setTitle:model.memeo_new.info forState:UIControlStateNormal];
        [self.allBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [self p_requestDetailWithPage:1];
    }
    
}

@end
