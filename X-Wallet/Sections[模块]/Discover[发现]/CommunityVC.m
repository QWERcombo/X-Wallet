//
//  CommunityVC.m
//  X-Wallet
//
//  Created by 赵越 on 2019/11/27.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityListCell.h"
#import "DiscoverBLL.h"
#import "CommunityModel.h"
#import "RuleView.h"
#import "CommunityRecordVC.h"

@interface CommunityVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *ruleBtn;
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UIImageView *levelImg;
@property (weak, nonatomic) IBOutlet UILabel *level1Lab;
@property (weak, nonatomic) IBOutlet UILabel *personContract;
@property (weak, nonatomic) IBOutlet UILabel *teamNum;
@property (weak, nonatomic) IBOutlet UILabel *teanValue;
@property (weak, nonatomic) IBOutlet UILabel *totalXcn;
@property (weak, nonatomic) IBOutlet UILabel *totalIncome;
@property (weak, nonatomic) IBOutlet UILabel *personIncome;
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
@property (weak, nonatomic) IBOutlet UILabel *teamIncome;
@property (weak, nonatomic) IBOutlet UILabel *teamtodayIncome;
@property (weak, nonatomic) IBOutlet UILabel *gameLab;
@property (weak, nonatomic) IBOutlet UILabel *shopLab;
@property (weak, nonatomic) IBOutlet UILabel *tradeLab;
@property (weak, nonatomic) IBOutlet UILabel *daishu;
@property (weak, nonatomic) IBOutlet UILabel *fenhong;
@property (weak, nonatomic) IBOutlet UILabel *trade1;
@property (weak, nonatomic) IBOutlet UILabel *game1;
@property (weak, nonatomic) IBOutlet UILabel *shop1;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIImageView *img0;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;


@property (nonatomic, strong) CommunityModel *model;
@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"社区");
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    
    [[self.ruleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [RuleView showRuleViewWithTitle:AppLanguageStringWithKey(@"社区规则") content:AppLanguageStringWithKey(@"会员等级介绍：\n会员等级是基于用户通过分享智能合约并达到相应的等级门槛即可升级。\n\n会员等级福利：\n升级不同的会员等级即可解锁更多的不同福利奖励。如下 :\ni. 更多的分享代数奖励\nii. 上拿领导人团队总收益\niii. 整个组织收益佣金\n\n会员等级降级 ：\n用户须同时附合三个考核条件（分享人数，团队总市值，三区考核等级）；若其中一项失效，将自动降级。\n\n会员等级列表 ：\na.初级节点\nb.中级节点\nc.高级节点\nd.超级节点\ne.环球节点\n\n**更多详细参阅分享动态\n\n备注 ：\n1. 用户须在24小时内登录钱包点击领取动态收益 ; 超时即视为失效。\n2. 每一笔动态收益将自动扣取20%管理费并分配为佣金给予节点。\n\n温馨提示 ：\n数字资产是创新型投资品，价格波动较大，具有较高的投资风险。投资前望您对数字资产充分认知，理性判断投资能力，审慎做出投资决策。")];
    }];
    
    self.levelLab.text = UserData.share.currentUser.level_name_new.info;
    self.level1Lab.text = UserData.share.currentUser.level_name_new.info;
    self.levelImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"com_level_%@",UserData.share.currentUser.user_level]];
    
    [self setTheme];
    [self getListData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityListCell *cell = [CommunityListCell initCell:tableView cellName:@"CommunityListCell" dataObjc:[self.listArray objectAtIndex:indexPath.row]];
    
    cell.showImg.image = [UIImage imageNamed:self.listArray[indexPath.row][@"img"]];
    cell.showLeft.text = self.listArray[indexPath.row][@"text"];
    cell.showRight.text = self.listArray[indexPath.row][@"value"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommunityListCell tableViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    
    
}


- (void)getListData {
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"contract/team_info" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        self.model = [[CommunityModel alloc] initWithDictionary:resultDic[@"data"] error:nil];
        
        self.personContract.text = self.model.contract_my;
        self.teamNum.text = self.model.team_number;
        self.teanValue.text = self.model.team_money;
        
        self.todayIncome.text = [NSString stringWithFormat:@"≈$%.4f",self.model.income_my_today.floatValue];
        self.teamtodayIncome.text = [NSString stringWithFormat:@"≈$%.4f",self.model.income_team_today.floatValue];
        self.tradeLab.text = [NSString stringWithFormat:@"≈$%.4f",self.model.commission.floatValue];
        self.gameLab.text = [NSString stringWithFormat:@"≈$%.4f",self.model.commission_game.floatValue];
        self.shopLab.text = [NSString stringWithFormat:@"≈$%.4f",self.model.commission_goods.floatValue];
        self.daishu.text = [NSString stringWithFormat:@"≈$%.4f",self.model.daishu.floatValue];
        self.fenhong.text = [NSString stringWithFormat:@"≈$%.4f",self.model.weight.floatValue];
        self.trade1.text = [NSString stringWithFormat:@"≈$%.4f",self.model.sideways.floatValue];
        self.game1.text = [NSString stringWithFormat:@"≈$%.4f",self.model.sideways.floatValue];
        self.shop1.text = [NSString stringWithFormat:@"≈$%.4f",self.model.sideways.floatValue];
        /** 个人 */
        self.personIncome.text = [NSString stringWithFormat:@"≈$%.4f", self.model.income_my.floatValue];
        /** 团队 */
        self.teamIncome.text = [NSString stringWithFormat:@"≈$%.4f", [self.shop1.text substringFromIndex:2].doubleValue+[self.shopLab.text substringFromIndex:2].doubleValue+[self.fenhong.text substringFromIndex:2].doubleValue+[self.daishu.text substringFromIndex:2].doubleValue+[self.gameLab.text substringFromIndex:2].doubleValue+[self.tradeLab.text substringFromIndex:2].doubleValue];
        /** 总收益 */
        self.totalXcn.text = [NSString stringWithFormat:@"=$%.4f",([self.teamIncome.text substringFromIndex:2].doubleValue+[self.personIncome.text substringFromIndex:2].doubleValue)];
        
        
        [self.tableView reloadData];
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 101 || sender.tag == 103) {
        return;
    }
    
    CommunityRecordVC *record = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"CommunityRecordVC"];
    if (sender.tag == 102) {
        record.isTeam = YES;
    } else {
        record.isTeam = NO;
        if (sender.tag == 100) {
            record.type = @"16";
        } else if (sender.tag == 104) {
            record.type = @"9";
        } else if (sender.tag == 105) {
            record.type = @"19";
        } else if (sender.tag == 106 || sender.tag == 107 || sender.tag == 108) {
            record.type = @"17";
        } else if (sender.tag == 109 || sender.tag == 110 || sender.tag == 111) {
            record.type = @"18";
        }
    }
    [self.navigationController pushViewController:record animated:YES];
}

