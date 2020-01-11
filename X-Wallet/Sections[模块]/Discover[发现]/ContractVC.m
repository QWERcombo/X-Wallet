//
//  ContractVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ContractVC.h"
#import "ContractListCell.h"
#import "InvestmentListVC.h"
#import "DiscoverBLL.h"
#import "CancelContractView.h"
#import "RuleView.h"
#import "ContractModel.h"

@interface ContractVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *ruleBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *listBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *touziBtn;
@property (weak, nonatomic) IBOutlet UILabel *zongTouZiLab;
@property (weak, nonatomic) IBOutlet UILabel *todayLab1;
@property (weak, nonatomic) IBOutlet UILabel *todayLab2;
@property (weak, nonatomic) IBOutlet UILabel *totalLab1;
@property (weak, nonatomic) IBOutlet UILabel *totalLab2;
@property (weak, nonatomic) IBOutlet UIImageView *topBgImgv;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;


@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation ContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"合约");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.status = @"0";
    
    self.leftBtn.selected = YES;
    self.leftView.hidden = NO;
    [self.listBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    [self.listBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    self.topBgImgv.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"con_bg"],[UIImage imageNamed:@"con_bg"],[UIImage imageNamed:@"con_bg_2"],[UIImage imageNamed:@"con_bg_3"]);
    self.iconImg.imagePicker = IXImagePickerWithImages([UIImage new],[UIImage new],[UIImage imageNamed:@"con_0"],[UIImage imageNamed:@"con_00"]);
    
    @weakify(self);
    [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        self.leftView.hidden = NO;
        self.midView.hidden = YES;
        self.rightView.hidden = YES;
        self.leftBtn.selected = YES;
        self.midBtn.selected = NO;
        self.rightBtn.selected = NO;
        self.status = @"0";
        [self getListData];
    }];
    [[self.midBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        self.leftView.hidden = YES;
        self.midView.hidden = NO;
        self.rightView.hidden = YES;
        self.leftBtn.selected = NO;
        self.midBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.status = @"1";
        [self getListData];
    }];
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        self.leftView.hidden = YES;
        self.midView.hidden = YES;
        self.rightView.hidden = NO;
        self.leftBtn.selected = NO;
        self.midBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.status = @"2";
        [self getListData];
    }];
    
    
    [[self.touziBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        InvestmentListVC *vc = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"InvestmentListVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.ruleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [RuleView showRuleViewWithTitle:AppLanguageStringWithKey(@"智能合约规则") content:AppLanguageStringWithKey(@"1. 最低认购额为价值100美金 ; 500美金即为有效用户。\n\n认购配套如下：\n7天 ： 0.20%-0.43%\n15天 ：0.27%-0.53%\n30天 ：0.30%-0.60%\n90天 ：0.43%-0.67%\n45天 : 0.6% - 1.0%\n\n2. 认购智能合约配套成功后，用户将在隔日起获得'XCN'为每日收益奖励。\n\n3.合约到期后，本金将自动返回钱包。\n\n4. XCN即可进入“币兑”，进行闪兑并兑取主流货币。\n\n备注 ：\n1. 每一笔合约日收益将自动扣取20%管理费并分配为佣金给予节点。\n2.一个账号可同时认购多个智能合约配套，封顶额为价值5万美金。\n3.45天配套即限使用XCN认购。\n4.提早结束合约，将视为违约并根据𣎴同的配套收取一定的违约金。\n\n温馨提示：\n数字资产获利回收需要一定的周期。在此期间发生的任何数字资产流动风险，我平台不承担任何责任。用户须具备投资风险意识及风险识别能力，并自行承担投资风险。")];
    }];
    
    
    [self getListData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContractListCell *cell = [ContractListCell initCell:tableView cellName:@"ContractListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ContractListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.status isEqualToString:@"0"]) {
        
        ContractModel *model = [self.listArray objectAtIndex:indexPath.row];
        @weakify(self);
        [CancelContractView showCancelContractView:[NSString stringWithFormat:@"%@%@%@1%%。",AppLanguageStringWithKey(@"提前取消将收取投资额的"),[NSString getContractCancelFee:model.contract_day],AppLanguageStringWithKey(@"违约金；到期则")] feeStr:[NSString getContractCancelFee:model.contract_day] block:^(BOOL isDone) {
            @strongify(self);
            ContractModel *model = [self.listArray objectAtIndex:indexPath.row];
            [self loading];
            [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{@"contract_id":model.id} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"contract/breakContracts" onSuccess:^(NSDictionary * _Nonnull resultDic) {
                [self hideLoading];
                
                [self promptReqSuccess:AppLanguageStringWithKey(@"取消成功") promptCompletion:^{
                    [self getListData];
                }];
            } onNetWorkFail:^(NSString * _Nonnull msg) {
                [self promptMsg:msg];
            } onRequestTimeOut:^{
                [self promptRequestTimeOut];
            }];
        }];
    }
    
}

- (void)getListData {
    
    [self loading];
    RACSignal *infoSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"contract/contract_money" onSuccess:^(NSDictionary * _Nonnull resultDic) {
            [self hideLoading];
            
            self.zongTouZiLab.text = [NSString stringWithFormat:@"≈$%.4f",[resultDic[@"data"][@"investment"]floatValue]];
            self.todayLab1.text = @"";
            self.todayLab2.text = [NSString stringWithFormat:@"≈$%.4f",[resultDic[@"data"][@"today_income"]floatValue]];
            self.totalLab1.text = @"";
            self.totalLab2.text = [NSString stringWithFormat:@"≈$%.4f",[resultDic[@"data"][@"income"]floatValue]];
            
            [subscriber sendNext:@""];
        } onNetWorkFail:^(NSString * _Nonnull msg) {
            [self promptMsg:msg];
        } onRequestTimeOut:^{
            [self promptRequestTimeOut];
        }];
        
        return nil;
    }];
    
    
    RACSignal *listSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //0 收益中 1 已完成
        [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{@"status":self.status} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"contract/myContracts" onSuccess:^(NSDictionary * _Nonnull resultDic) {
            [self hideLoading];
            [self.listArray removeAllObjects];
            
            NSArray *array = resultDic[@"data"];
            for (NSDictionary *dic in array) {
                NSError *error = nil;
                ContractModel *model = [[ContractModel alloc] initWithDictionary:dic error:&error];
                [self.listArray addObject:model];
            }
            
            [subscriber sendNext:@""];
            [self.tableView reloadData];
        } onNetWorkFail:^(NSString * _Nonnull msg) {
            [self promptMsg:msg];
        } onRequestTimeOut:^{
            [self promptRequestTimeOut];
        }];
        
        return nil;
    }];
    
    [self rac_liftSelector:@selector(refreshUI:parm2:) withSignals:infoSignal,listSignal, nil];
}

- (void)refreshUI:(id)parm1 parm2:(id)parm2 {
    [self hideLoading];
    [self.tableView reloadData];
}
@end
