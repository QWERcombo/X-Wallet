//
//  ExtractCoinVC.m
//  X-Wallet
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ExtractCoinVC.h"
#import "ExtractRecordVC.h"
#import "ExtractAlertView.h"
//models
#import "XWHomeAssetModel.h"
#import "YBPopupMenu.h"

#import "ScanViewController.h"

@interface ExtractCoinVC ()<YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *selectCoinLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UIImageView *coinImg;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *availLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UILabel *feeLab;
@property (weak, nonatomic) IBOutlet UILabel *getLab;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *captcharTF;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *xcnNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;


@property (nonatomic, strong) XWHomeAssetCurrenciesModel *currenciesModel;

@property (nonatomic, strong) NSArray *coinListArray;

@property (nonatomic, assign) NSInteger coinSelectIndex;

@end

@implementation ExtractCoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppLanguageStringWithKey(@"提币");
    self.tableView.tableFooterView = [UIView new];
    self.doneBtn.layer.cornerRadius = 6;
    _coinSelectIndex = 0;
    
    [self operate];
    [self setTheme];
    
    [self p_requestInfo];
}

- (void)p_requestInfo {
    [NetWork dataTaskWithPath:@"wallet/getCurrencyXcn" requestMethod:NetWorkMethodGet version:1 parameters:nil mapModelClass:[XWHomeAssetCurrenciesModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        self.currenciesModel = responseObject;
    }];
    
    [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"加载中")];
    [NetWork dataTaskWithPath:@"wallet/wallets" requestMethod:NetWorkMethodGet version:1 parameters:@{@"type":@2} mapModelClass:[XWHomeAssetModel class] responsePath:kWXNetWorkResponsePath completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self promptMsg:error.localizedDescription];
        }
        else {
            self.coinListArray = responseObject;
            NSInteger index = 0;
            for (XWHomeAssetModel *assetModel in self.coinListArray) {
                if (assetModel.currency_id==self.model.currency_id) {
                    self.coinSelectIndex = index;
                }
                index ++;
            }
            
            [self p_updatePageInfo];
        }
    }];
    
     
     
}

- (void)p_updatePageInfo {
    XWHomeAssetModel *coinModel = self.coinListArray[self.coinSelectIndex];
    [self.coinImg sd_setImageWithURL:[NSURL URLWithString:coinModel.logo]];
    self.coinName.text = coinModel.currency_name;
    self.availLab.text = [NSString stringWithFormat:@"%@%@ %@",AppLanguageStringWithKey(@"可用"),coinModel.change_balance,coinModel.currency_name];
    self.inputTF.text = @"";
    self.addressTF.text = @"";
    self.unitLab.text = coinModel.currency_name;
    self.feeLab.text = [NSString stringWithFormat:@"%@（$0.0）",AppLanguageStringWithKey(@"手续费")];
    self.xcnNumberLabel.text = @"";
}