- (void)setTheme {
    self.view.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kContentBgN,kLightGrayF5,kLightGrayF5);
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label3.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label4.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.levelLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.personIncome.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.todayIncome.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.teamIncome.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.teamtodayIncome.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.daishu.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.fenhong.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.tradeLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.trade1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shopLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.shop1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.gameLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.game1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view2.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view3.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view4.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view5.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view6.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    self.view7.backgroundColorPicker = IXColorPickerWithRGB(kWhiteR,kMineShowN,kWhiteR,kWhiteR);
    
    self.img0.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_0"],[UIImage imageNamed:@"com_icon_0N"],[UIImage imageNamed:@"com_icon_0"],[UIImage imageNamed:@"com_icon_0"]);
    self.img1.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_1"],[UIImage imageNamed:@"com_icon_1N"],[UIImage imageNamed:@"com_icon_1"],[UIImage imageNamed:@"com_icon_1"]);
    self.img2.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_2"],[UIImage imageNamed:@"com_icon_2N"],[UIImage imageNamed:@"com_icon_2"],[UIImage imageNamed:@"com_icon_2"]);
    self.img3.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_3"],[UIImage imageNamed:@"com_icon_3N"],[UIImage imageNamed:@"com_icon_3"],[UIImage imageNamed:@"com_icon_3"]);
    self.img4.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_2"],[UIImage imageNamed:@"com_icon_2N"],[UIImage imageNamed:@"com_icon_2"],[UIImage imageNamed:@"com_icon_2"]);
    self.img5.imagePicker = IXImagePickerWithImages([UIImage imageNamed:@"com_icon_3"],[UIImage imageNamed:@"com_icon_3N"],[UIImage imageNamed:@"com_icon_3"],[UIImage imageNamed:@"com_icon_3"]);
}

@end
