//
//  ExchangeCoinVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExchangeCoinVC.h"
#import "ExchangeRecordVC.h"
#import "DiscoverBLL.h"
#import "ExchangeCoinModel.h"
#import "ExchangeHelpView.h"

@interface ExchangeCoinVC ()

@property (weak, nonatomic) IBOutlet UIImageView *saleImg;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UITextField *saleTF;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *buyImg;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UITextField *buyTF;
@property (weak, nonatomic) IBOutlet UILabel *huilvLab;
@property (weak, nonatomic) IBOutlet UILabel *feeLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *noteBtn;
@property (weak, nonatomic) IBOutlet UILabel *canuseLan;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;



@property (nonatomic, strong) ExchangeCoinModel *exchangeModel;
@property (nonatomic, assign) float huilvFloat;
@end

@implementation ExchangeCoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = AppLanguageStringWithKey(@"币兑");
    self.doneBtn.enabled = NO;
    self.doneBtn.alpha = 0.5;
    self.buyTF.userInteractionEnabled = NO;
    [self.saleBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.buyBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    @weakify(self);
    [[self.saleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"卖出");
        
    }];
    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"买入");
        
    }];
    [[self.exchangeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
//        x.selected = !x.selected;
        NSLog(@"交换");
    }];
    [[self.noteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [ExchangeHelpView showHelpViewWithContent:AppLanguageStringWithKey(@"闪兑过程需收取2%手续费;\n  成功后即刻存入钱包。")];
    }];
    
    [self.saleTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.buyTF.text = [NSNumber numberWithFloat:x.floatValue*self.huilvFloat].stringValue;
        self.feeLab.text = [NSString stringWithFormat:@"≈%.2f %@", ((CoinModel *)self.exchangeModel.sell.firstObject).commission.floatValue*x.floatValue ,((CoinModel *)self.exchangeModel.buy.firstObject).name];
    }];
    
    RAC(self.doneBtn,enabled) = [RACSignal combineLatest:@[self.saleTF.rac_textSignal,self.buyTF.rac_textSignal] reduce:^id _Nonnull(NSString *saleCount, NSString *buyCount){
        @strongify(self);
        if (saleCount.length && buyCount.length) {
            self.doneBtn.alpha = 1;
        } else {
            self.doneBtn.alpha = 0.5;
        }
        return @(saleCount.length && buyCount.length);
    }];
    [[self.doneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
//        ExchangeRecordVC *record = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"ExchangeRecordVC"];
//        [self.navigationController pushViewController:record animated:YES];
        [self showTextFieldAlertWithHandler:^(NSString * _Nonnull psd) {
            [self loading];
            [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{@"left_wallet_id":((CoinModel *)self.exchangeModel.buy.firstObject).id,@"right_wallet_id":((CoinModel *)self.exchangeModel.sell.firstObject).id,@"left_number":self.saleTF.text,@"pay_password":psd} version:1 requestMethod:NETWORK_TYPE_POST apiUrl:@"wallet/conversion" onSuccess:^(NSDictionary * _Nonnull resultDic) {
                [self hideLoading];
                [self promptReqSuccess:AppLanguageStringWithKey(@"兑换成功") promptCompletion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } onNetWorkFail:^(NSString * _Nonnull msg) {
                [self promptMsg:msg];
            } onRequestTimeOut:^{
                [self promptRequestTimeOut];
            }];
        }];
        
    }];
    
    [self setTheme];
    self.tableView.tableFooterView = [UIView new];
    [self getListData];
}

- (void)getListData {
    
    [self loading];
    [[DiscoverBLL sharedDiscoverBLL] executeTaskWithDic:@{} version:1 requestMethod:NETWORK_TYPE_GET apiUrl:@"wallet/getCanConversionLists" onSuccess:^(NSDictionary * _Nonnull resultDic) {
        [self hideLoading];
                
        self.exchangeModel = [[ExchangeCoinModel alloc] initWithDictionary:resultDic[@"data"] error:nil];
        
        CoinModel *sellModel = self.exchangeModel.buy.firstObject;
        [self.saleImg sd_setImageWithURL:[NSURL URLWithString:sellModel.logo]];
        [self.saleBtn setTitle:sellModel.name forState:UIControlStateNormal];
        self.canuseLan.text = [NSString stringWithFormat:@"%@：%@%@",AppLanguageStringWithKey(@"可用余额"),self.exchangeModel.info.change_balance,self.exchangeModel.info.currency_name];
        
        CoinModel *buyModel = self.exchangeModel.sell.firstObject;
        [self.buyImg sd_setImageWithURL:[NSURL URLWithString:buyModel.logo]];
        [self.buyBtn setTitle:buyModel.name forState:UIControlStateNormal];
        self.huilvFloat = (sellModel.usdt_price.floatValue/buyModel.usdt_price.floatValue);
        self.huilvLab.text = [NSString stringWithFormat:@"1 %@ ≈ %f %@", sellModel.name,self.huilvFloat,buyModel.name];
        self.feeLab.text = [NSString stringWithFormat:@"≈0 %@",sellModel.name];
        
    } onNetWorkFail:^(NSString * _Nonnull msg) {
        [self promptMsg:msg];
    } onRequestTimeOut:^{
        [self promptRequestTimeOut];
    }];
    
}

- (void)setTheme {
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label2.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label3.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.canuseLan.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.huilvLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.feeLab.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    
    [self.buyBtn setTitleColorPicker:IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3) forState:UIControlStateNormal];
    [self.saleBtn setTitleColorPicker:IXColorPickerWithRGB(kTextBlack3,kWhiteR,kTextBlack3,kTextBlack3) forState:UIControlStateNormal];
    
    self.saleTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.saleTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.buyTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
}



@end