- (void)operate {
    
    @weakify(self);
    
    [[self.recordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ExtractRecordVC *record = [[UIStoryboard storyboardWithName:@"Asset" bundle:nil] instantiateViewControllerWithIdentifier:@"ExtractRecordVC"];
        [self.navigationController pushViewController:record animated:YES];
    }];
    
    UITapGestureRecognizer *scanTapGes = [UITapGestureRecognizer new];
    self.scanImageView.userInteractionEnabled = YES;
    [scanTapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        ScanViewController *scanViewController = [[ScanViewController alloc] init];
        scanViewController.didScanResult = ^(ScanViewController *scanVC, NSString * _Nonnull result) {
            self.addressTF.text = result;
            [scanVC dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:scanViewController animated:YES completion:nil];
    }];
    [self.scanImageView addGestureRecognizer:scanTapGes];

    
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    self.selectCoinLabel.userInteractionEnabled = YES;
    [tapGes.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        
        NSMutableArray *array = @[].mutableCopy;
        for (XWHomeAssetModel *model in self.coinListArray) {
            [array addObject:model.currency_name];
        }
        
        [YBPopupMenu showRelyOnView:self.selectCoinLabel titles:array icons:nil menuWidth:160.0 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.delegate = self;
            
        }];
    }];
    [self.selectCoinLabel addGestureRecognizer:tapGes];
    
    
    
    [self.inputTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        [self p_calulateFee];
    }];
    
    [[self.allBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"全部");
        XWHomeAssetModel *coinModel = self.coinListArray[self.coinSelectIndex];
        self.inputTF.text = coinModel.change_balance;
        [self p_calulateFee];
    }];
    
    [self.codeTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入密码%@", x);
    }];
    
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
       [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"获取中")];
        [NetWork dataTaskWithPath:@"auth/code" requestMethod:NetWorkMethodPost version:1 parameters:@{@"phone":[UserData getPhone],@"type":@"tibi"} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
                      [SVProgressHUD dismiss];
                      if (error) {
                          [self promptMsg:error.localizedDescription];
                      }
                      else {
                          [self promptReqSuccess:AppLanguageStringWithKey(@"验证码已发送")];
                      }
                      //开始倒计时
                      [self.codeBtn setEnabled:NO];
                      [self.codeBtn setTitle:@"60s" forState:UIControlStateDisabled];
                      [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_codeTimerAction) userInfo:nil repeats:YES];
                  }];
        
    }];
    
    [[self.doneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XWHomeAssetModel *coinModel = self.coinListArray[self.coinSelectIndex];
        [SVProgressHUD showWithStatus:AppLanguageStringWithKey(@"提现中")];
        [NetWork dataTaskWithPath:@"wallet/tibi" requestMethod:NetWorkMethodPost version:1 parameters:@{@"currency_id":@(coinModel.currency_id),@"number":self.inputTF.text,@"to_address":self.addressTF.text,@"pay_password":self.codeTF.text,@"code":self.captcharTF.text} mapModelClass:nil responsePath:nil completionHandler:^(id  _Nullable responseObject, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            if (error) {
                [self promptMsg:error.localizedDescription];
            }
            else {
                [self promptReqSuccess:AppLanguageStringWithKey(@"提现成功")];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
//        [ExtractAlertView showExtractAlertViewWithInfo:@"-100" address:@"222" time:@"333" status:@"111"];
        
    
        
    }];
    
}

- (void)p_calulateFee {
    XWHomeAssetModel *coinModel = self.coinListArray[self.coinSelectIndex];

    double fee = [self.inputTF.text doubleValue] * coinModel.currency.usdt_price * coinModel.currency.rate / 100.0 ;
    self.feeLab.text = [NSString stringWithFormat:@"%@（$%g）",AppLanguageStringWithKey(@"手续费"),fee];
    self.xcnNumberLabel.text = [NSString stringWithFormat:@"%g",fee/self.currenciesModel.usdt_price];
}

- (void)p_codeTimerAction {
    NSInteger second = [[self.codeBtn titleForState:UIControlStateDisabled] integerValue];
    if (second<=0) {
        self.codeBtn.enabled = YES;
    }
    else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%zds",second-=1] forState:UIControlStateDisabled];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.mj_h;
}

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    self.coinSelectIndex = index;
    [self p_updatePageInfo];
}

- (void)setTheme {
    
    self.label0.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.label1.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    self.coinName.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.allBtn setTitleColorPicker:IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR) forState:UIControlStateNormal];
    
    self.view0.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view1.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view2.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view3.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view4.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    self.view5.backgroundColorPicker = IXColorPickerWithRGB(kLightGrayF5,kMineShowN,kLightGrayF5,kLightGrayF5);
    
    self.addressTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.addressTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.captcharTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.captcharTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    self.codeTF.textColorPicker = IXColorPickerWithRGB(kBlackR,kWhiteR,kBlackR,kBlackR);
    [self.codeTF setValue:kMainText9Color forKeyPath:@"placeholderLabel.textColor"];
    
}

@end
