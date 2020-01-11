//
//  InvestmentDetailVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "InvestmentDetailVC.h"
#import "YBPopupMenu.h"
#import "DiscoverBLL.h"
#import "WalletModel.h"
#import "InvestItemCell.h"

@interface InvestmentDetailVC ()<YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UILabel *canuseLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIView *view2;





@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) WalletModel *model;
@end

@implementation InvestmentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSMutableArray array];
    self.coinName.text = AppLanguageStringWithKey(@"请选择");
    self.canuseLab.text = [NSString stringWithFormat:@"%@：0",AppLanguageStringWithKey(@"可用余额")];
    self.moneyLab.text = @"≈$0";
    
    @weakify(self);
    [[self.coinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        [YBPopupMenu showRelyOnView:x titles:self.listArray icons:nil menuWidth:SCREEN_WIDTH-30 otherSettings:^(YBPopupMenu *popupMenu) {

            popupMenu.delegate = self;

        }];
    }];
    
    
    [self.countTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        
        self.moneyLab.text = [NSString stringWithFormat:@"≈$%@",[NSNumber numberWithFloat:[self.model.currency[@"usdt_price"]floatValue]*[x floatValue]]];
    }];
    
    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if ([self.coinName.text isEqualToString:AppLanguageStringWithKey(@"请选择")]) {
            [self promptMsg:AppLanguageStringWithKey(@"请选择币种")];
            return ;
        }
        if (!self.countTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入数量")];
            return ;
        }
        if (self.countTF.text.floatValue > self.model.change_balance.floatValue) {
            [self promptMsg:AppLanguageStringWithKey(@"可用余额不足")];
            return;
        }
        if (!self.codeTF.text.length) {
            [self promptMsg:AppLanguageStringWithKey(@"请输入交易密码")];
            return ;
        }
        
        [self loading];
        NSDictionary *paraDic = @{@"mill_id":self.model.currency_id,@"pay_password":self.codeTF.text,@"number":self.countTF.text,@"contract_id":self.inv_id};
        [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:paraDic version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"mill/pay" onSuccess:^(NSDictionary * _Nonnull resultDic) {
            [self hideLoading];
            [self promptReqSuccess:AppLanguageStringWithKey(@"购买成功")];
            [self.navigationController popViewControllerAnimated:YES];
        } onNetWorkFail:^(NSString * _Nonnull msg) {
            [self promptMsg:msg];
        } onRequestTimeOut:^{
            [self promptRequestTimeOut];
        }];
        
    }];
    
    [self loading];
    //
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{@"type":self.isVip?@"7":@"1"} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"wallet/wallets" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
        NSArray *array = resultDic[@"data"];
        for (NSDictionary *dic in array) {
            WalletModel *model = [[WalletModel alloc] initWithDictionary:dic error:nil];
            [self.listArray addObject:model];
        }
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
    [self setTheme];
}

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {

    WalletModel *model = [self.listArray objectAtIndex:index];
    self.coinName.text = model.currency_name;
    self.canuseLab.text = [NSString stringWithFormat:@"%@：%@",AppLanguageStringWithKey(@"可用余额"),model.change_balance];
    self.model = model;
}

- (UITableViewCell *)ybPopupMenu:(YBPopupMenu *)ybPopupMenu cellForRowAtIndex:(NSInteger)index {
    
    InvestItemCell *cell = [InvestItemCell initCell:ybPopupMenu.tableView cellName:@"InvestItemCell" dataObjc:@""];
    
    WalletModel *model = [self.listArray objectAtIndex:index];
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.showTitle.text = model.currency_name;
    
    return cell;
}

- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label3.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.coinName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view2.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    
    [self.coinBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    
    self.countTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.countTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
}


@end
